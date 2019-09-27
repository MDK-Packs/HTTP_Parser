#!/bin/bash
# Version: 1.0 
# Date: 2019-09-26
# This bash script deletes the TARGET_DIR:
#
# Pre-requisites:
# - bash shell (for Windows: install git for Windows)

TARGET_DIR=local
CURRENT_DIR=`pwd`
echo removing $CURRENT_DIR/$TARGET_DIR
rm -rf $TARGET_DIR
