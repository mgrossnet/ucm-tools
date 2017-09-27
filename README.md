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

### SingleChangeSpeedDial.py

This script allows for modifying speed dials on devices individually. It will ask for the device name, the speed dial number you want to modify, the new speed dial number, and a new label if wanted. The script will let you know if it was successful and provide the option to enter another device name. If you hit enter <CR\> you will be dropped out of the script back to a prompt.

Example:
```
Device? Hit <CR> to exit. > SEPBEEFBEEFBEEF
Number to look for > 1234
Number to replace with > 5678
Label to replace with  (<CR> to keep the same) > New 5678
Success - Changed Speed Dial on phone SEPBEEFBEEFBEEF.
Device? Hit <CR> to exit. >
```

#### Usage
```
Usage: SingleChangeSpeedDial.py [options]

Options:
  -h, --help  show this help message and exit
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.
```

### BulkChangeDNNames.py

This tool was created to change the line description, line alerting name, and line display name fields on a line associated with a device. The line description and line alerting names can be updated with only a DN and partition. The display name (Caller ID) is a function of the line as associated with a device, which is why the input requires a device name. The caveat is currently this will only work properly if the line you are updating is the first line on the device. I might revisit this sometime to make it functional regardless of the line. But be warned for now this is how it functions.

The file to be used with the script should consist of the following comma separated lines:
`Device Name, Directory Number, DN Partition, DN Description, DN Alerting Name, DN Display`

Example:
`SEPBEEFBEEFBEEF,1001,Phone_DN,MyPhoneLineDescription,Test Line,Test Line`

The alerting name and display names update both the normal field and the ascii fields with the assumption you want to set both of them the same.

#### Usage
```
Usage: BulkChangeDNNames.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.

```


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

The file to be used with the script should consist of the following comma separated lines:
`Device Name, External Phone Number Mask`

Example:
`SEPBEEFBEEF0001,8005551212`

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

The file to be used with the script should consist of the following comma separated lines:
`Device Name, Speed Dial to be replaced, New Speed Dial, Speed Dial Label`

The fourth value is the new speed dial label. This fourth value is optional but still requires a comma regardless of whether or not you decide to modify the label. Every line should have 3 commas.

Example:
```
SEPBEEFBEEF0001,1112223333,1112223333,Page 3333
SEPBEEFBEEF0001,5551212,1015551212,
SEPBEEFBEEF0001,2223331234,2223331234,Label 1234
```

### BulkUpdateAD-PhoneUserAssoc.py

This script will take a file formatted as `phone,user` and will update the phone device with the user as the owner and will update the user with the phone as a controlled device. 

#### Usage

```
Usage: BulkUpdateAD-PhoneUserAssoc.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.
```

It also updates the user groups the user is a member of. But currently it doesn't take the existing user groups and append to it, but rather overwrites with the user groups in the script. I am planning on fixing this at some point by using a getUser to pull the current groups in before updating the user.

### BulkChangeDeviceDescription.py

This tool was created to change the device description.

The file to be used with the script should consist of the following comma separated lines:
`Device Name, Device Description`

Example:
`SEPBEEFBEEFBEEF,My Phone Description`

#### Usage
```
Usage: BulkChangeDeviceDescription.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.
```

### BulkChangeDevicePool.py

This tool was created to move a known set of phones to a different Device Pool.

The file to be used with the script should consist of the following comma separated lines:
`Device Name, Device Pool`

Example:
`SEPBEEFBEEFBEEF,DevicePool`

#### Usage
```
Usage: BulkChangeDevicePool.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.
```

### BulkChangeDirectoryNumber.py

This tool was created to change Directory Numbers in bulk.

#### Usage

```
Usage: BulkChangeDirectoryNumber.py [options]

Options:
  -h, --help  show this help message and exit
  -f FILE     Please specify file name with extension.
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -v VER      Enter Version.
```

The file to be used with the script should consist of the following comma separated lines:
`Current DN, Partition, New DN`

Example:
`1234,Phone_P,5678`


### PhoneCounts.py

This tool was created to use the Real-Time Information Port SOAP API to produce reports with how many phones of which type are registered to each server in a cluster. I had taken the idea from an example script I found and rewrote it to use suds-jurko so it's a bit more pythonic. This script can take a while to execute as RIS has some throttle rates which I try to make sure we don't hit. The output will produce a file with the name of the publisher node and a date and timestamp. 

#### Usage

```
Usage: PhoneCounts.py [options]

Options:
  -h, --help  show this help message and exit
  -i HOST     Please specify UCM address.
  -u USER     Enter Username.
  -p PWD      Enter Password.
  -d DIR      Log Directory
```
