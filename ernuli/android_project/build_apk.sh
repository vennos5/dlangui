#!/bin/sh
# load settings for paths
. ./android_build_config.mk

echo ""
echo "===================================="
echo "DlangUI Build for Android native app"
echo "===================================="
echo "DLANGUI_DIR: $DLANGUI_DIR"
echo "NDK: $NDK"
echo "SDK: $SDK"
echo "LDC: $LDC"

# dlangui sources
. $DLANGUI_DIR/android/dlangui_source_files.mk

# local application sources
. ./android_app.mk

warn () {
    echo "$0:" "$@" >&2
}
die () {
    rc=$1
    shift
    warn "$@"
    exit $rc
}

# LDC2 arm build
. $DLANGUI_DIR/android/android_ldc_armv7a.mk


echo "Updating ant project..."
#=========================================================
$SDK/tools/android update project -p . -s --target $ANDROID_TARGET || die 3 "Android Project update is failed"

echo "Building APK..."
#=========================================================
ant debug || die 4 "Android APK creation is failed"

echo "Successful."
