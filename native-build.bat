@echo off
setlocal
cd /d "%~dp0"

echo ===========================================
echo GraalVM Native Image Build - Windows
echo ===========================================
echo.

set "VCVARS_2026=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
set "VCVARS_2022=C:\Program Files\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
set "VCVARS_2022_X86=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

if exist "%VCVARS_2026%" (
    call "%VCVARS_2026%" x64
) else if exist "%VCVARS_2022%" (
    call "%VCVARS_2022%" x64
) else if exist "%VCVARS_2022_X86%" (
    call "%VCVARS_2022_X86%" x64
) else (
    echo ERROR: Visual Studio Build Tools were not found.
    echo Install Desktop development with C++ and try again.
    pause
    exit /b 1
)

echo.
echo Building native executable using GraalVM AOT compilation...
echo.

call gradlew.bat clean nativeCompile

if errorlevel 1 (
    echo.
    echo ERROR: Native build failed.
    pause
    exit /b 1
)

echo.
echo SUCCESS: Native executable generated.
echo Location: build\native\nativeCompile\hello-graalvm.exe
echo.
pause
