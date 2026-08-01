cls
@echo off
setlocal

echo Building e.asm with Crinkler...

if exist e.obj del e.obj
if exist e.exe del e.exe

ml /nologo /c /coff /Cp e.asm
if errorlevel 1 goto build_failed

crinkler e.obj ^
 /OUT:e.exe ^
 /ENTRY:_start ^
 /SUBSYSTEM:CONSOLE ^
 /NOINITIALIZERS ^
 /TINYIMPORT ^
 /HASHSIZE:11 ^
 /ORDERTRIES:2000 ^
 /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.20348.0\um\x86" ^
 kernel32.lib ws2_32.lib
if errorlevel 1 goto build_failed

if not exist e.exe goto build_failed

del e.obj 2>nul

echo.
echo Build complete: e.exe
echo Port: 5555
goto done

:build_failed
echo.
echo Build failed.
exit /b 1

:done
endlocal
