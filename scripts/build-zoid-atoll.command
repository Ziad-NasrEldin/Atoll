#!/bin/bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DERIVED_DATA="$ROOT/.build/ZoidAtollDerivedData"
BUILD_PRODUCT="$DERIVED_DATA/Build/Products/Release/Atoll.app"
PRODUCT_DIRECTORY="$ROOT/.build/ZoidAtollProduct"
PRODUCT="$PRODUCT_DIRECTORY/Zoid Atoll.app"
INFO_PLIST="$PRODUCT/Contents/Info.plist"

"$ROOT/scripts/test-extension-notch-sizing.command"

xcodebuild \
  -project "$ROOT/DynamicIsland.xcodeproj" \
  -scheme DynamicIsland \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA" \
  -destination "platform=macOS,arch=arm64" \
  PRODUCT_BUNDLE_IDENTIFIER="com.ziadnasreldin.ZoidAtoll" \
  CODE_SIGNING_ALLOWED=NO \
  build

mkdir -p "$PRODUCT_DIRECTORY"
STAGED_PRODUCT="$PRODUCT_DIRECTORY/Zoid Atoll.next.$$.app"
ditto "$BUILD_PRODUCT" "$STAGED_PRODUCT"
if [ -d "$PRODUCT" ]; then
  mv "$PRODUCT" "$PRODUCT_DIRECTORY/Zoid Atoll.previous.$(date +%Y%m%d%H%M%S).app"
fi
mv "$STAGED_PRODUCT" "$PRODUCT"

/usr/libexec/PlistBuddy -c "Add :ZoidCustomHost bool true" "$INFO_PLIST" 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Set :ZoidCustomHost true" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string 'Zoid Atoll'" "$INFO_PLIST" 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName 'Zoid Atoll'" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Delete :SUFeedURL" "$INFO_PLIST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Delete :SUPublicEDKey" "$INFO_PLIST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :SUEnableDownloaderService false" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Set :SUEnableInstallerLauncherService false" "$INFO_PLIST"

codesign --force --deep --sign - "$PRODUCT"
codesign --verify --deep --strict --verbose=2 "$PRODUCT"

printf '%s\n' "$PRODUCT"
