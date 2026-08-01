@echo off
cls
setlocal

set "SRC=E_000_C_90112_BYTES.c"
set "EXE=E_000_C_TCC.exe"
set "TCC=tcc.exe"
set "ARCH=-m32"

rem Accept the duplicate-upload filename if the original name is absent.
if not exist "%SRC%" set "SRC=E_000_C_90112_BYTES(1).c"

if not exist "%SRC%" (
    echo Source file not found.
    goto build_failed
)

rem Prefer TCC's dedicated 32-bit Windows driver when installed.
where i386-win32-tcc.exe >nul 2>nul
if not errorlevel 1 (
    set "TCC=i386-win32-tcc.exe"
    set "ARCH="
)

where "%TCC%" >nul 2>nul
if errorlevel 1 (
    echo Tiny C Compiler was not found in PATH.
    goto build_failed
)

if exist "%EXE%" del "%EXE%"

rem The Windows TCC package supplies winsock2.h and the ws2_32 import definition.
"%TCC%" %ARCH% -Os -s -o "%EXE%" "%SRC%" -lws2_32
if errorlevel 1 goto build_failed

if not exist "%EXE%" goto build_failed

for %%I in ("%EXE%") do echo Build complete: %%~nxI - %%~zI bytes
goto done

:build_failed
echo.
echo Build failed.
exit /b 1

:done
endlocal
