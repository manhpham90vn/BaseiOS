#!/bin/sh

if [ -z "$XCODEGEN_VERSION" ]; then
    XCODEGEN_VERSION=2.33.0
fi

if [ -z "$SWIFTGEN_VERSION" ]; then
    SWIFTGEN_VERSION=6.5.1
fi

if [ -z "$SWIFTLINT_VERSION" ]; then
    SWIFTLINT_VERSION=0.49.1
fi