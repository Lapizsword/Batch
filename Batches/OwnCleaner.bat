@echo off
REM ********************************************************************
REM * This file runs 2 scans.                                          *
REM * The first one is very quick and checks for particular filenames. *
REM * The second one takes much time and looks for files created by    *
REM *   the Dos-Virusmaker.                                            *
REM * The 2nd one needs not to be run, if the Dos-Virusmaker has never *
REM *   been used.                                                     *
REM ********************************************************************
title OwnCleaner
echo Press any key to start scan.
pause >nul

:: Looking for REG.EXE
FOR /F "delims=" %%A IN ("reg.exe") DO if not exist "%%~$PATH:A" set NoReg=1

:: Managing quarantine
set Quarantine=%userprofile%\Desktop\Quarantine
if exist "%Quarantine%" set Quarantine=%userprofile%\Quarantine
md "%Quarantine%"

:: Start running the scan for unwanted changes on the system and infections
echo Running scan...
echo ооооооооооооооо
if exist "%userprofile%\Startm~1\Progra~1\Autost~1\Benutzer.bat" (
	echo Infected file:   "%userprofile%\Start Menu\Programs\Startup\Benutzer.bat"
	echo ---^> Infection:  Creating EICAR-testvirus in "system32\elsass.sys" on startup
	echo ---^> Caused by:  Testvirus.bat
	move /Y "%userprofile%\Startm~1\Progra~1\Autost~1\Benutzer.bat" "%Quarantine%\Benutzer.bat.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Benutzer.bat.VIR"
	echo.
)
if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Benutzer.bat" (
	echo Infected file:   "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Benutzer.bat"
	echo ---^> Infection:  Creating EICAR-testvirus in "system32\elsass.sys" on startup
	echo ---^> Caused by:  Testvirus.bat
	move /Y "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Benutzer.bat" "%Quarantine%\Benutzer.bat.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Benutzer.bat.VIR"
	echo.
)
if exist "%SystemRoot%\system32\elsass.sys" type "%SystemRoot%\system32\elsass.sys" | findstr /C:"$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*" >nul 2>nul && (
	echo Infected file:   "%SystemRoot%\system32\elsass.sys"
	echo ---^> Infection:  EICAR-testvirus
	echo ---^> Caused by:  Testvirus.bat
	move /Y "%SystemRoot%\system32\elsass.sys" "%Quarantine%\elsass.sys.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\elsass.sys.VIR"
	echo.
)
if exist "%userprofile%\Eigene Dateien\Virenprojekte" (
	echo Infected folder: "%UserProfile%\Eigene Dateien\Virenprojekte"
	echo ---^> Infection:  Multiple viruses [suspected]
	echo ---^> Caused by:  Dos-Virusmaker.bat
	move /Y "%userprofile%\Eigene Dateien\Virenprojekte" "%Quarantine%\Virenprojekte.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virenprojekte.VIR"
	echo.
)
if exist "%userprofile%\My Documents\Virus projects" (
	echo Infected folder: "%UserProfile%\My Documents\Virus projects"
	echo ---^> Infection:  Multiple viruses [suspected]
	echo ---^> Caused by:  Dos-Virusmaker.bat
	move /Y "%userprofile%\My Documents\Virus projects" "%Quarantine%\Virus projects.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus projects.VIR"
	echo.
)
if exist "%userprofile%\Eigene Dateien\Fake_AntiVirus" (
	echo Infected folder: "%userprofile%\Eigene Dateien\Fake_AntiVirus"
	echo ---^> Infection:  Useless files
	echo ---^> Caused by:  Fake Antivirus 1.0
	move /Y "%userprofile%\Eigene Dateien\Fake_AntiVirus" "%Quarantine%\Fake-Antivirus 1.0.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Fake-Antivirus 1.0.VIR"
	echo.
)
if exist "%userprofile%\Eigene Dateien\Antivirus 1.6" (
	echo Infected folder: "%userprofile%\Eigene Dateien\Antivirus 1.6"
	echo ---^> Infection:  Useless files
	echo ---^> Caused by:  Fake Antivirus 1.6
	move /Y "%userprofile%\Eigene Dateien\Antivirus 1.6" "%Quarantine%\Antivirus 1.6.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Antivirus 1.6.VIR"
	echo.
)
dir /A /B /S "%userprofile%\Desktop\Debug-*.ini" >nul 2>nul && (
	echo Infected file:   "%userprofile%\Desktop\Debug-?????.ini"
	echo ---^> Infection:  Leftover from a debugger
	echo ---^> Caused by:  Debugger.bat
	FOR /F "delims=" %%A IN ('dir /A /B /S "%userprofile%\Desktop\Debug-*.ini" 2^>nul') DO (
		move /Y "%%~A" "%Quarantine%\%%~nxA.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\%%~nxA.VIR"
	)
	echo.
)
if exist "%userprofile%\Desktop\Virus(1).vbs" (
	echo Infected file:   "%userprofile%\Desktop\Virus(1).vbs"
	echo ---^> Infection:  Infinite message-loop
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(1).vbs" "%Quarantine%\Virus(1).vbs.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(1).vbs.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(2).vbs" (
	echo Infected file:   "%userprofile%\Desktop\Virus(2).vbs"
	echo ---^> Infection:  Single pop-up message
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(2).vbs" "%Quarantine%\Virus(2).vbs.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(2).vbs.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(3).jpg" (
	echo Infected file:   "%userprofile%\Desktop\Virus(3).jpg"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(3).jpg" "%Quarantine%\Virus(3).jpg.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(3).jpg.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(4).jpg" (
	echo Infected file:   "%userprofile%\Desktop\Virus(4).jpg"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(4).jpg" "%Quarantine%\Virus(4).jpg.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(4).jpg.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(5).jpg" (
	echo Infected file:   "%userprofile%\Desktop\Virus(5).jpg"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(5).jpg" "%Quarantine%\Virus(5).jpg.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(5).jpg.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(6).exe" (
	echo Infected file:   "%userprofile%\Desktop\Virus(6).exe"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(6).exe" "%Quarantine%\Virus(6).exe.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(6).exe.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(7).dll" (
	echo Infected file:   "%userprofile%\Desktop\Virus(7).dll"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(7).dll" "%Quarantine%\Virus(7).dll.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(7).dll.VIR"
	echo.
)
if exist "%userprofile%\Desktop\Virus(8).dll" (
	echo Infected file:   "%userprofile%\Desktop\Virus(8).dll"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Oeffner+Installer.bat
	move /Y "%userprofile%\Desktop\Virus(8).dll" "%Quarantine%\Virus(8).dll.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Virus(8).dll.VIR"
	echo.
)
if exist "%SystemRoot%\system32\Prz.vbs" (
	echo Infected file:   "%SystemRoot%\system32\Prz.vbs"
	echo ---^> Infection:  Supporting unwanted processes, scareware
	echo ---^> Caused by:  Scare.bat
	move /Y "%SystemRoot%\system32\Prz.vbs" "%Quarantine%\Prz.vbs.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Prz.vbs.VIR"
	echo.
)
if exist "%SystemRoot%\system32\Inf.vbs" (
	echo Infected file:   "%SystemRoot%\system32\Inf.vbs"
	echo ---^> Infection:  Supporting unwanted processes, scareware
	echo ---^> Caused by:  Scare.bat
	move /Y "%SystemRoot%\system32\Inf.vbs" "%Quarantine%\Inf.vbs.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\Inf.vbs.VIR"
	echo.
)
if exist "%SystemRoot%\system32\b.exe" (
	echo Infected file:   "%SystemRoot%\system32\b.exe"
	echo ---^> Infection:  Equals CMD.exe , run on startup, scareware
	echo ---^> Caused by:  Scare.bat
	move /Y "%SystemRoot%\system32\b.exe" "%Quarantine%\b.exe.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\b.exe.VIR"
	echo.
)
if exist "%SystemRoot%\system32\d.exe" (
	echo Infected file:   "%SystemRoot%\system32\d.exe"
	echo ---^> Infection:  Equals CMD.exe , run on startup, scareware
	echo ---^> Caused by:  Scare.bat
	move /Y "%SystemRoot%\system32\d.exe" "%Quarantine%\d.exe.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\d.exe.VIR"
	echo.
)
if not "%NoReg%" == "1" reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Desktop Management" >nul 2>nul && (
	echo Infected regkey: "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\\Desktop Management"
	echo ---^> Infection:  Running B.EXE in system32 invisibly on startup, scareware
	echo ---^> Caused by:  Scare.bat
	reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "%Quarantine%\HKCU_RUN - Desktop Management.REG" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\HKCU_RUN - Desktop Management.REG"
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Desktop Management" >nul 2>nul && echo ------^> Successfully removed.
	echo.
)
if not "%NoReg%" == "1" reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "NT Loader" >nul 2>nul && (
	echo Infected regkey: "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\\NT Loader"
	echo ---^> Infection:  Running D.EXE in system32 invisibly on startup, scareware
	echo ---^> Caused by:  Scare.bat
	reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "%Quarantine%\HKCU_RUN - NT Loader.REG" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\HKCU_RUN - NT Loader.REG"
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "NT Loader" >nul 2>nul && echo ------^> Successfully removed.
	echo.
)
if exist "C:\Windows\3148.txt" (
	echo Infected file:   "C:\Windows\3148.txt"
	echo ---^> Infection:  Useless file
	echo ---^> Caused by:  Schreibgeschuetzt.bat
	move /Y "C:\Windows\3148.txt" "%Quarantine%\3148.txt.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\3148.txt.VIR"
	echo.
)
echo.
echo.
echo.
echo.
echo Scan part 1 finished.
echo ооооооооооооооооооооо
echo Quarantine created on desktop. All viruses have been moved into it.
start explorer "%Quarantine%"
echo.
echo Press any key to continue scanning.
pause >nul
echo.
echo.
echo Running scan part 2
echo ооооооооооооооооооо
pushd %cd% 2>nul
FOR %%D IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO dir %%D:\ >nul 2>nul && FOR /F "delims=" %%P IN ('dir /A /B /S "%%D:\*.txt" "%%D:\*.bat" "%%D:\*.cmd" "%%D:\*.log" 2^>nul') DO if not "%%~dpP" == "%Quarantine%" if not "%%~P" == "%~0" findstr /C:"REM Coding: Dos Virus Maker / Dos Virenmacher" "%%~P" >nul 2>nul && (
	echo Infected file:   "%%~P"
	echo ---^> Infection:  Suspicious virus
	echo ---^> Caused by:  Dos-Virusmaker.bat
	move /Y "%%~P" "%Quarantine%\%%~nxP.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\%%~nxP.VIR"
	echo.
)
popd 2>nul
echo.
echo.
echo.
echo.
echo Scan part 2 finished.
echo ооооооооооооооооооооо
echo All found infected files have been moved into the quarantine.
echo.
echo Press enter to close the window.
set /p Exit=
Exit


:: Sample
		(
	echo Infected file:   
	echo ---^> Infection:  
	echo ---^> Caused by:  
	move /Y  "%Quarantine%\.VIR" >nul 2>nul && echo ------^> Quarantined in "%Quarantine%\.VIR"
	echo.
)