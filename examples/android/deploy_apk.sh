#!/bin/sh
. ./android_build_config.mk

# Note - if you get "adb server out of date - killing" you might have two
# adb versions. one in /usr/bin and one in $ANDROID_HOME/platform-tools. 
# Use newer one.

$ANDROID_HOME/platform-tools/adb install -r app/build/outputs/apk/debug/app-debug.apk
