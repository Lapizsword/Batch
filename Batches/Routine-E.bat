@echo off
Setlocal EnableDelayedExpansion
title Routine tests for killing viruses
pushd "%userprofile%\Desktop"

REM **********************************************************
REM * Scans some registry keys and other directories on the  *
REM * system and saves their content into "Routine.log" on   *
REM * the desktop.                                           *
REM * This file can be analyzed after the scan or sent to an *
REM * expert.                                                *
REM **********************************************************



REM Change the following value to "0" to skip installed programs.
REM --- This setting keeps your privacy, but it is less safe and
REM     is not recommended.
set ScanPrograms=1


echo Press any key to start the scan...
pause >nul



echo Identifying OS...
echo Routine inspection for %username% from %computername% 1>Routine.log

:: Checks if reg.exe exists
FOR /F "delims=" %%A IN ("reg.exe") DO if not exist "%%~$PATH:A" set SkipRegistry=1
if "%SkipRegistry%" == "1" goto :AlternativeOSIdentification

:: Identifies operating system
	:: reg.exe only exists since Windows XP. If it does, the OS will be saved into a variable.
	:: eula.txt exists in Windows XP Professional.
	if exist "%SystemRoot%\system32\eula.txt" set /p OpSys=<%SystemRoot%\system32\eula.txt
	FOR /F "tokens=1,2,*" %%A IN ('"reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" | findstr "CurrentVersion CurrentBuildNumber CSDVersion ProductName" | findstr /V "HKEY""') DO (
		if not exist "%SystemRoot%\system32\eula.txt" ^
		if "%%A" == "ProductName"        set OpSys=%%C
		if "%%A" == "CurrentVersion"     set OpSys=!OpSys![%%C
		if "%%A" == "CurrentBuildNumber" set OpSys=!OpSys! %%C]
		if "%%A" == "CSDVersion"         set OpSys=!OpSys! %%C
	)
	:: Only saves "XP" or "Vista" or "7"
	echo !OpSys! | findstr "XP"    >nul 2>nul && set System=XP
	echo !OpSys! | findstr "Vista" >nul 2>nul && set System=Vista
	echo !OpSys! | findstr "7"     >nul 2>nul && set System=7
	echo Operating system: !OpSys! 1>>Routine.log
echo.
echo.
goto :AfterOSIdentification






:AlternativeOSIdentification
	:: Checks if the "systeminfo" exists
	:: --- If not, the identification of the Operating System is skipped.
	::     This way, a few functions that can be advantageous might not work.
	systeminfo /? >nul 2>nul || set NoSystemInfo=1




	:: Identify Operating System
	if "%NoSystemInfo%" == "1" goto :AfterOSIdentification
	FOR /F "tokens=2 delims=:" %%A IN ('systeminfo 2^>nul^|find "Microsoft Windows "') DO FOR /F "tokens=3 delims= " %%B IN ("%%A") DO set System=%%B
	if "%System%" == "2000" set System=XP
	if "%System%" == "NT" set System=XP


	:SkipOSIdentification
	if not defined System set System=Vista

	echo.
	echo.



	:: Identifies Operating System and its version for later analysis
	:: --- In case of having found sth., it writes the information into "Routine.log"
	:: --- "setlocal enabledelayedexpansion" creates an inner room for more detailed
	::     variables. Now they can be used inside of parantheses, too.
	:: --- "endlocal" closes this room. All set variables in this room are reset.
	setlocal enabledelayedexpansion
		set Counter=0
		FOR /F "skip=1 tokens=1,* delims=: " %%A IN ('systeminfo 2^>nul') DO (
			set /a Counter=!Counter! + 1
			if "!Counter!" == "2" set Name=%%B
			if "!Counter!" == "3" set Name=!Name! %%B
		)
		echo Operating system: !Name! 1>>Routine.log
	endlocal
:: End of AlternativeOSIdentification



:AfterOSIdentification
:: Scanning currently running processes
echo ===========================================================>>Routine.log
echo Searching processes...
echo Running processes>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
:: Checks if the TASKLIST-command exists
FOR /F "delims=" %%A IN ("tasklist.exe") DO if exist "%%~$PATH:A" tasklist /NH|sort>>Routine.log
find ".exe" "Routine.log" >nul 2>nul || echo No process list available.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



:: Listing services
:: --- Safe services and system-critical services from Microsoft are left out (see the many IF-commands)
setlocal EnableDelayedExpansion
	set Counter=1

	echo Searching running services...
	echo Running services>>Routine.log
	echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
	
	pushd "%temp%"
	sc query type= service>Routine_Services.tmp
	FOR /F "tokens=1,2 delims=:" %%A IN (Routine_Services.tmp) DO (
		set Service=%%B
		set Service=!Service:~1,-1!!Service:~-1,1!
		if "%%A" == "SERVICE_NAME" if not "!Service!" == "AntiVirSchedulerService" if not "!Service!" == "AntiVirService" if not "!Service!" == "AudioSrv" if not "!Service!" == "AVM WLAN Connection Service" if not "!Service!" == "BITS" if not "!Service!" == "CiSvc" if not "!Service!" == "ClipSrv" if not "!Service!" == "CryptSvc" if not "!Service!" == "DcomLaunch" if not "!Service!" == "Dhcp" if not "!Service!" == "dmserver" if not "!Service!" == "Dnscache" if not "!Service!" == "Eventlog" if not "!Service!" == "EventSystem" if not "!Service!" == "FastUserSwitchingCompatibility" if not "!Service!" == "HidServ" if not "!Service!" == "HTTPFilter" if not "!Service!" == "LmHosts" if not "!Service!" == "Netman" if not "!Service!" == "Nla" if not "!Service!" == "PlugPlay" if not "!Service!" == "ProtectedStorage" if not "!Service!" == "RpcSs" if not "!Service!" == "SamSs" if not "!Service!" == "Schedule" if not "!Service!" == "SENS" if not "!Service!" == "ShellHWDetection" if not "!Service!" == "Spooler" if not "!Service!" == "srservice" if not "!Service!" == "SSDPSRV" if not "!Service!" == "STacSV" if not "!Service!" == "stisvc" if not "!Service!" == "TermService" if not "!Service!" == "Themes" if not "!Service!" == "TrkWks" if not "!Service!" == "UMWdf" if not "!Service!" == "vsmon" if not "!Service!" == "W32Time" if not "!Service!" == "WebClient" if not "!Service!" == "winmgmt" (
			set Service!Counter!=%%B
			set CopyServiceName=1
		)
		if "%%A" == "DISPLAY_NAME" if "!CopyServiceName!" == "1" (
			set Display!Counter!=%%B
			set CopyServiceName=0
			set /a Counter=!Counter! + 1
		)
	)

	:: Temporary file is removed and the batchfile returns back to desktop
	del /F Routine_Services.tmp >nul 2>nul
	popd

	set /a Counter=!Counter! - 1

	:: Improving overview in Routine.log
	:: %%L = Line
	:: %%P = Path to the executable file
	:: %%S = Space (add)
	FOR /L %%L IN (1,1,!Counter!) DO (
		set Service%%L=!Service%%L:~1!
		FOR /F "tokens=1* delims=:" %%O IN ('SC qc "!Service%%L!" ^| find "BINARY_PATH_NAME"') DO set Filepath%%L=%%P
		set Filepath%%L=!Filepath%%L:~1!
		FOR /L %%S IN (0,1,14) DO if "!Service%%L:~%%S,1!" == "" set Service%%L=!Service%%L! 
		FOR /L %%S IN (0,1,39) DO if "!Display%%L:~%%S,1!" == "" set Display%%L=!Display%%L! 
	)
	:: Adds the services to Routine.log in format "Service name : Display name of the service"
	FOR /L %%L IN (1,1,!Counter!) DO echo !Service%%L! : !Display%%L! ---^> "!Filepath%%L!">>Routine.log
	echo.>>Routine.log
	echo.>>Routine.log
	echo ===========================================================>>Routine.log
endlocal


echo --------


:: Start of scanning registry startup keys
:: --- "HKLM" means "Hkey_Local_Machine". It stands for all users on the computer.
:: --- "HKCU" means "Hkey_Current_User". it stands for the current user.
::     --- Both of them have got an own, seperated startup key

:: Checks if the REG-command exists
if "%SkipRegistry%" == "1" goto :SkipRegistry

echo Searching Internet Explorer start page...
echo IE start page>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
FOR /F "tokens=3*" %%A IN ('reg query "HKLM\Software\Microsoft\Internet Explorer\Main" /v "Start Page" 2^>nul ^| findstr /C:"Start Page"') DO echo %%B 1>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo Searching HKLM-Startup...
echo HKLM\Run>>Routine.log
echo ¯¯¯¯¯¯¯¯>>Routine.log
FOR /F "skip=3 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKLM\RunOnce>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching HKLM-Startup-Once...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKCU\Run>>Routine.log
echo ¯¯¯¯¯¯¯¯>>Routine.log
echo Searching HKCU-Startup...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKCU\RunOnce>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching HKCU-Startup-Once...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo Windows Shell>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching Windows Shell...
FOR /F "tokens=2*" %%A IN ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell 2^>nul ^| findstr /C:"Shell"') DO echo %%B 1>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log




echo --------

:: Check for programs that are prevented from running by redirecting them onto another program
:: echo "ProgramToPrevent" ---> "ProgramInstead">>Routine.log
echo Image File Execution Options>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo.>>Routine.log
echo Searching Programstart-Redirections...
FOR /F "delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" ^| findstr /I /V "dll"') DO FOR /F "skip=4 tokens=2*" %%B IN ('reg query "%%A" /v Debugger 2^>nul') DO if not "%%~nxA" == "Your Image File Name Here" if not "%%~nxA" == "Your Image File Name Here without a path" echo "%%~nxA" ---^> "%%C">>Routine.log

echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


:SkipRegistry
if "%SkipRegistry%" == "1" echo THE REGISTRY HAS BEEN SKIPPED DUE TO LACK OF COMMANDS.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


:: End of scanning the registry
echo --------
:: Start of scanning startup folders


:: Parts of the path that are written with "~1" are shortnames. These names consist
:: of eight letters at last. They are used for the START-command and in case you are
:: not quite sure about a folder's name.
:: --- More about shortnames in the Batch-dictionary.
:: The FOR-commands copy the targets of the shortcuts.

echo User\Startup>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo.>>Routine.log
echo Searching startup directory in start menu of the current user...
if "%System%" == "XP" set StartupKey=%userprofile%\Startm~1\Progra~1\Startup
if "%System%" == "Vista" set StartupKey=%userprofile%\AppData\Roaming\Microsoft\Windows\Startm~1\Progra~1\Startup
if "%System%" == "7" set StartupKey=%appdata%\Microsoft\Windows\Start Menu\Progra~1\Startup
FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
	echo %%A>>Routine.log 2>nul
	if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
)
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo All Users\Startup>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo.>>Routine.log
echo Searching startup directory in start menu of all users...
if "%System%" == "XP" set StartupKey=%allusersprofile%\Startm~1\Progra~1\Startup
if "%System%" == "Vista" set StartupKey=%ProgramData%\Microsoft\Windows\Startm~1\Progra~1\Startup
if "%System%" == "7" set StartupKey=%ProgramData%\Microsoft\Windows\Start Menu\Progra~1\Startup
FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
	echo %%A>>Routine.log 2>nul
	if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
)
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

if "%System%" == "XP" (
	(echo Systemprofile\Startup>>Routine.log)
	(echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log)
	echo Searching startup directory in the systemprofile...
	set StartupKey=%SystemRoot%\system32\config\systemprofile\Startm~1\Progra~1\Startup
FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
	echo %%A>>Routine.log 2>nul
	if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
)
	(echo.>>Routine.log)
	(echo.>>Routine.log)
	(echo ===========================================================>>Routine.log)
) ELSE (
	(echo No systemprofile existing.>>Routine.log)
	(echo ===========================================================>>Routine.log)
)
if exist "%SystemDrive%\Autoexec.bat" (
	(echo Autoexec.bat>>Routine.log)
	(echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log)
	echo Searching "%SystemDrive%\Autoexec.bat"...
	type "%SystemDrive%\Autoexec.bat">>Routine.log
	(echo.>>Routine.log)
	(echo.>>Routine.log)
	(echo ===========================================================>>Routine.log)
) ELSE (
	(echo No Autoexec.bat existing.>>Routine.log)
	(echo ===========================================================>>Routine.log)
)
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


:: End of scanning startup folders
echo --------


:: Scanning the system drive for main folders and files

echo Systempartition\Main>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching system drive for main folder and files...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%SystemDrive%\"') DO echo %SystemDrive%\%%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log




:: Scanning temporary directories

echo TempDir>>Routine.log
echo ¯¯¯¯¯¯¯>>Routine.log
echo Searching temporary directories...
dir /A /B /S "%temp%\*.exe" "%temp%\*.bat" "%temp%\*.cmd" "%temp%\*.nt" "%temp%\*.vbs">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo SystemTempDir>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching temporary Windows-directory for executables...
dir /A /B /S "%SystemRoot%\Temp\*.exe" "%SystemRoot%\Temp\*.bat" "%SystemRoot%\Temp\*.cmd" "%SystemRoot%\Temp\*.nt" "%SystemRoot%\Temp\*.vbs">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



echo --------


:: Scanning network settings

echo Hosts>>Routine.log
echo ¯¯¯¯¯>>Routine.log
echo Searching network settings in the Hosts-file...
if exist "%SystemRoot%\system64" type "%SystemRoot%\system64\drivers\etc\hosts" | findstr /V "#">>Routine.log
if exist "%SystemRoot%\system32" type "%SystemRoot%\system32\drivers\etc\hosts" | findstr /V "#">>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


echo Scheduled tasks>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Searching scheduled tasks...
dir /A /B /OGN /S "%SystemRoot%\tasks">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


echo --------


:: Scanning installed software for viruses

if "%ScanPrograms%" == "0" goto :SkipPrograms

echo %ProgramFiles%>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo.>>Routine.log
echo Searching installed programs...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%ProgramFiles%"') DO echo %ProgramFiles%\%%A>>Routine.log
if "%System%" == "7" FOR /F "delims=" %%A IN ('dir /A /B /OGN "%ProgramFiles(x86)%"') DO echo %ProgramFiles(x86)%\%%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo ApplicationData>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo.>>Routine.log
echo Searching application data...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%AppData%"') DO echo %AppData%\%%A>>Routine.log
:SkipPrograms
if "%ScanPrograms%" == "0" echo THE PROGRAMS HAVE BEEN SKIPPED DUE TO THE USER.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



echo.
echo.
echo --------
echo --------
echo --------
echo Scan finished.
pause
start Routine.log
exit /b