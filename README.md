# README for UCM Tools #

This repo is for all of my Cisco UCM tools using Python.
The Cisco AXL SQL Toolkit is required to use the scripts. The scripts will reference the axlsqltoolkit directory under the script location.

All tools in this repo have the following prerequisites:

* suds-jurko package (pip install suds-jurko)
* Cisco axlsqltoolkit (from UCM plugins)
    * This directory should be placed in the same directory the script is in as that is how the script references the axlsqltoolkit.
* User account with AXL access to the UCM server

The tools are named with two different prefixes depending on how the script can be or must be used. The two prefixes are:

- Single
    + This indicates the script is designed to modify one item type at a time.
- Bulk
    + This indicates the script is designed to use an accompanying text file with the data to be modified.

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

```
Usage: BulkChangeEPNM.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.

```

Create a text file with two values separated by a comma.
The first value is the phone name - SEPBEEFBEEF0001.
The second value is the new External Phone Number Mask - 8005551212.

```
SEPBEEFBEEF0001,8005551212
```

Execute the script with a `-f` followed by the name of the text file with the information required.

### BulkChangeSpeedDial.py

This tool was created to change the Speed Dials in bulk to a list of phones.

#### Usage

```
Usage: BulkChangeSpeedDial.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.

```

Create a text file with four values separated by a comma.
The first value is the phone name - SEPBEEFBEEF0001.
The second value is the speed dial number to be replaced - 8005551212.
The third value is the new speed dial number - 1112223333.
The fourth value is the new speed dial label. This fourth value is optional but still requires a comma regardless of whether or not you decide to modify the label.

The second line in the example below demonstrates no modifying the label.

```
SEPBEEFBEEF0001,1112223333,1112223333,Page 3333
SEPBEEFBEEF0001,5551212,1015551212,
SEPBEEFBEEF0001,2223331234,2223331234,Label 1234
```

Execute the script with a `-f` followed by the name of the text file with the information required.

