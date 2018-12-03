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
set Amount=0
set Textline=1
set Textlinecounter1=1
set Textlinecounter2=1
echo When you finished your text, enter in a new line "QUIT".
echo Enter your text here, please:
echo              1...      2...      3...      4...      5...      6...      7...      8...      9...      10...     11...     12...     13...     14...     15.
echo    0123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12
:Textstart
set /p Text%Textline%=%Textline%: 
if not "!Text%Textline%!" == "QUIT" set /a Textline=%Textline% +1
if "!Text%Textline%!" == "QUIT" goto :Textend
goto :Textstart
:Textend
echo.
echo How many characters in a row are you looking for?
set /p CharAmount=
echo.
set /a CharAmount=%CharAmount%
if "%CharAmount%" == "0" echo This amount is not possible.&goto :Textend
if "%CharAmount%" == "1" (set ZF=Which character) ELSE (set ZF=Which string)
echo %ZF% shall be looked for?
set /p String=
echo.
:TextFinisher
set Text%Textlinecounter1%=!Text%Textlinecounter1%!  {p8UyY}
set /a Textlinecounter1=%Textlinecounter1% +1
if "%Textlinecounter1%" == "%Textline%" goto :Search
goto :TextFinisher

:Search
if "!Text%Textlinecounter2%:~%Char%,8!" == " {p8UyY}" set /a Textlinecounter2=%Textlinecounter2% +1&& set /a Char=0
if "%Textlinecounter2%" == "%Textline%" if "!Text%Textlinecounter2%!" == "QUIT" (goto :End) ELSE (echo Error in processing.&pause)
if "!Text%Textlinecounter2%:~%Char%,%CharAmount%!" == "%String%" (
set /a Amount=!Amount! +1
set /a Find=%Char% + %CharAmount% -1
set Find=%Char% to !Find!
echo String found:  Line %Textlinecounter2% , Column !Find!.
)
set Find=
set /a Char=%Char% +1
goto :Search

:End
echo.
echo The string was found !Amount! times.
echo Finished.
endlocal
echo.
echo Do you wish to write another text?
FOR /F "usebackq delims=" %%A IN ('%0') DO set Ownpath=%%~sA
set /p End=
if /i "%End%" == "y" start %Ownpath%
if /i "%End%" == "ye" start %Ownpath%
if /i "%End%" == "yes" start %Ownpath%
if /i "%End%" == "ya" start %Ownpath%
if /i "%End%" == "yeah" start %Ownpath%
EXIT