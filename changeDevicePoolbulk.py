from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from getpass import getpass
from optparse import OptionParser
import os
import sys
import platform
# This is monkeypatching SSL due to a certificate error I get using suds-jurko
import ssl
if hasattr(ssl, '_create_unverified_context'):
    ssl._create_default_https_context = ssl._create_unverified_context
# End of SSL monkeypatch

# Variable assignments
f = 0
dnp = ""
ip, user, pwd = '', '', ''
exitcode = 0
cucmver = ''
wsdl = ''



def axltoolkit(axlver):
    # This block checks the path you are in and uses the axlsqltoolkit
    # under the path of the script location.
    fileDir = os.path.dirname(os.path.realpath('__file__'))
    rel_path = 'axlsqltoolkit/schema/' + str(axlver) + '/AXLAPI.wsdl'
    fullfilepath = os.path.join(fileDir, rel_path)
    # If it's Windows we need to fix the backslashes to forward slashes.
    normalizedfilepath = fullfilepath.replace('\\', '/')
    # Join the file path depending on the system
    if platform.system() == 'Windows':
        wsdl = 'file:///' + normalizedfilepath
    else:
        wsdl = 'file://' + normalizedfilepath
    return wsdl



def main():
    parser = OptionParser()
    parser.add_option('-f', dest='file', help='Please specify file name with extension.')
    parser.add_option('-i', dest='host', help='Please specify UCM address.')
    parser.add_option('-u', dest='user', help='Enter Username.')
    parser.add_option('-p', dest='pwd', help='Enter Password.')
    parser.add_option('-v', dest='ver', help='Enter Version.')
    (options, args) = parser.parse_args()
    global ip, user, pwd, client, axlver, wsdl
    if options.ver:
        axlver = options.ver
    else:
        axlver = raw_input("Please Enter the version of the CUCM cluster (10.0, 10.5, 11.0, 11.5) > ")
    if options.host:
        ip = options.host
    else:
        ip = raw_input("Please Enter the IP Address or Hostname of your CUCM > ")
    if options.user:
        user = options.user
    else:
        user = raw_input("Please Enter Your CUCM User ID > ")
    if options.pwd:
        pwd = options.pwd
    else:
        pwd = getpass("Please Enter Your Password > ")
    tns = 'http://schemas.cisco.com/ast/soap/'
    imp = Import('http://schemas.xmlsoap.org/soap/encoding/',
                 'http://schemas.xmlsoap.org/soap/encoding/')
    imp.filter.add(tns) 
    location = 'https://' + ip + ':8443/axl/'
    wsdl = axltoolkit(axlver)
    try:
        client = Client(wsdl, location=location, faults=False,
                    plugins=[ImportDoctor(imp)], username=user, password=pwd)
    except:
        print "Error with version or IP address of server. Please try again."
        sys.exit()
    try:
        verresp = client.service.getCCMVersion()
    except:
        print('Unknown Error. Please try again.')
        sys.exit()
    if verresp[0] == 401:
        print('Authentication failure. Wrong username or password.')
        sys.exit()
    cucmver = verresp[1]['return'].componentVersion.version
    cucmsplitver = cucmver.split('.')
    cucmactualver = cucmsplitver[0] + '.' + cucmsplitver[1]
    print('This cluster is version ' + cucmver)
    if axlver != cucmactualver:
        print('You chose the wrong version. The correct version is ') + cucmactualver
        print('Please choose the correct version next time.')
        sys.exit()
    with open(options.file, 'r') as f:
        for dn_dest in f.readlines():
            if ',' in dn_dest:
                dn_dest = dn_dest.split(',')
                # split the current line with a comma into two variables, phone and DevicePool
                phone, newdevicepool = dn_dest[0], dn_dest[1].rstrip()
                get_phone_resp = client.service.getPhone(name=phone)
            devicepoolval = get_phone_resp[1]['return'].phone.devicePoolName
            devicepoolval.value = newdevicepool
            dpuuidfull = client.service.getDevicePool(name=newdevicepool)
            dpuuidmain = dpuuidfull[1]['return'].devicePool._uuid
            devicepoolval._uuid = dpuuidmain
            update_phone_resp = client.service.updatePhone(name=phone, devicePoolName=devicepoolval)
            if update_phone_resp[0] == 200:
                print ("Success - Changed Device Pool on phone %s." % (phone))
            else:
                print ("Problem changing Device Pool on phone %s." % (phone))



if __name__ == '__main__':
    main()

