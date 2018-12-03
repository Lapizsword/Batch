@echo off
title Autostart-Editor
setlocal enabledelayedexpansion


:: Keep this value on 0 to disable advanced usage mode for WMIC.
:: Change this value to 1 to enable advanced usage mode for WMIC.
set setlocal enabledetailedcommanding=0



if "%~1" == "goto:WMIC" goto :WMIC


echo Checking operating system...
FOR /F "tokens=2 delims=:" %%A IN ('systeminfo 2^>nul^|find "Microsoft Windows "') DO FOR /F "tokens=3 delims= " %%B IN ("%%A") DO set System=%%B
if "%System%" == "2000" set System=XP
if "%System%" == "NT" set System=XP
if "%System%" == "7" (
	echo This program does not work correctly on Windows 7.
	echo Press any key to continue anyway . . .
	pause >nul
)

:Start
set Choice=
cls
echo ษออออออออออออออออออออออออออออออออออป    ษออออออออออออออออออออออออออออออออออป
echo บ         Startup-Editor           บ    บ        Routine-Selfusage         บ
echo ฬออออออออออออออออออออออออออออออออออน    ฬออออออออออออออออออออออออออออออออออน
echo บ1: Startupfolder - Current user   บ    บR1: Systemdrive                   บ
echo บ2: Startupfolder - All users      บ    บR2: Application Data              บ
echo บ3: Startupfolder - System (XP)    บ    บ                                  บ
echo บ                                  บ    บR3: Temporary folder              บ
echo บ4: Registry - Hkey_Current_User   บ    บR4: Temporary Windows-folder      บ
echo บ5: Registry - Hkey_Current_User  1บ    บ                                  บ
echo บ6: Registry - Hkey_Local_Machine  บ    บR5: Network settings in Hosts     บ
echo บ7: Registry - Hkey_Local_Machine 1บ    บ                                  บ
echo บ                                  บ    บR6: Running processes             บ
echo บ8: Autoexec.bat                   บ    บR7: Process paths (with WMI only) บ
echo ศออออออออออออออออออออออออออออออออออผ    ศออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=Choice: 
if "%Choice%" == "1" goto :Startup/User
if "%Choice%" == "2" goto :Startup/All
if "%Choice%" == "3" goto :Startup/System
if "%Choice%" == "4" goto :Startup/HKCU
if "%Choice%" == "5" goto :Startup/HKCU_Once
if "%Choice%" == "6" goto :Startup/HKLM
if "%Choice%" == "7" goto :Startup/HKLM_Once
if "%Choice%" == "8" goto :Autoexec.bat
if "%Choice%" == "R1" goto :Systempartition
if "%Choice%" == "R2" goto :AppData
if "%Choice%" == "R3" goto :Temp
if "%Choice%" == "R4" goto :SysTemp
if "%Choice%" == "R5" goto :Hosts
if "%Choice%" == "R6" goto :Processes
if "%Choice%" == "R7" (call "%~0" "goto:WMIC") ELSE (
	echo Choice unrecognized.
	pause
)
goto :Start


:Startup/User
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,110) DO set Startup-User_%%A=
cls
echo Startup folder from start menu of the current user
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
if "%System%" == "XP" (
	FOR /F "delims=" %%A IN ('dir /A /B /S "%userprofile%\Startm~1\Progra~1\Startup"') DO (
		if not "!Amount!" == "0" echo !Amount!: %%A
		if not "!Amount!" == "0" set Startup-User_!Amount!=%%A
		set /a Amount=!Amount! + 1
	)
) ELSE (
	FOR /F "delims=" %%A IN ('dir /A /B /S "%userprofile%\AppData\Roaming\Microsoft\Windows\Startm~1\Progra~1\Startup"') DO (
		if not "!Amount!" == "0" echo !Amount!: %%A
		if not "!Amount!" == "0" set Startup-User_!Amount!=%%A
		set /a Amount=!Amount! + 1
	)
)
if "!Amount!" == "0" echo No entries.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice if exist "!Startup-User_%Endchoice%!" del /A /P "!Startup-User_%Endchoice%!"
echo.
pause
goto :Start



:Startup/All
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,80) DO set Startup-All_%%A=
cls
echo Startup folder from start menu of all users
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
if "%System%" == "XP" (
	FOR /F "delims=" %%A IN ('dir /A /B /S "%allusersprofile%\Startm~1\Progra~1\Startup"') DO (
		if not "!Amount!" == "0" echo !Amount!: %%A
		if not "!Amount!" == "0" set Startup-All_!Amount!=%%A
		set /a Amount=!Amount! + 1
	)
) ELSE (
	FOR /F "delims=" %%A IN ('dir /A /B /S "%ProgramData%\Microsoft\Windows\Startm~1\Progra~1\Startup"') DO (
		if not "!Amount!" == "0" echo !Amount!: %%A
		if not "!Amount!" == "0" set Startup-All_!Amount!=%%A
		set /a Amount=!Amount! + 1
	)
)
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo Keine Eintrge.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice if exist "!Startup-All_%Endchoice%!" del /A /P "!Startup-All_%Endchoice%!"
echo.
pause
goto :Start




:Startup/System
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,40) DO set Startup-System_%%A=
cls
echo Startup folder from start menu of the system
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
if "%System%" == "XP" (
	FOR /F "delims=" %%A IN ('dir /A /B /S "%SystemRoot%\system32\config\systemprofile\Startm~1\Progra~1\Startup"') DO (
		if not "!Amount!" == "0" echo !Amount!: %%A
		if not "!Amount!" == "0" set Startup-System_!Amount!=%%A
		set /a Amount=!Amount! + 1
	)
) ELSE (
	echo No systemprofile available.
)
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo No entries.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice if exist "!Startup-System_%Endchoice%!" del /A /P "!Startup-System_%Endchoice%!"
echo.
pause
goto :Start






:Startup/HKCU
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,75) DO set Startup-HKCU_%%A=
cls
echo Startup from the registry of the current user
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
echo "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
FOR /F "skip=4 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"') DO (
	set /a Amount=!Amount! + 1
	echo !Amount!: %%A
)
set Amount=0
FOR /F "skip=4 delims=_" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"') DO (
	if not "%%A" == "" set /a Amount=!Amount! + 1
	set Startup-HKCU_!Amount!=%%A
)

:: Remove any spaces in the values in startup.
FOR /L %%A IN (1,1,75) DO if not "!Startup-HKCU_%%A!" == "" set Startup-HKCU_%%A=!Startup-HKCU_%%A:~0,-4!
FOR /L %%A IN (1,1,75) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKCU_%%A:~-1,1!" == " " set Startup-HKCU_%%A=!Startup-HKCU_%%A:~0,-1!
FOR /L %%A IN (1,1,240) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKCU_%%A:~0,1!" == " " set Startup-HKCU_%%A=!Startup-HKCU_%%A:~1!
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo No entries.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "!Startup-HKCU_%Endchoice%!"
echo.
pause
goto :Start





:Startup/HKCU_Once
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,30) DO set Startup-HKCU_Once_%%A=
cls
echo Startup once from the registry of the current user
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
echo "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
echo.
FOR /F "skip=4 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"') DO (
	set /a Amount=!Amount! + 1
	echo !Amount!: %%A
)
set Amount=0
FOR /F "skip=4 delims=_" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"') DO (
	if not "%%A" == "" set /a Amount=!Amount! + 1
	set Startup-HKCU_Once_!Amount!=%%A
)
FOR /L %%A IN (1,1,30) DO if not "!Startup-HKCU_Once_%%A!" == "" set Startup-HKCU_Once_%%A=!Startup-HKCU_Once_%%A:~0,-4!
FOR /L %%A IN (1,1,30) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKCU_Once_%%A:~-1,1!" == " " set Startup-HKCU_Once_%%A=!Startup-HKCU_Once_%%A:~0,-1!
FOR /L %%A IN (1,1,240) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKCU_Once_%%A:~0,1!" == " " set Startup-HKCU_Once_%%A=!Startup-HKCU_Once_%%A:~1!
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo No entries.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "!Startup-HKCU_Once_%Endchoice%!"
echo.
pause
goto :Start






:Startup/HKLM
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,75) DO set Startup-HKLM_%%A=
cls
echo Startup from the registry of all users
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
echo "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
FOR /F "skip=4 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"') DO (
	set /a Amount=!Amount! + 1
	echo !Amount!: %%A
)
set Amount=0
FOR /F "skip=4 delims=_" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"') DO (
	if not "%%A" == "" set /a Amount=!Amount! + 1
	set Startup-HKLM_!Amount!=%%A
)
FOR /L %%A IN (1,1,75) DO if not "!Startup-HKLM_%%A!" == "" set Startup-HKLM_%%A=!Startup-HKLM_%%A:~0,-4!
FOR /L %%A IN (1,1,75) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKLM_%%A:~-1,1!" == " " set Startup-HKLM_%%A=!Startup-HKLM_%%A:~0,-1!
FOR /L %%A IN (1,1,240) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKLM_%%A:~0,1!" == " " set Startup-HKLM_%%A=!Startup-HKLM_%%A:~1!
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo Keine Eintrge.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "!Startup-HKLM_%Endchoice%!"
echo.
pause
goto :Start





:Startup/HKLM_Once
set Choice=
set Amount=0
set Endchoice=
FOR /L %%A IN (1,1,30) DO set Startup-HKLM_Once_%%A=
cls
echo Startup once from the registry of all users
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
echo "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
echo.
FOR /F "skip=4 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"') DO (
	set /a Amount=!Amount! + 1
	echo !Amount!: %%A
)
set Amount=0
FOR /F "skip=4 delims=_" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"') DO (
	if not "%%A" == "" set /a Amount=!Amount! + 1
	set Startup-HKLM_Once_!Amount!=%%A
)
FOR /L %%A IN (1,1,30) DO if not "!Startup-HKLM_Once_%%A!" == "" set Startup-HKLM_Once_%%A=!Startup-HKLM_Once_%%A:~0,-4!
FOR /L %%A IN (1,1,30) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKLM_Once_%%A:~-1,1!" == " " set Startup-HKLM_Once_%%A=!Startup-HKLM_Once_%%A:~0,-1!
FOR /L %%A IN (1,1,240) DO FOR /L %%R IN (1,1,12) DO if "!Startup-HKLM_Once_%%A:~0,1!" == " " set Startup-HKLM_Once_%%A=!Startup-HKLM_Once_%%A:~1!
if "!Amount:~1,1!" == "" if "!Amount:~0,1!" LEQ "2" echo No entries.
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Enter the number of the entry and add a /r to remove it  บ
echo บ                    from the startup.                     บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> 
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Choice%') DO if /i "%%B" == "r" set Endchoice=%%A
if defined Endchoice reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "!Startup-HKLM_Once_%Endchoice%!"
echo.
pause
goto :Start






:Autoexec.bat
set None=
set Choice=
cls
echo Autoexec.bat
echo ๎๎๎๎๎๎๎๎๎๎๎๎
if not "%System%" == "7" (
	if exist "%SystemDrive%\Autoexec.bat" (
		echo.
		type "%SystemDrive%\Autoexec.bat"
		echo.
	) ELSE (
		echo.
		echo No Autoexec.bat available.
		set None=1
	)
) ELSE (
	echo.
	echo No Autoexec.bat available.
	set None=1
)
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
if not "!None!" == "1" (
	echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
	echo บ Enter the number of the entry and add a /r to remove it  บ
	echo บ                    from the startup.                     บ
	echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
	echo.
	set /p Choice=-^> 
	if "!Choice!" == "1" start notepad %SystemDrive%\Autoexec.bat
	echo.
)
pause
goto :Start





:Systempartition
cls
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%SystemDrive%\"') DO echo %SystemDrive%\%%A
echo.
pause
goto :Start




:AppData
cls
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%AppData%\"') DO echo %AppData%\%%A
echo.
pause
goto :Start





:Temp
cls
dir /A /B /S "%temp%"
echo.
pause
goto :Start




:SysTemp
cls
dir /A /B /S "%SystemRoot%\Temp\*.exe" "%SystemRoot%\Temp\*.bat" "%SystemRoot%\Temp\*.cmd" "%SystemRoot%\Temp\*.nt" "%SystemRoot%\Temp\*.vbs"
if errorlevel 1 (
	cls
	echo No executable files found in "%SystemRoot%\Temp".
)
echo.
pause
goto :Start




:Hosts
cls
echo Network settings from the Hosts-file
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
if exist "%SystemRoot%\system64" type "%SystemRoot%\system64\drivers\etc\hosts"
if exist "%SystemRoot%\system32" type "%SystemRoot%\system32\drivers\etc\hosts"
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                 To edit the file navigate to             บ
echo บ        %SystemRoot%\system32(/64)\drivers\etc\hosts        บ
echo บin the explorer and open the file with the Windows-Editor.บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
pause
goto :Start






:Processes
set Choice=
cls
echo Running processes
echo ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎
tasklist /NH|sort
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ  Enter the process-ID (PID) of the process to remove if  บ
echo บ                          exist.                          บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p Choice=-^> PID: 
if defined Choice set /a Choice=%Choice%
if defined Choice if not "%Choice%" == "0" if not "%Choice%" == "4" taskkill /PID %Choice%
ping localhost -n 2 >nul
tasklist /NH|find "%Choice%" >nul 2>nul && tasklist /F /PID %Choice% >nul 2>nul
echo.
pause
goto :Start





:WMIC
set wmic=

:: Check if WMIC works on the computer. Also checks if the program usage mode is set
:: to "0" (unadvanced) or "1" (advanced). Set to "1", you can view more information
:: worse sorted.

if "%setlocal enabledetailedcommanding%" == "0" (
	cls
	wmic timezone>nul 2>nul && set Wmic=1
	if not "!Wmic!" == "1" (echo WMI is not installed for CMD. The progress has been stopped.) ELSE (wmic process get ExecutablePath)
)
if "%setlocal enabledetailedcommanding%" == "1" (
	wmic timezone>nul 2>nul && set Wmic=1
	if not "!Wmic!" == "1" (echo WMI is not installed for CMD. The progress has been stopped.) ELSE (
		mode con cols=157
		wmic process get CommandLine,ProcessId
	)
)
echo.
echo ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo.
pause
exit /b