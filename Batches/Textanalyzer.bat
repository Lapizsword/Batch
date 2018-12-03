@echo off
REM ------------------------------------------------
REM | (C) Copyright 2010 GrellesLicht28 / S1r1us13 |
REM | This is a creation of Makroware.		   |
REM ------------------------------------------------
title Textanalyzer
mode con cols=157
color 0c
setlocal enabledelayedexpansion
set Char=0
set Anzahl=0
set Textzeile=1
set Textzeilencounter1=1
set Textzeilencounter2=1
echo Haben Sie ihren Text abgeschlossen, geben Sie in einer neuen Zeile "QUIT" ein.
echo Geben Sie einen Text ein:
echo              1...      2...      3...      4...      5...      6...      7...      8...      9...      10...     11...     12...     13...     14...     15.
echo    0123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12
:Textstart
set /p Text%Textzeile%=%Textzeile%: 
if not "!Text%Textzeile%!" == "QUIT" set /a Textzeile=%Textzeile% +1
if "!Text%Textzeile%!" == "QUIT" goto :Textende
goto :Textstart
:Textende
echo.
echo Nach wievielen Zeichen hintereinander soll gesucht werden?
set /p Zeichenzahl=
echo.
set /a Zeichenzahl=%Zeichenzahl%
if "%Zeichenzahl%" == "0" echo Diese Anzahl inakzeptabel.&goto :Textende
if "%Zeichenzahl%" == "1" (set ZF=welchem Zeichen) ELSE (set ZF=welcher Zeichenfolge)
echo Nach %ZF% soll gesucht werden?
set /p Zeichen=
echo.
:Textbeender
set Text%Textzeilencounter1%=!Text%Textzeilencounter1%!  {p8UyY}
set /a Textzeilencounter1=%Textzeilencounter1% +1
if "%Textzeilencounter1%" == "%Textzeile%" goto :Auswertung
goto :Textbeender
:Auswertung
if "!Text%Textzeilencounter2%:~%Char%,8!" == " {p8UyY}" set /a Textzeilencounter2=%Textzeilencounter2% +1&& set /a Char=0
if "%Textzeilencounter2%" == "%Textzeile%" if "!Text%Textzeilencounter2%!" == "QUIT" (goto :Ende) ELSE (echo Fehler in der Verarbeitung.&pause)
if "!Text%Textzeilencounter2%:~%Char%,%Zeichenzahl%!" == "%Zeichen%" (
set /a Anzahl=!Anzahl! +1
set /a Fund=%Char% + %Zeichenzahl% -1
set Fund=%Char% auf !Fund!
echo Zeichenfolge gefunden:  Zeile %Textzeilencounter2% , Spalte !Fund!.
)
set Fund=
set /a Char=%Char% +1
goto :Auswertung
:Ende
echo.
echo Das Zeichen wurde !Anzahl!mal gefunden.
echo Ende.
endlocal
echo.
echo Wollen Sie einen weiteren Text schreiben?
set /p Ende=
FOR /F "usebackq delims=" %%A IN ('%0') DO set Eigenpfad=%%~sA
if /i "%Ende%" == "j" start %Eigenpfad%
if /i "%Ende%" == "ja" start %Eigenpfad%
if /i "%Ende%" == "jap" start %Eigenpfad%
if /i "%Ende%" == "jop" start %Eigenpfad%
if /i "%Ende%" == "jo" start %Eigenpfad%
if /i "%Ende%" == "y" start %Eigenpfad%
if /i "%Ende%" == "ye" start %Eigenpfad%
if /i "%Ende%" == "yes" start %Eigenpfad%
if /i "%Ende%" == "ya" start %Eigenpfad%
if /i "%Ende%" == "yeah" start %Eigenpfad%
EXIT