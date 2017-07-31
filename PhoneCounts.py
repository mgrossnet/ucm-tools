from suds.client import Client
from suds.xsd.doctor import Import
from suds.xsd.doctor import ImportDoctor
from getpass import getpass
from optparse import OptionParser
import os
import sys
import platform
import time
from collections import Counter
# This is monkeypatching SSL due to a certificate error I get using suds-jurko
import ssl
if hasattr(ssl, '_create_unverified_context'):
    ssl._create_default_https_context = ssl._create_unverified_context
# End of SSL monkeypatch

# You can add additional models to the dictionary as found in:
# https://developer.cisco.com/site/sxml/documents/api-reference/risport/
# The sleep timers are designed to keep requests under the 15 per minute
# that the server will enforce for RIS requests.

models = {'622': '7841', '684': '8851', '592': '3905', '484': '7925', '659': '8831', '683': '8841', '685': '8861', '36216': '8821', '336': 'SIP'}
loginfo = ''
modelvaluesorted = []
maclist = ['*0', '*1', '*2', '*3', '*4', '*5', '*6', '*7', '*8', '*9', '*A', '*B', '*C', '*D', '*E', '*F']
requestitr = 0
allphones = {}
totalcount = 0

parser = OptionParser()
parser.add_option('-i', dest='host', help='Please specify UCM address.')
parser.add_option('-u', dest='user', help='Enter Username.')
parser.add_option('-p', dest='pwd', help='Enter Password.')
parser.add_option('-d', dest='dir', help='Log Directory')
(options, args) = parser.parse_args()

if options.host:
    CMserver = options.host
else:
    CMserver = raw_input("Please Enter the IP Address or Hostname of your CUCM > ")
if options.user:
    serv_user = options.user
else:
    serv_user = raw_input("Please Enter Your CUCM User ID > ")
if options.pwd:
    serv_pass = options.pwd
else:
    serv_pass = getpass("Please Enter Your Password > ")
if options.dir:
    logfile = options.dir + '/' + CMserver + time.strftime("-%Y-%m-%d-%H%M%S") + '.csv'
else:
    logfile = CMserver + time.strftime("-%Y-%m-%d-%H%M%S") + '.csv'

loginfo = 'Phone Count for ' + CMserver + ' on ' + time.strftime("%Y-%m-%d at %H:%M:%S") + '\n\n\nServer,Model,Count'

tns = 'http://schemas.cisco.com/ast/soap/'
imp = Import('http://schemas.xmlsoap.org/soap/encoding/','http://schemas.xmlsoap.org/soap/encoding/')
imp.filter.add(tns) 
location = 'https://' + CMserver + ':8443/realtimeservice2/services/RISService70/'
wsdl = 'https://' + CMserver + ':8443/realtimeservice2/services/RISService70?wsdl'
client = Client(wsdl, location=location, username=serv_user, password=serv_pass)


stateInfo = None  
  
criteria = client.factory.create('CmSelectionCriteria')  
item = client.factory.create('SelectItem')  
mod = client.factory.create('CmSelectionCriteria.Model')  
  
criteria.MaxReturnedDevices = 1
criteria.DeviceClass = 'Phone'  
criteria.Model = 255  
criteria.Status = 'Any'  
criteria.NodeName = ''  
criteria.SelectBy = 'Name'  
item.Item = ''  
criteria.SelectItems.item.append(item)  
criteria.Protocol = 'Any'  
criteria.DownloadStatus = 'Any'  

result = client.service.selectCmDevice(stateInfo, criteria)

nodelist = []
for thing in result.SelectCmDeviceResult.CmNodes.item:
    nodelist.append(thing.Name)

criteria.MaxReturnedDevices = 1000
result = client.service.selectCmDevice(stateInfo, criteria)

phoneresults = {}
nodephones = {}

for node in nodelist:
    criteria.NodeName = node
    phoneresults[node] = {}
    for modelkey, modelvalue in models.iteritems():
        criteria.Model = modelkey
        requestitr += 1
        time.sleep(2)
        if requestitr == 15:
            print '\nWaiting due to RIS throttle rate'
            time.sleep(30)
            requestitr = 0
        result = client.service.selectCmDevice(stateInfo, criteria)
        if result.SelectCmDeviceResult.TotalDevicesFound == 0:
            continue
        for thing in result.SelectCmDeviceResult.CmNodes.item:
            currentdevices = thing.CmDevices
            devcount = 0
            for device in currentdevices.item:
                devcount += 1
            # If we hit the max of 1000 phones in a request, search by the ending of the phones
            # This is slow and painful but should allow for all phones to be accounted for
            if devcount >> 999:
                devcount = 0
                print 'Results will take longer as there are more than 1000 devices of a type registered to one server.'
                for macadd in maclist:
                    item.Item = macadd
                    criteria.SelectItems.item = item
                    time.sleep(4)
                    result = client.service.selectCmDevice(stateInfo, criteria)
                    for thing in result.SelectCmDeviceResult.CmNodes.item:
                        currentdevices = thing.CmDevices
                        for device in currentdevices.item:
                            devcount += 1
                item.Item = ''
                criteria.SelectItems.item = item
                requestitr = 0
            phoneresults[node][modelvalue] = devcount
            print 'Server ' + node + ' Phone model ' + modelvalue + ' has ' + str(devcount) + ' phones registered'

for node, nresult in phoneresults.iteritems():
    nodecount = 0
    allphones = Counter(allphones) + Counter(nresult)
    for modelvalue, pnum in nresult.iteritems():
        loginfo = loginfo + '\n' + node + ',' + modelvalue + ',' + str(pnum)
        nodecount += pnum
    nodephones[node] = nodecount

loginfo = loginfo + '\n\n\nTotal Phone Count' 
for modeltype, modeltotal in allphones.iteritems():
    loginfo = loginfo + '\n' + modeltype + ',' + str(modeltotal)

for node, nodecount in nodephones.iteritems():
    loginfo = loginfo + '\n' + node + ',' + str(nodecount)
    totalcount = totalcount + nodecount

loginfo = loginfo + '\nTotal,' + str(totalcount)

with open(logfile, 'w') as f:
    f.write(loginfo)

