#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "==========================================="
echo "GraalVM Native Image Build - Unix/macOS/Linux"
echo "==========================================="
echo

echo "Building native executable using GraalVM AOT compilation..."
./gradlew clean nativeCompile

echo
echo "SUCCESS: Native executable generated."
echo "Location: build/native/nativeCompile/hello-graalvm"
echo
