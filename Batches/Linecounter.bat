@echo off
title Batch counter
setlocal enabledelayedexpansion

REM ************************************************************
REM * Keep this value on "1" to search the current directory.  *
REM * Change the following value to "2" to enable counting all *
REM * batchfiles on the system drive.                          *
REM ************************************************************
set ScanMode=1




:: Set the scan mode

set /a ScanMode=%ScanMode:~0,1%
if "%ScanMode%" == "0" set ScanMode=1
if "%ScanMode%" GEQ "3" set ScanMode=1
if "%ScanMode%" == "1" set ScanMode=dir /A /B /S "%cd%\*.bat" "%cd%\*.cmd"
if "!ScanMode!" == "2" set ScanMode=dir /A /B /S "%systemdrive%\*.bat" "%systemdrive%\*.cmd"


echo Types of usage:
echo îîîîîîîîîîîîîîî
echo 1. Count the lines of all batch files
echo 2. Sort "Lines.ini" by line amount
echo 3. Sort "Lines.ini" by filename
echo.
set /p Typ=Enter the type of usage here: 
echo.
if "%Typ%" == "2" goto :Lines
if "%Typ%" == "3" goto :Names
echo This process might take a while, please wait...
echo.


:: - Counts the lines for every file on the drive or in the current directory
::   (depending on the set scanmode).
::    -^> Note that blank lines are not counted!
:: - Also counts the total amount of lines of all found files.
:: - Counts the amount of files by the way.
:: - When done, it divides the lines by files and writes the quotient into the Lines.ini-file.




echo ::Start::
set Files=0
set FileLines=0
set TotalLines=0
echo.>Lines.ini
FOR /F "delims=" %%A IN ('%Scanmode%') DO (
	set Lines=0
	set /a Files=!Files! + 1
	FOR /F "delims=" %%B IN ("%%~A") DO (
		FOR /F "delims=" %%C IN (%%~sA) DO set /a Lines=!Lines! + 1
		set Space=
		set File=%%~nxA
		FOR /L %%D IN (2,1,40) DO if "!File:~%%D,1!" == "" set Space=!Space! 
		FOR /L %%D IN (1,1,4) DO if "!Lines:~%%D,1!" == "" set Lines= !Lines!
		echo   %%~nxA !Space!³ !Lines! 1>>Lines.ini
	)
	set /a TotalLines=!TotalLines! + !Lines!
)
set /a Quotient=!TotalLines! / !Files!
echo.>>Lines.ini
echo.>>Lines.ini
echo ------------->>Lines.ini
echo Total file amount: !Files! 1>>Lines.ini
echo Total line amount: !TotalLines! 1>>Lines.ini
echo.>>Lines.ini
echo %Quotient% lines per file.>>Lines.ini
echo.
echo Files: !Files!
echo Lines: !TotalLines!
echo.
echo ::End::
pause >nul
exit









:Lines
echo.
echo.
echo  Nr.³                  Filename                   ³  Lines ³ Nr.
echo ÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄ
REM    1 ³   Dos Virenmacher.bat                       ³ 29287  ³ 1
set Counter=0
FOR /F "delims=" %%A IN ('sort /R /+47 Lines.ini') DO (
	set Line=%%A
	set /a Counter=!Counter! + 1
	if "!Counter:~2,1!" == "" set Counter= !Counter!
	if "!Counter:~2,1!" == "" set Counter= !Counter!
	if "!Line:~0,2!" == "  " (
		echo !Counter! ³ %%A ³ !Counter!
		echo ÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄ
	)
)
pause >nul
exit

:Names
echo.
echo.
echo  No.³                   Filename                  ³  Lines  ³ No.
echo ÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄ
FOR /F "skip=5 delims=" %%A IN ('sort Lines.ini') DO (
	set Line=%%A
	set /a Counter=!Counter! + 1
	if "!Counter:~2,1!" == "" set Counter= !Counter!
	if "!Counter:~2,1!" == "" set Counter= !Counter!
	if "!Line:~0,2!" == "  " (
		echo !Counter! ³ %%A  ³ !Counter!
		echo ÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄ
	)
)
pause >nul
exit