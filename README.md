# GraalVM POC - Java 17, Gradle, JIT and AOT

This project demonstrates how the same Java 17 application can run in two different modes:

1. **JVM/JIT mode** using the normal IntelliJ or Gradle Run button.
2. **GraalVM AOT mode** by compiling the same code into a platform-specific native executable.

The application performs a CPU-heavy workload using prime number calculation, Fibonacci calculation, nested loops, checksum operations, and execution-time measurement.

---

## Tech Stack

- Java 17
- Gradle 9
- GraalVM JDK 17
- GraalVM Native Image
- Visual Studio Build Tools on Windows
- GCC/Clang toolchain on Linux/macOS

---

## Project Structure

```text
hello-graalvm/
├── .gitignore
├── README.md
├── build.gradle
├── settings.gradle
├── gradlew
├── gradlew.bat
├── native-build.bat       # Windows native build helper
├── run-native.bat         # Windows native executable runner
├── native-build.sh        # Linux/macOS native build helper
├── run-native.sh          # Linux/macOS native executable runner
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
└── src/
    └── main/
        └── java/
            └── com/
                └── demo/
                    └── App.java
```

---

## Execution Modes

## 1. Run Using JIT

This is the normal Java execution mode.

When another user opens this project in IntelliJ and clicks the green **Run** button near `main()`, the application runs on the JVM using JIT compilation.

### Run from IntelliJ

Open:

```text
src/main/java/com/demo/App.java
```

Click the green Run button beside:

```java
public static void main(String[] args)
```

### Run from terminal

Windows PowerShell:

```powershell
.\gradlew.bat run
```

Linux/macOS:

```bash
./gradlew run
```

This mode uses:

```text
Java source code -> bytecode -> JVM -> JIT compilation at runtime -> execution
```

---

## 2. Build Using AOT Native Image

This mode compiles the same Java application ahead of time into a native executable.

This mode uses:

```text
Java source code -> bytecode -> GraalVM Native Image -> machine code -> native executable
```

---

## Windows Native Build

Prerequisites:

- GraalVM JDK 17 installed
- `JAVA_HOME` pointing to GraalVM
- Visual Studio Build Tools installed with **Desktop development with C++**

Build native executable:

```powershell
.\native-build.bat
```

Run native executable:

```powershell
.\run-native.bat
```

Generated file:

```text
build\native\nativeCompile\hello-graalvm.exe
```

---

## Linux/macOS Native Build

Prerequisites:

- GraalVM JDK 17 installed
- Native Image available
- GCC/Clang toolchain installed

Make scripts executable if needed:

```bash
chmod +x native-build.sh run-native.sh
```

Build native executable:

```bash
./native-build.sh
```

Run native executable:

```bash
./run-native.sh
```

Generated file:

```text
build/native/nativeCompile/hello-graalvm
```

Note: Windows generates `.exe`. Linux and macOS generate a native binary without `.exe`.

---

## Direct Gradle Commands

JIT run:

```bash
./gradlew run
```

AOT native build:

```bash
./gradlew clean nativeCompile
```

On Windows PowerShell:

```powershell
.\gradlew.bat run
```

For native builds on Windows, prefer:

```powershell
.\native-build.bat
```

because it initializes the Visual Studio x64 compiler environment automatically.

---

## Expected Output

The application prints the current execution mode:

```text
Execution Mode : JVM Mode (JIT compilation enabled at runtime)
```

or:

```text
Execution Mode : AOT Native Image (GraalVM compiled executable)
```

It also prints:

```text
OS
Java version
Java vendor
Available CPUs
Final result
Execution time
```

---

## JIT vs AOT in This Project

| Feature | JIT Run | AOT Native Image |
|---|---|---|
| Command | `gradlew run` | `native-build.bat` / `native-build.sh` |
| Runtime | JVM | Native executable |
| Compilation | During execution | Before execution |
| Startup | Slower than native | Very fast |
| Memory usage | Higher | Lower |
| Output file | No standalone executable | Platform-specific executable |

---

## Important Cross-Platform Note

Native Image does not create the same file for every OS.

| OS | Native output |
|---|---|
| Windows | `hello-graalvm.exe` |
| Linux | `hello-graalvm` |
| macOS | `hello-graalvm` |

To create a native executable for a specific OS, build the project on that OS or use a matching build environment/container.

---

## Why GraalVM Is Beneficial

GraalVM Native Image is useful because it can produce standalone executables with:

- Faster startup time
- Lower memory usage
- No JVM requirement on the target machine
- Better suitability for microservices, serverless functions, CLI tools, and containers

The trade-off is that native image generation takes longer during build time compared to normal JVM execution.

---

## Final Recommended Workflow

For daily development:

```text
Click IntelliJ Run button -> JVM/JIT mode
```

For native executable testing:

Windows:

```text
Double-click native-build.bat
Double-click run-native.bat
```

Linux/macOS:

```text
./native-build.sh
./run-native.sh
```
