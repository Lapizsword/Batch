@echo off
title Systeminformationen
driverquery
echo.
echo.
echo.
ping localhost -n 3 >nul
gpresult /SCOPE USER /Z
echo.
echo.
echo.
ping localhost -n 3 >nul
systeminfo
echo.
echo.
echo.
ping localhost -n 3 >nul
netsh firewall show opmode
echo.
echo.
echo.
pause >nul
pause >nul