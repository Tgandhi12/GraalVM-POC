# GraalVM JIT vs AOT POC

## Overview

This Proof of Concept (POC) demonstrates the difference between Just-In-Time (JIT) compilation and Ahead-Of-Time (AOT) compilation using Java 21, Gradle, and GraalVM Native Image.

The project provides two execution modes:

1. **JIT Mode** – Runs on the JVM using GraalVM's Just-In-Time compiler.
2. **AOT Mode** – Compiles the application into a standalone native executable using GraalVM Native Image.

The application executes a CPU-intensive workload consisting of prime number calculations, Fibonacci computations, and nested loop processing to demonstrate the behavior of both compilation approaches under a realistic workload.

---

# Tech Stack

* Java 21+
* Gradle 9
* GraalVM JDK 21+
* GraalVM Native Image
* IntelliJ IDEA

---

# Features

* Demonstrates JIT execution using GraalVM JVM
* Demonstrates AOT compilation using GraalVM Native Image
* Cross-platform support (Windows, Linux, macOS)
* CPU-intensive benchmark workload
* Automatic OS detection for native execution
* Gradle Wrapper support (No separate Gradle installation required)

---

# Project Structure

```text
hello-graalvm/
│
├── build.gradle
├── settings.gradle
├── README.md
│
├── build-and-run-aot.bat
├── build-and-run-aot.sh
│
├── gradlew
├── gradlew.bat
│
├── gradle/
│   └── wrapper/
│
└── src/
    └── main/
        └── java/
            └── com/
                └── demo/
                    └── App.java
```

---

# Prerequisites

## For JIT Execution

Install:

* Java 21 or GraalVM JDK 21

Gradle installation is NOT required because the project uses Gradle Wrapper.

---

## For AOT Execution

Install:

### Common

* GraalVM JDK 21
* GraalVM Native Image

### Windows

* Visual Studio Build Tools
* Desktop Development with C++
* Windows SDK

### Linux

```bash
sudo apt install build-essential
```

### macOS

```bash
xcode-select --install
```

---

# Running in JIT Mode

This runs the application using the JVM and GraalVM JIT compiler.

## Windows

```powershell
.\gradlew.bat run
```

## Linux/macOS

```bash
./gradlew run
```

---

# Running in AOT Mode

This compiles the application into a native executable and then runs it.

## Windows

```powershell
.\build-and-run-aot.bat
```

## Linux/macOS

```bash
chmod +x build-and-run-aot.sh
./build-and-run-aot.sh
```

---

# IntelliJ Run Configurations

## Run JIT

Type:

```text
Application
```

Configuration:

```text
Name: Run JIT
Main Class: com.demo.App
```

Execution Flow:

```text
Java Source
    ↓
Bytecode
    ↓
JVM
    ↓
JIT Compilation
    ↓
Execution
```

---

## Run AOT

Type:

```text
Gradle
```

Configuration:

```text
Name: Run AOT
Task: runAot
```

Execution Flow:

```text
Java Source
    ↓
GraalVM Native Image
    ↓
Native Executable
    ↓
Execution
```

---

# OS Detection Logic

The project automatically detects the operating system.

### Windows

```text
runAot
    ↓
build-and-run-aot.bat
```

### Linux

```text
runAot
    ↓
build-and-run-aot.sh
```

### macOS

```text
runAot
    ↓
build-and-run-aot.sh
```

No project path changes are required when cloning the repository to a different system.

---

# Native Executable Location

After successful AOT compilation:

### Windows

```text
build/native/nativeCompile/hello-graalvm.exe
```

### Linux/macOS

```text
build/native/nativeCompile/hello-graalvm
```

---

# Benchmark Workload

The application performs:

* Prime Number Computation
* Fibonacci Computation
* Nested Loop Processing
* Execution Time Measurement

This workload is intentionally CPU-intensive to demonstrate the execution characteristics of both JIT and AOT modes.

---

# Benefits of GraalVM Native Image

* Faster startup time
* Reduced memory consumption
* Standalone executable generation
* No JVM required for execution
* Better deployment experience for microservices and CLI applications

---

# Notes

* Gradle is managed internally through Gradle Wrapper.
* Project paths are fully relative and portable.
* The project can be cloned and executed from any directory.
* Only GraalVM Native Image and OS-specific native compiler tools are required for AOT compilation.
* JIT execution requires only Java 21 or GraalVM JDK 21.

---


