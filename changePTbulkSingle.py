from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from getpass import getpass
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
    global ip, user, pwd, client, axlver, wsdl
    axlver = 'current'
    ip = raw_input("Please Enter the IP Address or Hostname of your CUCM > ")
    user = raw_input("Please Enter Your CUCM User ID > ")
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
        if verresp[0] == 401:
            print('Authentication failure')
        else:
            print('Unknown Error. Please try again.')
        sys.exit()
    cucmvergetver1 = verresp[1]['return'].componentVersion.version
    cucmvergetver2 = cucmvergetver1.split('.')
    axlver = cucmvergetver2[0] + '.' + cucmvergetver2[1]
    print('This cluster is version ' + axlver)
    wsdl = axltoolkit(axlver)
    try:
        client = Client(wsdl, location=location, faults=False,
                    plugins=[ImportDoctor(imp)], username=user, password=pwd)
    except:
        print "Error with version or IP address of server. Please try again."
        sys.exit()
    partold = raw_input('Current Partition > ')
    partnew = raw_input('New Partition > ')
    while exitcode != 1:
        dntochange = raw_input('Number to be modified? Hit <CR> to exit. > ')
        if dntochange == '':
            break
        resp = client.service.updateLine(pattern=dntochange, routePartitionName = partold, newRoutePartitionName=partnew)
        if resp[0] == 200:
            print ("Success - Changed DN %s to Partition %s." % (dntochange,partnew))
        else:
            print ("Problem finding DN %s in Partition %s" % (dntochange,partold))
            print resp



if __name__ == '__main__':
    main()

