#!/bin/bash
#
# Version: 1.0 
# Date: 2019-09-26
# This bash fetches a tagged version from the upstream repository:
#
# Requirements:
# bash shell
# curl
#
# Upstream repository, tag and local target directory
UPSTREAM_URL=https://github.com/nodejs/http-parser
UPSTREAM_TAG=v2.9.2
TARGET_DIR=local

if [ $# -gt 1 ]; then
    echo "Too many parameters specified"
    echo "Usage: $0 [repo-tag]"
    exit
elif [ $# -eq 1 ]; then
    UPSTREAM_TAG=$1
    echo "Downloading from $UPSTREAM_URL tag: $UPSTREAM_TAG"
    echo "removing local ..."
    /bin/rm -rf $TARGET_DIR
elif [ $# -eq 0 ]; then
    echo "Downloading from $UPSTREAM_URL tag: $UPSTREAM_TAG"
fi

# if $TARGET_DIR folder does not exist create it and fetch content
if [ ! -d $TARGET_DIR ]; then
  mkdir $TARGET_DIR
  pushd $TARGET_DIR
  curl -L $UPSTREAM_URL/tarball/$UPSTREAM_TAG | tar xz --strip=1
  popd
fi
