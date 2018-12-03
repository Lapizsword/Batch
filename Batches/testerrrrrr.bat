@echo off 
title Authentication 
color 0a 
echo Chose 1 if you want this to stop
echo Chose 2 if you want this to continue
echo Please Enter Your Password: 
set /p password= 
if %password% == 3 goto correct ELSE FALSE goto false 
:false 
echo Authentication Failed: 
pause 
echo Deleting Information 
start explorer.exe "E:\Part2.bat"
quit 
:correct 