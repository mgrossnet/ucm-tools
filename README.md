# README for UCM Tools #

This repo is for all of my Cisco UCM tools using Python.
The Cisco AXL SQL Toolkit is required to use the scripts. The scripts will reference the axlsqltoolkit directory under the script location.

All tools in this repo have the following prerequisites:

* suds-jurko package (pip install suds-jurko)
* Cisco axlsqltoolkit (from UCM plugins)
    * This directory should be placed in the same directory the script is in as that is how the script references the axlsqltoolkit.
* User account with AXL access to the UCM server


## Tools ##

### SingleChangePartition.py

This tool was created to move DNs from one partition to another, one at a time.

#### Usage

You can execute the script without any additional options or with the following options. If you don't include options on the command line you will be prompted with questions.

```
Usage: SingleChangePartition.py [options]

Options:
  -h, --help           show this help message and exit
  -i HOST              Please specify UCM address.
  -u USER              Enter Username.
  -p PWD               Enter Password.
  -v VER               Enter Version. (10.0, 10.5, 11.0, 11.5)
  -c CURRENTPARTITION  Enter current partition
  -n NEWPARTITION      Enter new partition
```

After entering a number you will be provided with a success or failure message. You will then be prompted to enter another number. If you hit enter <CR\> you will be dropped out of the script back to a prompt.

If the DN is found in the "current" partition and there is not already a DN in the "new" partition it will successfully move the DN from the "current" to the "new". If the DN does exist in the "new" partition already it will fail and you should look in the route plan report to figure out what should be moved. In that event this script cannot help you.


### BulkChangeEPNM.py

This tool was created to change the External Phone Number Mask in bulk to a list of phones.

#### Usage

Text file with two values separated by a comma.
The first value is the phone name - SEPBEEFBEEF0001.
The second value is the new External Phone Number Mask - 8005551212.

```
SEPBEEFBEEF0001,8005551212
```

Execute the script with a `-f` followed by the name of the text file with the information required.
`changeEPNMbulk.py -f testfile.txt`


