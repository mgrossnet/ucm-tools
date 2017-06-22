# README for UCM Tools #

This repo is for all of my Cisco UCM tools using Python.
The Cisco AXL SQL Toolkit is required to use the scripts. The scripts will reference the axlsqltoolkit directory under the script location.

## Tools ##

### changeEPNMbulk.py

This tool was created to change the External Phone Number Mask in bulk to a list of phones.

#### Prerequisites

suds-jurko is a required package.

#### Usage

Text file with two values separated by a comma.
The first value is the phone name - SEPBEEFBEEF0001.
The second value is the new External Phone Number Mask - 8005551212.

```
SEPBEEFBEEF0001,8005551212
```

Execute the script with a `-f` followed by the name of the text file with the information required.
`changeEPNMbulk.py -f testfile.txt`