@echo off
cls
setlocal

set "SRC=E_000_C_90112_BYTES.c"
set "OBJ=E_000_C_000.obj"
set "EXE=E_000_C_000.exe"

if exist "%OBJ%" del "%OBJ%"
if exist "%EXE%" del "%EXE%"

rem Compile for minimum size with whole-program optimization.
cl /nologo /c /TC "%SRC%" ^
 /Fo"%OBJ%" ^
 /O1 /Os /GL /Oi /Oy /Ob3 ^
 /Gy /Gw /GF ^
 /GS- /guard:cf- /Qspectre- /sdl- ^
 /Zl /W3
if errorlevel 1 goto build_failed

rem Link directly to main with no CRT startup or default runtime libraries.
link /nologo "%OBJ%" ^
 /OUT:"%EXE%" ^
 /ENTRY:main ^
 /SUBSYSTEM:CONSOLE ^
 /NODEFAULTLIB ^
 /LTCG ^
 /OPT:REF /OPT:ICF=10 ^
 /INCREMENTAL:NO ^
 /MANIFEST:NO ^
 /FIXED /DYNAMICBASE:NO ^
 /SAFESEH:NO /GUARD:NO ^
 /MERGE:.rdata=.text ^
 kernel32.lib ws2_32.lib
if errorlevel 1 goto build_failed

if not exist "%EXE%" goto build_failed

del "%OBJ%" 2>nul

for %%I in ("%EXE%") do echo Build complete: %%~nxI - %%~zI bytes
goto done

:build_failed
echo.
echo Build failed.
exit /b 1

:done
endlocal
