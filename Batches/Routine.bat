:: Autostartobjekte hinzufügen:
::   - "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows:load"
::   - "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows:run"
::   - "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon:UserInit"
::   - 

:: Hinweise:
::   - "HKLM\System\CurrentControlSet\Services"


@echo off
Setlocal EnableDelayedExpansion
title Routine Tests zur Virenbek„mpfung
pushd "%userprofile%\Desktop"

REM **********************************************************
REM * Geht Registrypfade und Ordner durch und speichert den  *
REM * Inhalt selbiger in eine Datei namens "Routine.log" auf *
REM * dem Desktop.                                           *
REM * Diese Datei muss nach Fertigstellung analysiert oder   *
REM * ggf. an einen Experten versendet werden.               *
REM **********************************************************



REM Ändern Sie den folgenden Wert auf "0", um installierte Programme zu überspringen.
REM --- Diese Einstellung bewahrt Ihre Privatssphäre, ist aber nicht so sicher
REM     und wird daher nicht empfohlen.
set ScanPrograms=1



echo Zum Start beliebige Taste drcken...
pause >nul


echo šberprfe Betriebssystem...
echo Routine-Überprüfung für %username% auf %computername% 1>Routine.log

:: Prüft, ob reg.exe existiert.
FOR /F "delims=" %%A IN ("reg.exe") DO if not exist "%%~$PATH:A" set SkipRegistry=1
if "%SkipRegistry%" == "1" goto :AlternativeOSIdentification

:: Ermittelt Betriebssystem
	:: reg.exe existiert erst ab Windows XP. Falls existent, wird das OS abgespeichert in einer Variable.
	:: eula.txt existiert in WinXP Professional.
	if exist "%SystemRoot%\system32\eula.txt" set /p OpSys=<%SystemRoot%\system32\eula.txt
	FOR /F "tokens=1,2,*" %%A IN ('"reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" | findstr "CurrentVersion CurrentBuildNumber CSDVersion ProductName" | findstr /V "HKEY""') DO (
		if not exist "%SystemRoot%\system32\eula.txt" ^
		if "%%A" == "ProductName"        set OpSys=%%C
		if "%%A" == "CurrentVersion"     set OpSys=!OpSys![%%C
		if "%%A" == "CurrentBuildNumber" set OpSys=!OpSys! %%C]
		if "%%A" == "CSDVersion"         set OpSys=!OpSys! %%C
	)
	:: Speichert nur "XP" oder "Vista" oder "7" usw.
	echo !OpSys! | findstr "XP"    >nul 2>nul && set System=XP
	echo !OpSys! | findstr "Vista" >nul 2>nul && set System=Vista
	echo !OpSys! | findstr "7"     >nul 2>nul && set System=7
	echo Betriebssystem: !OpSys! 1>>Routine.log
echo.
echo.
goto :AfterOSIdentification





:: Alternative zur schnellen Betriebssystemerkennung, falls reg.exe nicht existiert
:AlternativeOSIdentification
	:: Verwendet "systeminfo"
	:: Prüft, ob der Befehl "systeminfo" vorhanden ist
	:: --- Wenn nicht, wird das Erkennen des Betriebssystems übersprungen.
	::     Damit fallen diverse Funktionen, die von Vorteil sein könnten, weg.
	systeminfo /? >nul 2>nul || set NoSystemInfo=1
	
	if "%NoSystemInfo%" == "1" goto :AfterOSIdentification
	FOR /F "tokens=2 delims=:" %%A IN ('systeminfo 2^>nul^|find "Microsoft Windows "') DO FOR /F "tokens=3 delims= " %%B IN ("%%A") DO set System=%%B
	if "%System%" == "2000" set System=XP
	if "%System%" == "NT" set System=XP


	:SkipOSIdentification
	if not defined System set System=Vista

	echo.
	echo.


	

	:: Erkennt Betriebssystem und seine Version zur späteren Analyse
	:: --- Schreibt, wenn etwas gefunden wurde, diese Information in "Routine.log"
	:: --- "setlocal enabledelayedexpansion" eröffnet einen Raum für detalliertere
	::     Variablen. Nun können sie innerhalb von Klammern ebenfalls verwendet werden.
	:: --- "endlocal" schließt diesen Raum. Alle gespeicherten Variablen innerhalb dieses
	::     Raumes werden zurückgesetzt.
	if "%NoSystemInfo%" == "1" goto :SkipOSInformationWriter
	setlocal enabledelayedexpansion
		set Counter=0
		FOR /F "skip=1 tokens=1,* delims=: " %%A IN ('systeminfo 2^>nul') DO (
			set /a Counter=!Counter! + 1
			if "!Counter!" == "2" set Name=%%B
			if "!Counter!" == "3" set Name=!Name! %%B
		)
		echo Betriebssystem: !Name! 1>>Routine.log
	endlocal
:: Ende von AlternativeOSIdentification




:AfterOSIdentification
:: Momentan laufende Prozesse
if not defined System set System=Vista
echo ===========================================================>>Routine.log
echo Durchsuche laufende Prozesse...
echo Prozesse>>Routine.log
echo ¯¯¯¯¯¯¯¯>>Routine.log
:: Sucht nach dem TASKLIST-Befehl
FOR /F "delims=" %%A IN ("tasklist.exe") DO if exist "%%~$PATH:A" tasklist /NH|sort>>Routine.log
find ".exe" "Routine.log" >nul 2>nul || echo Keine Prozessliste vorhanden.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



:: Dienste werden gelistet
:: --- Es werden für das System wichtige Dienste von Microsoft und diverse andere sichere Dienste ausgelassen (die vielen IF-Befehle)
setlocal EnableDelayedExpansion
	set Counter=1

	echo Durchsuche gestartete Dienste...
	echo Gestartete Dienste>>Routine.log
	echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
	
	pushd "%temp%"
	sc query type= service>Routine_Services.tmp
	FOR /F "tokens=1,2 delims=:" %%A IN (Routine_Services.tmp) DO (
		set Service=%%B
		set Service=!Service:~1,-1!!Service:~-1,1!
		if "%%A" == "SERVICE_NAME" if not "!Service!" == "AntiVirSchedulerService" if not "!Service!" == "AntiVirService" if not "!Service!" == "AudioSrv" if not "!Service!" == "AVM WLAN Connection Service" if not "!Service!" == "BITS" if not "!Service!" == "CiSvc" if not "!Service!" == "ClipSrv" if not "!Service!" == "CryptSvc" if not "!Service!" == "DcomLaunch" if not "!Service!" == "Dhcp" if not "!Service!" == "dmserver" if not "!Service!" == "Dnscache" if not "!Service!" == "Eventlog" if not "!Service!" == "EventSystem" if not "!Service!" == "FastUserSwitchingCompatibility" if not "!Service!" == "HidServ" if not "!Service!" == "HTTPFilter" if not "!Service!" == "LmHosts" if not "!Service!" == "Netman" if not "!Service!" == "Nla" if not "!Service!" == "PlugPlay" if not "!Service!" == "ProtectedStorage" if not "!Service!" == "RpcSs" if not "!Service!" == "SamSs" if not "!Service!" == "SENS" if not "!Service!" == "ShellHWDetection" if not "!Service!" == "Spooler" if not "!Service!" == "srservice" if not "!Service!" == "SSDPSRV" if not "!Service!" == "STacSV" if not "!Service!" == "stisvc" if not "!Service!" == "TermService" if not "!Service!" == "Themes" if not "!Service!" == "TrkWks" if not "!Service!" == "UMWdf" if not "!Service!" == "vsmon" if not "!Service!" == "W32Time" if not "!Service!" == "WebClient" if not "!Service!" == "winmgmt" (
			set Service!Counter!=%%B
			set CopyServiceName=1
		)
		if "%%A" == "DISPLAY_NAME" if "!CopyServiceName!" == "1" (
			set Display!Counter!=%%B
			set CopyServiceName=0
			set /a Counter=!Counter! + 1
		)
	)

	:: Temporäre Datei wird entfernt und Datei geht zurück zum Desktop
	del /F Routine_Services.tmp >nul 2>nul
	popd

	set /a Counter=!Counter! - 1

	:: Überblick in Routine.log wird verbessert
	:: %%L = Line  / Zeile
	:: %%P = Path to the executable file / Pfad zu der ausführbaren Datei
	:: %%S = Space / Leerzeichen (hinzugefügen)
	FOR /L %%L IN (1,1,!Counter!) DO (
		set Service%%L=!Service%%L:~1!
		FOR /F "tokens=1* delims=:" %%O IN ('SC qc "!Service%%L!" ^| find "BINARY_PATH_NAME"') DO set Filepath%%L=%%P
		set Filepath%%L=!Filepath%%L:~1!
		FOR /L %%S IN (0,1,14) DO if "!Service%%L:~%%S,1!" == "" set Service%%L=!Service%%L! 
		FOR /L %%S IN (0,1,39) DO if "!Display%%L:~%%S,1!" == "" set Display%%L=!Display%%L! 
	)
	:: Fügt die Dienste Routine.log hinzu im Format "Dienstname : Anzeigename des Dienstes"
	FOR /L %%L IN (1,1,!Counter!) DO echo !Service%%L! : !Display%%L! ---^> "!Filepath%%L!">>Routine.log
	echo.>>Routine.log
	echo.>>Routine.log
	echo ===========================================================>>Routine.log
endlocal


echo --------

:: Start vom Scannen des Autostarts der Registry
:: --- "HKLM" ist "Hkey_Local_Machine". Es gilt für alle Benutzer des Computers.
:: --- "HKCU" ist "Hkey_Current_User". Es gilt für den aktuellen Benutzer.
::     --- Beide haben einen eigenen, separaten Autostart

:: Überprüft REG-Befehl
if "%SkipRegistry%" == "1" goto :SkipRegistry

echo Durchsuche Internet-Explorer-Startseite...
echo IE Startseite>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
FOR /F "tokens=3*" %%A IN ('reg query "HKLM\Software\Microsoft\Internet Explorer\Main" /v "Start Page" 2^>nul ^| findstr /C:"Start Page"') DO echo %%B 1>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo Durchsuche HKLM-Autostart...
echo HKLM\Run>>Routine.log
echo ¯¯¯¯¯¯¯¯>>Routine.log
FOR /F "skip=3 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKLM\RunOnce>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche HKLM-Einfach-Autostart...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKCU\Run>>Routine.log
echo ¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche HKCU-Autostart...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo HKCU\RunOnce>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche HKCU-Einfach-Autostart...
FOR /F "skip=3 delims=" %%A IN ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>nul') DO echo %%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo Windows Shell>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Windows Shell...
FOR /F "tokens=2*" %%A IN ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell 2^>nul ^| findstr /C:"Shell"') DO echo %%B 1>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log




echo --------

:: Prüft auf Programme, die am Starten gehindert werden, indem man sie auf andere Programme umlenkt
:: echo "ProgrammZuVerhindern" ---> "ProgrammStattdessen">>Routine.log
echo Image File Execution Options>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Programmstart-Umlenkungen...
FOR /F "delims=" %%A IN ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" ^| findstr /I /V "dll"') DO FOR /F "skip=4 tokens=2*" %%B IN ('reg query "%%A" /v Debugger 2^>nul') DO if not "%%~nxA" == "Your Image File Name Here" if not "%%~nxA" == "Your Image File Name Here without a path" echo "%%~nxA" ---^> "%%C">>Routine.log

echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


:SkipRegistry
if "%SkipRegistry%" == "1" echo DIE REGISTRY WURDE šBERSPRUNGEN AUFGRUND FEHLENDEM BEFEHL.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

:: Ende vom Scannen der Registry
echo --------
:: Start vom Scannen der Autostartordner



:: Teile des Pfades mit "~1" sind Kurznamen der Pfade. Kurznamen bestehen aus maximal
:: acht Zeichen. Dies kann helfen für den START-Befehl oder, wenn man sich dem Namen
:: eines Ordners nicht komplett sicher ist.
:: --- Mehr zu Kurznamen im Batch-Lexikon.
:: Die FOR-Befehle kopieren die Zieldateien von Verknüpfungen.

echo Benutzer\Autostart>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Autostartordner im Startmen des Benutzers...
if "%System%" == "XP" set StartupKey=%userprofile%\Startm~1\Progra~1\Autost~1
if "%System%" == "Vista" set StartupKey=%userprofile%\AppData\Roaming\Microsoft\Windows\Startm~1\Progra~1\Autost~1
if "%System%" == "7" set StartupKey=%appdata%\Microsoft\Windows\Start Menu\Programme\Startup
FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
	echo %%A>>Routine.log 2>nul
	if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
)
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo Alle Benutzer\Autostart>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Autostartordner im Startmen aller Benutzer...
if "%System%" == "XP" set StartupKey=%allusersprofile%\Startm~1\Progra~1\Autost~1
if "%System%" == "Vista" set StartupKey=%ProgramData%\Microsoft\Windows\Startm~1\Progra~1\Autost~1
if "%System%" == "7" set StartupKey=%ProgramData%\Microsoft\Windows\Start Menu\Programme\Startup
FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
	echo %%A>>Routine.log 2>nul
	if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
)

echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

if "%System%" == "XP" (
	(echo Systemprofil\Autostart>>Routine.log)
	(echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log)
	echo Durchsuche Autostartordner im Startmen des Systems...
	set StartupKey=%SystemRoot%\system32\config\systemprofile\Startm~1\Progra~1\Autost~1
	FOR /F "delims=" %%A IN ('dir /A /B /S "!StartupKey!"') DO (
		echo %%A>>Routine.log 2>nul
		if "%%~xA" == ".lnk" FOR /F "skip=3 delims=" %%L IN ('find ":\" "%%A"') DO echo ---^> %%L>>Routine.log
	)
	(echo.>>Routine.log)
	(echo.>>Routine.log)
	(echo ===========================================================>>Routine.log)
) ELSE (
	(echo Kein Systemprofil vorhanden.>>Routine.log)
	(echo ===========================================================>>Routine.log)
)
if exist "%SystemDrive%\Autoexec.bat" (
	(echo Autoexec.bat>>Routine.log)
	(echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log)
	echo Durchsuche "%SystemDrive%\Autoexec.bat"...
	type "%SystemDrive%\Autoexec.bat">>Routine.log
	(echo.>>Routine.log)
	(echo.>>Routine.log)
	(echo ===========================================================>>Routine.log)
) ELSE (
	(echo Kein Autoexec.bat vorhanden.>>Routine.log)
	(echo ===========================================================>>Routine.log)
)
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


:: Ende vom Scannen der Autostartordner
echo --------


:: Scannen der Systempartition auf Ordner und Dateien ohne Unterordner

echo Systempartition\Hauptordner>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Hauptordner der Systempartition...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%SystemDrive%\"') DO echo %SystemDrive%\%%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log




:: Scannen der temporären Ordner

echo TempDir>>Routine.log
echo ¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche tempor„ren Ordner...
dir /A /B /S "%temp%\*.exe" "%temp%\*.bat" "%temp%\*.cmd" "%temp%\*.nt" "%temp%\*.vbs">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo SystemTempDir>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche tempor„ren Windows-Ordner auf ausfhrbare Dateien...
dir /A /B /S "%SystemRoot%\Temp\*.exe" "%SystemRoot%\Temp\*.bat" "%SystemRoot%\Temp\*.cmd" "%SystemRoot%\Temp\*.nt" "%SystemRoot%\Temp\*.vbs">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



echo --------


:: Scannen der Netzwerkeinstellungen...

echo Hosts>>Routine.log
echo ¯¯¯¯¯>>Routine.log
echo Durchsuche Netzwerkeinstellungen der Hosts-Datei...
if exist "%SystemRoot%\system64" type "%SystemRoot%\system64\drivers\etc\hosts" | findstr /V "#">>Routine.log 2>nul
if exist "%SystemRoot%\system32" type "%SystemRoot%\system32\drivers\etc\hosts" | findstr /V "#">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


echo Geplante Tasks>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche geplante Tasks...
dir /A /B /OGN /S "%SystemRoot%\tasks">>Routine.log 2>nul
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log


echo --------


:: Scannen der installierten Software auf Viren

if "%ScanPrograms%" == "0" goto :SkipPrograms

echo %ProgramFiles%>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Programme...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%ProgramFiles%"') DO echo %ProgramFiles%\%%A>>Routine.log
if "%System%" == "7" FOR /F "delims=" %%A IN ('dir /A /B /OGN "%ProgramFiles(x86)%"') DO echo %ProgramFiles(x86)%\%%A>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log

echo Anwendungsdaten>>Routine.log
echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯>>Routine.log
echo Durchsuche Anwendungsdaten...
FOR /F "delims=" %%A IN ('dir /A /B /OGN "%AppData%"') DO echo %AppData%\%%A>>Routine.log
:SkipPrograms
if "%ScanPrograms%" == "0" echo DIE PROGRAMME WURDEN DURCH DEN BENUTZER šBERSPRUNGEN.>>Routine.log
echo.>>Routine.log
echo.>>Routine.log
echo ===========================================================>>Routine.log



echo.
echo.
echo --------
echo --------
echo --------
echo Scan abgeschlossen.
pause
start Routine.log
Endlocal
exit /b