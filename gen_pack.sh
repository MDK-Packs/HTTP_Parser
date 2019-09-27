#!/bin/bash
# Version: 1.1.0 
# Date: 2019-09-26
# This bash script generates a CMSIS Software Pack:
#
# Pre-requisites:
# - bash shell (for Windows: install git for Windows)
# - 7z in path (zip archiving utility)
#   e.g. Ubuntu: sudo apt-get install p7zip-full p7zip-rar) 
# - PackChk in path with execute permission
#   (see CMSIS-Pack: CMSIS/Utilities/<os>/PackChk)
# - xmllint in path (XML schema validation; available only for Linux)
############### EDIT BELOW ###############
# Extend Path environment variable locally
#
# local pack directory
PACK_SOURCE=local
# Pack warehouse directory - destination 
PACK_WAREHOUSE=pack
# make absolute path
PACK_WAREHOUSE=`pwd`/$PACK_WAREHOUSE

#if $PACK_WAREHOUSE directory does not exist create it
if [ ! -d $PACK_WAREHOUSE ]; then
  mkdir -p $PACK_WAREHOUSE
fi

if [ `uname -s` = "Linux" ]
then
  CMSIS_PACK_PATH="/home/$USER/.arm/Packs/ARM/CMSIS/5.6.0/"
  PATH_TO_ADD="$CMSIS_PACK_PATH/CMSIS/Utilities/Linux-gcc-4.8.3/"
else
  CMSIS_PACK_PATH="/C/Keil_v5/ARM/PACK/ARM/CMSIS/5.6.0"
  PATH_TO_ADD="/C/Program Files/7-Zip/:$CMSIS_PACK_PATH/CMSIS/Utilities/Win32/"
fi
[[ ":$PATH:" != *":$PATH_TO_ADD}:"* ]] && PATH="${PATH}:${PATH_TO_ADD}"
echo $PATH_TO_ADD appended to PATH
echo " "

############ DO NOT EDIT BELOW ###########
echo Starting CMSIS-Pack Generation: `date`
# Zip utility check 
ZIP=7z
type -a $ZIP
errorlevel=$?
if [ $errorlevel -gt 0 ]
  then
  echo "Error: No 7zip Utility found"
  echo "Action: Add 7zip to your path"
  echo " "
  exit
fi

# Pack checking utility check
PACKCHK=PackChk
type -a $PACKCHK
errorlevel=$?
if [ $errorlevel != 0 ]
  then
  echo "Error: No PackChk Utility found"
  echo "Action: Add PackChk to your path"
  echo "Hint: Included in CMSIS Pack:"
  echo "<pack_root_dir>/ARM/CMSIS/<version>/CMSIS/Utilities/<os>/"
  echo " "
  exit
fi
echo " "

# change to pack source directory
pushd $PACK_SOURCE
# Locate Package Description file
# check whether there is more than one pdsc file
NUM_PDSCS=`ls -1 *.pdsc | wc -l`
PACK_DESCRIPTION_FILE=`ls *.pdsc`
echo "$NUM_PDSCS"
if [ $NUM_PDSCS -lt 1 ]
then
  echo "Error, no pdsc file found in current directory"
  echo " "
elif [ $NUM_PDSCS -gt 1 ]
then
  echo "Error: Only one pdsc file allowed in directory structure:"
  echo "Found:"
  echo "$PACK_DESCRIPTION_FILE"
  echo "Action: You need to delete superfluous unused pdsc files"
  echo " "
  popd
  exit
else
  echo "Package Description File located"
fi

SAVEIFS=$IFS
IFS=.
set $PACK_DESCRIPTION_FILE
# Pack Vendor
PACK_VENDOR=$1
# Pack Name
PACK_NAME=$2
echo Generating Pack Version: for $PACK_VENDOR.$PACK_NAME
echo " "
IFS=$SAVEIFS

# Run Schema Check (for Linux only):
# sudo apt-get install libxml2-utils
if [ `uname -s` = "Linux" ]
  then
  echo Running schema check for $PACK_VENDOR.$PACK_NAME.pdsc
  xmllint --noout --schema ${CMSIS_PACK_PATH}/CMSIS/Utilities/PACK.xsd $PACK_VENDOR.$PACK_NAME.pdsc
  errorlevel=$?
  if [ $errorlevel -ne 0 ]; then
    echo "build aborted: Schema check of $PACK_VENDOR.$PACK_NAME.pdsc against PACK.xsd failed"
    echo " "
	popd
    exit
  fi
else
  echo "Use MDK PackInstaller to run schema validation for $PACK_VENDOR.$PACK_NAME.pdsc"
fi

# Run Pack Check and generate PackName file with version
$PACKCHK $PACK_VENDOR.$PACK_NAME.pdsc -n PackName.txt -x M362
errorlevel=$?
if [ $errorlevel -ne 0 ]; then
  echo "build aborted: pack check failed"
  echo " "
  popd
  exit
fi

PACKNAME=`cat PackName.txt`
rm -rf PackName.txt

# Archiving
# $ZIP a $PACKNAME
echo creating pack file $PACKNAME
"$ZIP" a $PACK_WAREHOUSE/$PACKNAME -tzip
errorlevel=$?
if [ $errorlevel -ne 0 ]; then
  echo "build aborted: archiving failed"
  popd
  exit
fi

echo "build of pack succeeded"
echo Completed CMSIS-Pack Generation: `date`
