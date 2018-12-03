@echo off
REM (C) Copyright 2010 GrellesLicht28 / S1r1us13
REM This is a creation of Makroware.
title Suche
setlocal enabledelayedexpansion
mode con cols=157 lines=3000
color 0A
:Suche
set Anzahl=0
cls
echo Wonach m”chten Sie suchen?
set /p Name=--^> 
echo.
echo Bitte warten...
FOR /F "delims=" %%A IN ('dir /A /B /S "%homedrive%\*%Name%*"') DO (
	set /a Anzahl=!Anzahl! +1
	set Anzeige=!Anzahl!
	if "!Anzahl:~3,1!" == "" set Anzeige= !Anzeige!
	if "!Anzahl:~2,1!" == "" set Anzeige= !Anzeige!
	if "!Anzahl:~1,1!" == "" set Anzeige= !Anzeige!
	echo !Anzeige!:  %%~nxA
	echo        --^> %%A
	echo.
)
echo.
echo Optionen:
echo ---------
echo Geben Sie zuerst die Optionszuordnung (1,2,...) und dann den Dateinamen ein.
echo 1: ™ffnen
echo 2: Kopieren
echo 3: Verschieben
echo 4: L”schen
echo.
set /p Optionen=Wahl: 
if "!Optionen!" == "" goto :Ende
FOR /F "delims=" %%A IN ('dir /A /B /S "%homedrive%\*%Name%*"') DO (
	FOR /F "tokens=1,*" %%B IN ('echo !Optionen!') DO (
		set Wahl=%%B
		set Datei=%%C
	)
	if /i "%%~nxA" == "!Datei!" (
		if "!Wahl!" == "1" start %%~sA
		if "!Wahl!" == "2" (
			echo Wohin soll die Datei kopiert werden [Pfad\Dateiname]?
			set /p Pfad=
			copy /-Y "%%~A" "!Pfad!"
		)
		if "!Wahl!" == "3" (
			echo Wohin soll die Datei verschoben werden [Pfad\Dateiname]?
			set /p Pfad=
			move /-Y "%%~A" "!Pfad!"
		)
		if "!Wahl!" == "4" del /A /P "%%~A"
	)
)
:Ende
echo M”chten Sie eine neue Suche starten (J / N)?
set /p Ende=
if /i "%Ende%" == "J" goto :Suche
if /i "%Ende%" == "Ja" goto :Suche
if /i "%Ende%" == "Y" goto :Suche
if /i "%Ende%" == "yes" goto :Suche
EXIT