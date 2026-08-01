cls
@echo off
setlocal

echo Building e.asm without Crinkler...

if exist e.obj del e.obj
if exist e.exe del e.exe

ml /nologo /c /coff e.asm
if errorlevel 1 goto build_failed

link /nologo /machine:x86 /subsystem:console,5.00 /entry:_start /out:e.exe e.obj ws2_32.lib kernel32.lib /opt:ref /safeseh:no
if errorlevel 1 goto build_failed

if not exist e.exe goto build_failed

echo.
echo Build complete: e.exe
echo Port: 5555
goto done

:build_failed
echo.
echo Build failed.
exit /b 1

:done
del e.obj
endlocal
