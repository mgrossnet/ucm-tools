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

# File should have the following:
# DeviceName, DN, DNpartition, DNdescription, DNalertingname, DNdisplay


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
                        plugins=[ImportDoctor(imp)],
                        username=user, password=pwd)
    except Exception:
        print "Error with version or IP address of server. Please try again."
        sys.exit()
    try:
        verresp = client.service.getCCMVersion()
    except Exception:
        print('Unknown Error. Please try again.')
        sys.exit()
    if verresp[0] == 401:
        print('Authentication failure. Wrong username or password.')
        sys.exit()
    cucmver = verresp[1]['return'].componentVersion.version
    cucmsplitver = cucmver.split('.')
    cucmactualver = cucmsplitver[0] + '.' + cucmsplitver[1]
    print('This cluster is version ' + cucmver)

    loginfo = "Log File for: " + options.file
    logfilesplit = options.file.split('.')
    logfile = logfilesplit[0] + '.log'
    print logfile

    with open(options.file, 'r') as f:
        for dn_dest in f.readlines():
            if dn_dest == '\n':
                continue
            if ',' in dn_dest:
                dn_dest = dn_dest.split(',')
                phone, dirnum, dnpart, dndesc, dnalertname, dndisplay = dn_dest[0], dn_dest[1], dn_dest[2], dn_dest[3], dn_dest[4], dn_dest[5].rstrip()
                get_phone_resp = client.service.getPhone(name=phone)
                if get_phone_resp[0] != 200:
                    print('Skipping ' + phone + 'due to being not found')
                    loginfo = loginfo + "\nProblem updating phone - Skipping " + phone
                    continue
                try:
                    line = get_phone_resp[1]['return'].phone.lines.line[0]
                except TypeError:
                    print('Skipping ' + phone + 'due to being not found')
                    loginfo = loginfo + "\nProblem updating phone - Skipping " + phone
                    continue
                except Exception:
                    print('Skipping ' + phone + 'due to being not found')
                    loginfo = loginfo + "\nProblem updating phone - Skipping " + phone
                    continue

                # Update the line
                line.display = dndisplay
                line.displayAscii = dndisplay
                phone = get_phone_resp[1]['return'].phone.name
                update_phone_resp = client.service.updatePhone(name=phone, lines={'line': line})
                if update_phone_resp[0] == 200:
                    print ("Success - Changed display on phone %s." % (phone))
                    loginfo = loginfo + "\nSuccess - Updated phone " + phone + " display"
                else:
                    print ("Problem changing display on phone %s." % (phone))
                    loginfo = loginfo + "\nProblem updating phone " + phone

                update_line_resp = client.service.updateLine(pattern=dirnum, routePartitionName = dnpart, description=dndesc, alertingName = dnalertname, asciiAlertingName = dnalertname)
                if update_line_resp[0] == 200:
                    print ("Success - Changed DN %s in Partition %s description and alerting name." % (dirnum, dnpart))
                    loginfo = loginfo + "\nSuccess - Updated phone " + dirnum + " description and alerting name"
                else:
                    print ("Problem finding DN %s in Partition %s" % (dntochange, dnp))
                    loginfo = loginfo + "\nProblem updating line " + dirnum

    with open(logfile, 'w') as f:
        f.write(loginfo)

# File should have the following:
# DeviceName, DN, DNpartition, DNdescription, DNalertingname, DNdisplay


if __name__ == '__main__':
    main()
