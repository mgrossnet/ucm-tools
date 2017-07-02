# This is the Python 3 version of the script.

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

# Find out what version of CUCM we are talking to so we use the
# correct version of the AXL toolkit.
axlver = input("What Version of CUCM? 11.5, 10.5, etc. > ")


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



def main():
    global ip,user,pwd,client
    ip = input("Please Enter the IP Address or Hostname of your CUCM > ")
    user = input("Please Enter Your CUCM User ID > ")
    pwd = getpass("Please Enter Your Password > ")
    tns = 'http://schemas.cisco.com/ast/soap/'
    imp = Import('http://schemas.xmlsoap.org/soap/encoding/',
                 'http://schemas.xmlsoap.org/soap/encoding/')
    imp.filter.add(tns) 
    location = 'https://' + ip + ':8443/axl/'
    try:
        client = Client(wsdl, location=location, faults=False,
                    plugins=[ImportDoctor(imp)], username=user, password=pwd)
    except:
        print('Error with version or IP address of server. Please try again.')
        sys.exit()
    partold = input('Current Partition > ')
    partnew = input('New Partition > ')
    while exitcode != 1:
        dntochange = input('Number to be modified? Hit <CR> to exit. > ')
        if dntochange == '':
            break
        resp = client.service.updateLine(pattern=dntochange, routePartitionName = partold, newRoutePartitionName=partnew)
        if resp[0] == 200:
            print ("Success - Changed DN %s to Partition %s." % (dntochange,partnew))
        else:
            print ("Problem finding DN %s in Partition %s" % (dntochange,partold))
            print (resp)



if __name__ == '__main__':
    main()

