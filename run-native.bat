@echo off
cd /d "%~dp0"

echo Running GraalVM Native Executable...
echo.

if exist "build\native\nativeCompile\hello-graalvm.exe" (
    build\native\nativeCompile\hello-graalvm.exe
) else (
    echo ERROR: Native executable not found.
    echo First run native-build.bat to generate it.
)

echo.
pause
