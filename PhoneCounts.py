import requests
import xml.etree.ElementTree
from optparse import OptionParser
from requests.auth import HTTPBasicAuth
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from time import localtime, strftime

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

# Base soap/xml info found at https://communities.cisco.com/docs/DOC-59446
# You can add additional models to the dictionary as found in:
# https://developer.cisco.com/site/sxml/documents/api-reference/risport/

# I will try to adapt this to use suds-jurko in the future to make it more pythonic

models = {'622': '7841', '684': '8851', '592': '3905', '484': '7925', '659': '8831', '683': '8841', '685': '8861', '36216': '8821'}
loginfo = ''
modelvaluesorted = []

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
    logfile = options.dir + '/' + CMserver + strftime("-%Y-%m-%d-%H%M%S", localtime()) + '.csv'
else:
    logfile = CMserver + strftime("-%Y-%m-%d-%H%M%S", localtime()) + '.csv'

loginfo = 'Phone Count for ' + CMserver + ' on ' + strftime("%Y-%m-%d at %H:%M:%S", localtime()) + '\n\nModel,Count'

for modelkey, modelvalue in models.iteritems():
    modelvaluesorted.append(modelvalue)
modelvaluesorted.sort()

for modelkey, modelvalue in models.iteritems():

    count = 0
    raw_xml = """<?xml version="1.0" encoding="UTF-8"?>
                <SOAP-ENV:Envelope
                xmlns:ns3="http://www.w3.org/2001/XMLSchema"
                xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
                xmlns:ns0="http://schemas.xmlsoap.org/soap/encoding/"
                xmlns:ns1="http://schemas.cisco.com/ast/soap/"
                xmlns:ns2="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
                SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                <SOAP-ENV:Header/> 
                    <ns2:Body> 
                    <ns1:SelectCmDevice> 
                        <StateInfo xsi:type="ns3:string"></StateInfo> 
                        <CmSelectionCriteria xsi:type="ns1:CmSelectionCriteria"> 
                            <ns1:Class xsi:type="ns3:string">Phone</ns1:Class> 
                            <ns1:Model xsi:type="ns3:unsignedInt">{0}</ns1:Model> 
                            <ns1:SelectBy xsi:type="ns3:string">Name</ns1:SelectBy> 
                        </CmSelectionCriteria> 
                    </ns1:SelectCmDevice> 
                    </ns2:Body> 
                </SOAP-ENV:Envelope>""".format(modelkey)  
    headers={'SOAPAction': '"http://schemas.cisco.com/ast/soap/action/#RisPort#SelectCmDevice"',   
             'Content-Type': 'text/xml; charset=utf-8',   
             'Content-type': 'text/xml; charset=utf-8',   
             'Soapaction': '"http://schemas.cisco.com/ast/soap/action/#RisPort#SelectCmDevice"'}  
    response=requests.post('https://' + CMserver + ':8443/realtimeservice/services/RisPort',data=raw_xml,headers=headers, auth=HTTPBasicAuth(serv_user, serv_pass),verify=False)
    tree = xml.etree.ElementTree.fromstring(response.text)
    CmNodes = tree.find("{http://schemas.xmlsoap.org/soap/envelope/}Body").find("{http://schemas.cisco.com/ast/soap/}SelectCmDeviceResponse").find("SelectCmDeviceResult").find("CmNodes")

    for node in CmNodes:
        for devs in node.find("CmDevices"):
            count = count + 1
    
    if count != 0:
        print 'Phone model ' + modelvalue + ' has ' + str(count) + ' phones registered'
        loginfo = loginfo + '\n' + modelvalue + ',' + str(count)



with open(logfile, 'w') as f:
    f.write(loginfo)


