#!/bin/sh
# Copyright 2013 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
if [ $(uname -s) = 'Darwin' ]; then
  TARGET_DIR=~/Library/Application Support/Google/Chrome/NativeMessagingHosts
  FF_TARGET_DIR=~/.mozilla/native-messaging-hosts
else
  TARGET_DIR=~/.config/google-chrome/NativeMessagingHosts
  FF_TARGET_DIR=~/.mozilla/native-messaging-hosts
fi

HOST_NAME=com.1c.enterprise.addin.example
FF_HOST_NAME=com.1c.enterprise.addin.example.FF
BINDIR=~/bin/AddInChrLin
FILE=AddInChrLinARCHITECTURE
LIBFILE=libAddInNativeLinARCHITECTURE.so
# Create directory to store native messaging host.
mkdir -p $TARGET_DIR
mkdir -p $FF_TARGET_DIR
mkdir -p $BINDIR

# Copy native messaging host manifest.
cp $DIR/$HOST_NAME.json $TARGET_DIR
cp $DIR/$FF_HOST_NAME.json $FF_TARGET_DIR/$HOST_NAME.json
cp $DIR/$FILE $BINDIR
cp $DIR/$LIBFILE $BINDIR

# Update host path in the manifest.
HOST_PATH=$BINDIR/$FILE
sed -i -e "s|HOST_PATH|$HOST_PATH|g" $TARGET_DIR/$HOST_NAME.json
sed -i -e "s|HOST_PATH|$HOST_PATH|g" $FF_TARGET_DIR/$HOST_NAME.json

# Set permissions for the manifest so that all users can read it.
chmod o+r $TARGET_DIR/$HOST_NAME.json
chmod o+r $FF_TARGET_DIR/$HOST_NAME.json

echo Native messaging host $HOST_NAME has been installed.
