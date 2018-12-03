@echo off
REM (C) Copyright 2010 GrellesLicht28 / S1r1us13
REM This is a creation of Makroware.
title Speed Count - BatchGame
setlocal enabledelayedexpansion
pushd %temp%
if not exist "BatchGame-Highscore-Leicht.tmp" call :Highscores-Erstellen Leicht
if not exist "BatchGame-Highscore-Mittel.tmp" call :Highscores-Erstellen Mittel
if not exist "BatchGame-Highscore-Schwer.tmp" call :Highscores-Erstellen Schwer
if "%1" == "Spielstart25" goto :%1
if "%1" == "Spielstart100" goto :%1
if "%1" == "Spielstart400" goto :%1
if "%1" == "Raten" goto :%1
set Level=Mittel

:Menu
cls
set Wahl=
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º Finde die Platznummer des Blocks  º
echo ÌÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¹
echo º 1: Anleitung                      º
echo º 2: Spielstart                     º
echo º 3: Highscores                     º
echo º 4: Highscores zurcksetzen        º
echo º                                   º
echo º ¸ Copyright 2010 GrellesLicht28   º
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /p Wahl=Wahl: 
if "%Wahl%" == "1" goto :Anleitung
if "%Wahl%" == "2" goto :Spielstart
if "%Wahl%" == "3" call :Highscores
if "%Wahl%" == "4" call :Delete-Highscores
echo.
pause
goto :Menu
REM Benutzername (set /p Benutzer=)
REM Mögliche Zeit bis zur Reaktion (ping localhost -n 3 >nul)
REM Special events: Ab und zu 2 Blöcke, doppelte Zeit zur Reaktion




:Anleitung
echo.
echo Im Spielverlauf werden je nach Schwierigkeitsgrad 25, 100 oder 400 Pl„tze
echo angezeigt. Einer davon enth„lt einen Block. Die Pl„tze werden von oben
echo links nach rechts unten gez„hlt.
echo.
echo Ziel des Spiels ist es, innerhalb der 3 Sekunden Bedenkzeit das Ergebnis
echo in das kleine Fenster einzutippen. War man schnell genug, wird das als
echo Punkt gewertet.
echo.
echo Zum Beenden des Spieles "Ende" eingeben.
echo.
pause
set Aufruf=
set Anzahl=1
echo.
FOR /L %%A IN (11,1,100) DO set Aufruf=!Aufruf!%%A 
echo Die Pl„tze sind wiefolgt angelegt:
echo îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî
echo { 1} { 2} { 3} { 4} { 5} { 6} { 7} { 8} { 9} {10}
echo.
call :Display100 %Aufruf%
pause
goto :Menu






:Spielstart
set Level=
set Levelwahl=
set Geschwindigkeit=
set Geschwindigkeitswahl=
echo.
echo Welche Schwierigkeitsstufe m”chten Sie spielen?
echo 1: Leicht ( 25 Felder)
echo 2: Mittel (100 Felder)
echo 3: Schwer (400 Felder)
echo.
set /p Levelwahl=Wahl: 
if "%Levelwahl%" == "1" set Level=Leicht
if "%Levelwahl%" == "2" set Level=Mittel
if "%Levelwahl%" == "3" set Level=Schwer
if /i "%Levelwahl%" == "Leicht" set Level=Leicht
if /i "%Levelwahl%" == "Mittel" set Level=Mittel
if /i "%Levelwahl%" == "Schwer" set Level=Schwer
if not defined Level (
	echo Falsche Eingabe.
	pause
	goto :Menu
)
echo.
echo Welche Geschwindigkeitsstufe m”chten Sie spielen?
echo 1: Sehr langsam (5 Sekunden Nachdenkzeit)
echo 2: Langsam      (4 Sekunden Nachdenkzeit)
echo 3: Mittel       (3 Sekunden Nachdenkzeit) [Standard]
echo 4: Schnell      (2 Sekunden Nachdenkzeit)
echo 5: Sehr schnell (1 Sekunden Nachdenkzeit)
echo.
set /p Geschwindigkeitswahl=
if "%Geschwindigkeitswahl%" == "1" set Geschwindigkeit=6
if "%Geschwindigkeitswahl%" == "2" set Geschwindigkeit=5
if "%Geschwindigkeitswahl%" == "3" set Geschwindigkeit=4
if "%Geschwindigkeitswahl%" == "4" set Geschwindigkeit=3
if "%Geschwindigkeitswahl%" == "5" set Geschwindigkeit=2
if not defined Geschwindigkeit (
	echo Falsche Eingabe.
	pause
	goto :Menu
)
if "%Level%" == "Leicht" start %~s0 Spielstart25 %Geschwindigkeit%
if "%Level%" == "Mittel" start %~s0 Spielstart100 %Geschwindigkeit%
if "%Level%" == "Schwer" start %~s0 Spielstart400 %Geschwindigkeit%
pause
goto :Menu









:Spielstart25
set KA=(
set KZ=)
if "%2" == "6" set Geschwindigkeit=[Sehr langsam]
if "%2" == "5" set Geschwindigkeit=[Langsam]
if "%2" == "4" set Geschwindigkeit=[Mittel]
if "%2" == "3" set Geschwindigkeit=[Schnell]
if "%2" == "2" set Geschwindigkeit=[Sehr schnell]
set Level=Leicht
set Punkte=0
start %~s0 Raten

:Start25
cls
set Aufruf=
set Anzahl=0
set Eingabe=26
set Ziel=
set Zahl=%random:~1,2%
if "%Zahl:~0,1%" == "0" set Zahl=%Zahl:~1,1%
if not "%Zahl:~1,1%" == "" if "%Zahl:~0,1%" GTR "2" (goto :Start25) ELSE (if "%Zahl:~0,1%" EQU "2" if "%Zahl:~1,1%" GTR "4" goto :Start25)
set /a Ziel=!Zahl! + 1
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 
set /a Zahl=25 - %Zahl%
set Aufruf=!Aufruf!Û 
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 

call :Display25 %Aufruf%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Eingabe=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Eingabe%') DO set Eingabe=%%A
if /i "!Eingabe!" == "Ende" goto :Auswertung

set /a Eingabe=!Eingabe!
set /a Ziel=!Ziel!
echo %Ziel% - !Eingabe!
if "!Eingabe!" == "!Ziel!" (
	echo.
	echo Ihre Antwort war korrekt.
	ping localhost -n 2 >nul
	set /a Punkte=!Punkte! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start25


:Display25
shift /0
echo {%0} {%1} {%2} {%3} {%4}
shift /0
shift /0
shift /0
shift /0
echo.
set /a Anzahl=%Anzahl% + 1
if "%Anzahl%" == "5" exit /b
goto :Display25






:Spielstart100
set KA=(
set KZ=)
if "%2" == "6" set Geschwindigkeit=[Sehr langsam]
if "%2" == "5" set Geschwindigkeit=[Langsam]
if "%2" == "4" set Geschwindigkeit=[Mittel]
if "%2" == "3" set Geschwindigkeit=[Schnell]
if "%2" == "2" set Geschwindigkeit=[Sehr schnell]
set Level=Mittel
set Punkte=0
start %~s0 Raten

:Start100
cls
set Aufruf=
set Anzahl=0
set Eingabe=101
set Ziel=
set Zahl=%random:~1,2%
if "%Zahl:~0,1%" == "0" set Zahl=%Zahl:~1,1%
set /a Ziel=!Zahl! + 1
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 
set /a Zahl=100 - %Zahl%
set Aufruf=!Aufruf!Û 
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 

call :Display100 %Aufruf%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Eingabe=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Eingabe%') DO set Eingabe=%%A
if /i "!Eingabe!" == "Ende" goto :Auswertung

set /a Eingabe=!Eingabe!
set /a Ziel=!Ziel!
echo %Ziel% - !Eingabe!
if "!Eingabe!" == "!Ziel!" (
	echo.
	echo Ihre Antwort war korrekt.
	ping localhost -n 2 >nul
	set /a Punkte=!Punkte! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start100


:Display100
shift /0
echo {%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
echo.
set /a Anzahl=%Anzahl% + 1
if "%Anzahl%" == "10" exit /b
goto :Display100






:Spielstart400
set KA=(
set KZ=)
if "%2" == "6" set Geschwindigkeit=[Sehr langsam]
if "%2" == "5" set Geschwindigkeit=[Langsam]
if "%2" == "4" set Geschwindigkeit=[Mittel]
if "%2" == "3" set Geschwindigkeit=[Schnell]
if "%2" == "2" set Geschwindigkeit=[Sehr schnell]
set Level=Schwer
set Punkte=0
mode con lines=46
start %~s0 Raten

:Start400
cls
set Aufruf=
set Anzahl=0
set Eingabe=401
set Ziel=
set Zahl=%random:~1,3%
if "%Zahl:~0,1%" == "0" set Zahl=%Zahl:~1,2%
if "%Zahl:~0,1%" == "0" set Zahl=%Zahl:~1,1%
if not "%Zahl:~2,1%" == "" if "%Zahl:~0,1%" GEQ "4" goto :Start400
set /a Ziel=!Zahl! + 1
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 
set /a Zahl=400 - %Zahl%
set Aufruf=!Aufruf!Û 
FOR /L %%A IN (1,1,%Zahl%) DO set Aufruf=!Aufruf!- 

call :Display400 %Aufruf%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Eingabe=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Eingabe%') DO set Eingabe=%%A
if /i "!Eingabe!" == "Ende" goto :Auswertung

set /a Eingabe=!Eingabe!
set /a Ziel=!Ziel!
echo %Ziel% - !Eingabe!
if "!Eingabe!" == "!Ziel!" (
	echo.
	echo Ihre Antwort war korrekt.
	ping localhost -n 2 >nul
	set /a Punkte=!Punkte! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start400


:Display400
set Anzeige=
shift /0
set Anzeige={%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
set Anzeige=%Anzeige% {%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
echo %Anzeige%
echo.
set /a Anzahl=%Anzahl% + 1
if "%Anzahl%" == "20" exit /b
goto :Display400








:: %%A = Komplette Zeile in der Datei
:: %%D = Differenz der aktuellen Punkte und des bisherigen Highscores
:: %%S = Set Rang // Rang festlegen
:: %%M = Move Rangordnung // Rangordnung zu Ende führen
:: ---> Bewegt Platz 1 zu Platz 2 und Platz 2 zu Platz 3 usw.
:: %%O = Folgernd durch Alphabet (...L, M, N, O, P...)
:: ---> %%O ist alles von %%A nach dem Doppelpunkt (Erster Platz:  %%O)

::     ---> Erster Platz:  Benutzer (20 Punkte) am 26.12.2010 um 20:00:00,00 [Schnell]
::		  = Erster Platz:  %username% !KA!%Punkte% Punkte!KZ! am %time% um %date% %Geschwindigkeit%
::		  = %%A
::		  = %%M %%N:  %%O


:Auswertung
cls
FOR /F "delims=" %%A IN (BatchGame-Highscore-%Level%.tmp) DO (
	FOR /F "tokens=4 delims=( " %%D IN ("%%A") DO set /a Differenz=%Punkte% - %%D >nul 2>nul || set Differenz=
	if not "!Differenz:~0,1!" == "-" if "!Rang!" == "" FOR /F %%S IN ("%%A") DO set Rang=%%S
)
if "!Rang!" == "" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	set Highscore=%%O
	if "!Highscore!" == "" (
		if "%%M" == "Erster" set Rang=Erster
		if "!Rang!" == "" if "%%M" == "Zweiter" set Rang=Zweiter
		if "!Rang!" == "" if "%%M" == "Dritter" set Rang=Dritter
	)
)
if "!Rang!" == "Erster" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	set Erster=Erster Platz:  %username% !KA!%Punkte% Punkte!KZ! am %date% um %time% %Geschwindigkeit%
	if "%%M" == "Erster" set Zweiter=Zweiter Platz: %%O
	if "%%M" == "Zweiter" set Dritter=Dritter Platz: %%O
)
if "!Rang!" == "Zweiter" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "Erster" set Erster=Erster Platz:  %%O
	set Zweiter=Zweiter Platz: %username% !KA!%Punkte% Punkte!KZ! am %date% um %time% %Geschwindigkeit%
	if "%%M" == "Zweiter" set Dritter=Dritter Platz: %%O
)
if "!Rang!" == "Dritter" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "Erster" set Erster=Erster Platz:  %%O
	if "%%M" == "Zweiter" set Zweiter=Zweiter Platz: %%O
	set Dritter=Dritter Platz: %username% !KA!%Punkte% Punkte!KZ! am %date% um %time% %Geschwindigkeit%
)
if "!Rang!" == "" FOR /F "tokens=1,*" %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "Erster" set Erster=Erster %%N
	if "%%M" == "Zweiter" set Zweiter=Zweiter %%N
	if "%%M" == "Dritter" set Dritter=Dritter %%N
)
echo !Erster!>BatchGame-Highscore-%Level%.tmp
echo !Zweiter!>>BatchGame-Highscore-%Level%.tmp
echo !Dritter!>>BatchGame-Highscore-%Level%.tmp
if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
exit







:Highscores
cls
echo Highscores
echo îîîîîîîîîî
echo  -^> Leicht
echo     îîîîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Leicht.tmp) DO echo       ú%%A
echo.
echo  -^> Mittel
echo     îîîîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Mittel.tmp) DO echo       ú%%A
echo.
echo  -^> Schwer
echo     îîîîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Schwer.tmp) DO echo       ú%%A
exit /b



:Delete-Highscores
set Delete=
cls
echo Welche Highscore-Liste m”chten Sie zurcksetzen?
echo 1: Schwierigkeitsstufe Leicht
echo 2: Schwierigkeitsstufe Mittel
echo 3: Schwierigkeitsstufe Schwer
echo.
set /p Delete=Wahl: 
if "%Delete%" == "1" set Stufe=Leicht
if "%Delete%" == "2" set Stufe=Mittel
if "%Delete%" == "3" set Stufe=Schwer
if defined Stufe call :Highscores-Erstellen %Stufe%
exit /b














:Raten
title Game
mode con cols=14 lines=6
:Raten_2
cls
echo **********
set /p Platz=Platz: 
echo **********
echo %Platz% 1>BatchGame.tmp
if /i "%Platz%" == "Ende" exit
goto :Raten_2









:Highscores-Erstellen
echo Erster Platz:  >BatchGame-Highscore-%1.tmp
echo Zweiter Platz: >>BatchGame-Highscore-%1.tmp
echo Dritter Platz: >>BatchGame-Highscore-%1.tmp
exit /b