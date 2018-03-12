from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from getpass import getpass
from suds.plugin import MessagePlugin
import base64
import argparse
import os
import sys
import platform
import pprint
# This is "monkeypatching" SSL due to a certificate error I get using suds-jurko
import ssl
if hasattr(ssl, '_create_unverified_context'):
    ssl._create_default_https_context = ssl._create_unverified_context
# End of SSL "monkeypatch"

# Variable assignments
f = 0
ip, user, pwd = '', '', ''
cucmver = ''
wsdl = ''
loginfo = ''

## This script requires a file with phone and user data separated by comma.
## phone,user

## A log file is generated using the name of the csv file used but ending with .log
## The log file is helpful in determining if any of the entries failed.

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
    parser.add_argument('-f', dest='file', help='Please specify file name with extension.')
    parser.add_argument('-a', dest='sso', help='SSO enabled "true" or "false" - "false is assumed"')
    parser.add_argument('-l', dest='log', help='Log file name.')
    options = parser.parse_args()
    global ip, user, pwd, client, axlver, wsdl, loginfo
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
    if options.sso:
        ssocheck = options.sso
    else:
        ssocheck = "false"
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



    loginfo = "Log File for: " + options.file
    logfilesplit = options.file.split('.')
    logfile =  logfilesplit[0] + '.log'
    print logfile
    with open(options.file, 'r') as f:
        for file_line in f.readlines():
            if file_line == '\n':
                continue
            if ',' in file_line:
                file_line = file_line.split(',')
                phone, userid = file_line[0], file_line[1].rstrip()

            # User Groups to add
            newgroups = [{'name' : 'Standard CCM End Users'}, 
                    {'name' : 'Standard CTI Allow Control of Phones supporting Connected Xfer and conf'},
                    {'name' : 'Standard CTI Allow Control of Phones supporting Rollover Mode'},
                    {'name' : 'Standard CTI Enabled'}]
            # Get User Groups
            newgroupsl = []
            for groupnames in newgroups:
                newgroupsl.append(groupnames['name'])
            userinfo = client.service.getUser(userid=userid)
            usergroup_list_current = userinfo[1]['return'].user.associatedGroups
            usergroup_list_new = {'userGroup':[]}
            usergroup_list_new['userGroup'].append(newgroups)
            for existing_groups in usergroup_list_current[0]:
                if existing_groups.name in newgroupsl:
                    continue
                else:
                    usergroup_list_new['userGroup'].append({'name':existing_groups.name})

            # Get the Phone
            get_phone_resp = client.service.getPhone(name=phone)
            if get_phone_resp[0] != 200:
                print('Skipping ' + phone + 'due to being not found')
                loginfo = loginfo + "\nProblem updating phone - Skipping " + phone
                continue

            # Define the list of associated devices for the user.
            phone = get_phone_resp[1]['return'].phone.name
            associated_devices = [{'device' : phone}]



            # Get the DN Pattern and Partition of the first line from the getPhone query
            dn_pattern = get_phone_resp[1]['return'].phone.lines.line[0].dirn.pattern
            dn_partition = get_phone_resp[1]['return'].phone.lines.line[0].dirn.routePartitionName.value

            # Update the user
            update_user_resp = client.service.updateUser(userid=userid, 
                                associatedDevices=associated_devices, 
                                associatedGroups=usergroup_list_new, 
                                primaryExtension={'pattern' : dn_pattern, 
                                                'routePartitionName' : dn_partition})

            if update_user_resp[0] == 200:
                print ("Success - Updated user %s." % (userid))
                loginfo = loginfo + "\nSuccess - Updated user " + userid
            else:
                print ("Problem updating user %s." % (userid))
                loginfo = loginfo + "\nProblem updating user " + userid

            update_phone_resp = client.service.updatePhone(name=phone, ownerUserName=userid)

            if update_phone_resp[0] == 200:
                print ("Success - Updated phone %s with user %s." % (phone, userid))
                loginfo = loginfo + "\nSuccess - Updated phone " + phone + " with user " + userid
            else:
                print ("Problem updating phone %s with user %s." % (phone, userid))
                loginfo = loginfo + "\nProblem updating phone " + phone + " with user " + userid

    with open(logfile, 'w') as f:
        f.write(loginfo)


if __name__ == '__main__':
    main()
