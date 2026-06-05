#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

BINARY="build/native/nativeCompile/hello-graalvm"

echo "Running GraalVM Native Executable..."
echo

if [[ -f "$BINARY" ]]; then
  "$BINARY"
else
  echo "ERROR: Native executable not found."
  echo "First run ./native-build.sh to generate it."
  exit 1
fi
