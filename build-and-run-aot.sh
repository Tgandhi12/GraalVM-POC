#!/bin/bash

cd "$(dirname "$0")"

echo "=========================================="
echo "GraalVM AOT Native Build and Run - Linux/macOS"
echo "=========================================="
echo "Project Directory: $(pwd)"
echo

if ! command -v java >/dev/null 2>&1; then
  echo "ERROR: Java/GraalVM is not installed or not added to PATH."
  echo "Please install GraalVM JDK 17."
  exit 1
fi

if ! command -v native-image >/dev/null 2>&1; then
  echo "ERROR: GraalVM native-image is not installed or not added to PATH."
  echo "Please install/enable GraalVM Native Image on your system."
  exit 1
fi

if ! command -v gcc >/dev/null 2>&1 && ! command -v clang >/dev/null 2>&1; then
  echo "ERROR: Native C compiler not found."
  echo "Linux: install gcc/build-essential."
  echo "macOS: install Xcode Command Line Tools."
  exit 1
fi

chmod +x ./gradlew

echo "Building GraalVM native executable..."
./gradlew clean nativeCompile

if [ $? -ne 0 ]; then
  echo "ERROR: Native build failed."
  exit 1
fi

if [ ! -f "./build/native/nativeCompile/hello-graalvm" ]; then
  echo "ERROR: Native executable was not generated."
  exit 1
fi

echo "Running native executable..."
./build/native/nativeCompile/hello-graalvm

echo
echo "AOT execution completed successfully."