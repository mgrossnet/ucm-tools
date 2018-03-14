from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from suds.plugin import MessagePlugin
import base64
from getpass import getpass
import argparse
import os
import sys
import platform
from pprint import pprint
# This is monkey patching SSL to not validate the certificate
import ssl
if hasattr(ssl, '_create_unverified_context'):
    ssl._create_default_https_context = ssl._create_unverified_context
# End of SSL monkeypatch

# Variable assignments
f = 0
ip, user, pwd = '', '', ''
cucmver = ''
wsdl = ''
exitcode = 0



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
    parser = argparse.ArgumentParser(description='UCM Script Options')
    parser.add_argument('-i', dest='host', help='Please specify UCM address.')
    parser.add_argument('-u', dest='user', help='Enter Username.')
    parser.add_argument('-p', dest='pwd', help='Enter Password.')
    parser.add_argument('-v', dest='ver', help='Enter Version. (10.0, 10.5, 11.0, 11.5)')
    parser.add_argument('-a', dest='sso', help='SSO enabled "true" or "false" - "false is assumed"')
    parser.add_argument('-num', dest='sdin_num', help='Speed Dial Number to be added')
    parser.add_argument('-index', dest='sdin_index', help='Speed Dial placement')
    parser.add_argument('-label', dest='sdin_label', help='Speed Dial Label')
    options = parser.parse_args()
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
    if options.sso:
        ssocheck = options.sso
    else:
        ssocheck = "false"
    if options.sdin_num:
        add_num = options.sdin_num
    else:
        add_num = raw_input("Please Enter Speed Dial number to add > ")
    if options.sdin_label:
        add_label = options.sdin_label
    else:
        add_label = raw_input("Please Enter Speed Dial label to add > ")
    if options.sdin_index:
        add_index = options.sdin_index
    else:
        add_index = raw_input("Please Enter Speed Dial position to add > ")
    tns = 'http://schemas.cisco.com/ast/soap/'
    imp = Import('http://schemas.xmlsoap.org/soap/encoding/',
                 'http://schemas.xmlsoap.org/soap/encoding/')
    imp.filter.add(tns) 
    location = 'https://' + ip + ':8443/axl/'
    wsdl = axltoolkit(axlver)
    if ssocheck == "true":
        base64string = base64.encodestring('%s:%s' % (user, pwd)).replace('\n', '')
        authenticationHeader = {
            "SOAPAction" : "ActionName",
            "Authorization" : "Basic %s" % base64string
        }
        try:
            client = Client(wsdl,location=location,faults=False,plugins=[ImportDoctor(imp)],
                    headers=authenticationHeader)
        except:
            print "Error with version or IP address of server. Please try again."
            sys.exit()

    else:
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
    new_sd = {'dirn':add_num,'label':add_label,'index':add_index}
    while exitcode != 1:
        phone = raw_input('Phone to be modified? Hit <CR> to exit. > ')
        if phone == '':
            break
        get_phone_resp = client.service.getPhone(name=phone)
        try:
            master_speeddial_list = get_phone_resp[1]['return'].phone.speeddials
        except:
            print('Phone not found. Please try again.')
            continue
        if master_speeddial_list == "":
            speeddial_new = {'speeddial':[]}
            speeddial_new['speeddial'].append(new_sd)
        else:
            speeddial_new = {'speeddial':[]}
            speeddial_new['speeddial'].append(new_sd)
            for existing_speeddials in master_speeddial_list[0]:
                if existing_speeddials.index == add_index:
                    continue
                else:
                    speeddial_new['speeddial'].append({'dirn':existing_speeddials.dirn, 'label':existing_speeddials.label, 'index':existing_speeddials.index})
        update_phone_resp = client.service.updatePhone(name=phone, speeddials=speeddial_new)
        if update_phone_resp[0] == 200:
            print ("Success - Updated phone %s speed dial with %s." % (phone,add_num))
            print ("Speed dials on this phone are: ")
            speeddiallist_print = sorted(speeddial_new['speeddial'], key=lambda k: k['index'])
            for spd in speeddiallist_print:
                print("Index: %-2s  Speed Dial: %-15s  Label: %s" % (spd['index'],spd['dirn'],spd['label']))
                # pprint(spd)
        else:
            print ("Problem updating phone %s speed dial with %s" % (phone,add_num))
            print update_phone_resp



if __name__ == '__main__':
    main()


