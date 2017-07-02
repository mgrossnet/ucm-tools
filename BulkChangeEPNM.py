from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from optparse import OptionParser
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

# Find out what version of CUCM we are talking to so we use the
# correct version of the AXL toolkit.
axlver = raw_input("What Version of CUCM? 11.5, 10.5, etc. > ")


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


def setcredentials(ip, user, pwd):
    ip, user, pwd = ip, user, pwd


def dnchange(phone, line):
    update_phone_resp = client.service.updatePhone(name=phone, lines={'line': line})
    if update_phone_resp[0] == 200:
        print ("Success - Changed EPNM on phone %s." % (phone))
    else:
        print ("Problem changing EPNM on phone %s." % (phone))


def main():
    parser = OptionParser()
    parser.add_option('-f', dest='file', help='Please specify file name with extension.')
    (options, args) = parser.parse_args()
    global ip, user, pwd, client
    ip = raw_input("Please Enter the IP Address or Hostname of your CUCM > ")
    user = raw_input("Please Enter Your CUCM User ID > ")
    pwd = getpass("Please Enter Your Password > ")
    setcredentials(ip, user, pwd)
    tns = 'http://schemas.cisco.com/ast/soap/'
    imp = Import('http://schemas.xmlsoap.org/soap/encoding/',
                 'http://schemas.xmlsoap.org/soap/encoding/')
    imp.filter.add(tns)

    location = 'https://' + ip + ':8443/axl/'

    try:
        client = Client(wsdl, location=location, faults=False,
                    plugins=[ImportDoctor(imp)], username=user, password=pwd)
    except:
        print "Error with version or IP address of server. Please try again."
        sys.exit()


    with open(options.file, 'r') as f:
        for dn_dest in f.readlines():
            if ',' in dn_dest:
                dn_dest = dn_dest.split(',')
                # split the current line with a comma into two variables, phone and epnm
                phone, epnm = dn_dest[0], dn_dest[1].rstrip()
                get_phone_resp = client.service.getPhone(name=phone)
                # print get_phone_resp
                try:
                    line = get_phone_resp[1]['return'].phone.lines.line[0]
                except TypeError:
                    print "Error - Check your username and password again."
                    sys.exit()
                except:
                    print "Unknown error occured. Please try again."
                    sys.exit()
                # Update the External Phone Number Mask
                line.e164Mask = epnm
                phone = get_phone_resp[1]['return'].phone.name
                dnchange(phone, line)


if __name__ == '__main__':
    main()
