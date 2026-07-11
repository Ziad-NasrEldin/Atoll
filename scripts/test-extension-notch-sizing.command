#!/bin/bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEST_BINARY="$(mktemp -d)/ExtensionNotchSizingTests"

swiftc \
  "$ROOT/DynamicIsland/sizing/ExtensionNotchSizing.swift" \
  "$ROOT/Tests/ExtensionNotchSizingTests.swift" \
  -o "$TEST_BINARY"

"$TEST_BINARY"
