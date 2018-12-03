@echo off
set IE-Running=0

:Start
REM --------------------------
FOR /F %%A IN ('tasklist') DO if /i "%%A" == "iexplore.exe" set IE-Running=1
if "%IE-Running%" == "1" (
echo You must not run Internet Explorer today!
taskkill /F /IM iexplore.exe
)
REM --------------------------
set IE-Running=0
goto :Start