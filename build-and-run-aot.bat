@echo off
setlocal
cd /d "%~dp0"

echo ==========================================
echo GraalVM AOT Native Build and Run - Windows
echo ==========================================
echo Project Directory: %CD%
echo.

where java >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java/GraalVM is not installed or not added to PATH.
    echo Please install GraalVM JDK 17 and set JAVA_HOME.
    pause
    exit /b 1
)

where native-image >nul 2>&1
if errorlevel 1 (
    echo ERROR: GraalVM native-image is not installed or not added to PATH.
    echo Please install/enable GraalVM Native Image on your system.
    pause
    exit /b 1
)

set "VS_VCVARS=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

if not exist "%VS_VCVARS%" (
    echo ERROR: Visual Studio C++ Build Tools not found.
    echo Please install Visual Studio Build Tools with:
    echo - Desktop development with C++
    echo - MSVC x64/x86 Build Tools
    echo - Windows SDK
    pause
    exit /b 1
)

echo Initializing Visual Studio x64 tools...
call "%VS_VCVARS%" x64

if errorlevel 1 (
    echo ERROR: Failed to initialize Visual Studio x64 tools.
    pause
    exit /b 1
)

echo.
echo Building GraalVM native executable...
echo.

call "%CD%\gradlew.bat" clean nativeCompile

if errorlevel 1 (
    echo ERROR: Native build failed.
    pause
    exit /b 1
)

if not exist "%CD%\build\native\nativeCompile\hello-graalvm.exe" (
    echo ERROR: Native executable was not generated.
    pause
    exit /b 1
)

echo.
echo Running native executable...
echo.

call "%CD%\build\native\nativeCompile\hello-graalvm.exe"

echo.
echo AOT execution completed successfully.
pause
endlocal