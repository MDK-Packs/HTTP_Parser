#!/bin/bash
#
# Version: 1.0 
# Date: 2019-09-26
# This bash script copies local contributions into upstream direcctory:
#
# Requirements:
# bash shell
#
TARGET_DIR=local

# Contributions replace files
# CONTRIB_MERGE=./contributions/merge
CONTRIB_MERGE=
# Contributions additional folders/files
CONTRIB_ADD=./contributions/add

# Add contributions to $TARGET_DIR
if [ -n "$CONTRIB_ADD" ]; then
  # add (must not overwrite)
  cp -vr $CONTRIB_ADD/* $TARGET_DIR/
fi

if [ -n "$CONTRIB_MERGE" ]; then
  # Merge (expected to overwrite existing files)
  cp -vrf $CONTRIB_MERGE/* $TARGET_DIR/
fi

# add extension to license file
pushd $TARGET_DIR
cp -f  LICENSE-MIT LICENSE-MIT.txt
popd
