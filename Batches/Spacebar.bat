@echo off
title Spacebar maker
setlocal enabledelayedexpansion
pushd "%userprofile%\Desktop"
mode con cols=157
set Char=0
set Textzeile=1
set Textzeilencounter1=1
set Textzeilencounter2=1
echo When you finished entering your text, enter "QUIT" in a new line.
echo Enter your text:
:Textstart
set /p Text%Textzeile%=%Textzeile%: 
if not "!Text%Textzeile%!" == "QUIT" set /a Textzeile=%Textzeile% +1
if "!Text%Textzeile%!" == "QUIT" goto :Textende
goto :Textstart
:Textende
set Text%Textzeilencounter1%=!Text%Textzeilencounter1%!  {p8UyY}
set /a Textzeilencounter1=%Textzeilencounter1% +1
if "%Textzeilencounter1%" == "%Textzeile%" goto :Auswertung
goto :Textende
:Auswertung
if "!Text%Textzeilencounter2%:~%Char%,8!" == " {p8UyY}" set /a Textzeilencounter2=%Textzeilencounter2% +1&& set /a Char=0
set /a Textzeilencounter2=%Textzeilencounter2% -1
if "%Char%" == "0" if not "!Textpuffer%Textzeilencounter2%!" == "" if not "!Textpuffer%Textzeilencounter2%!" == " " if not "!Textpuffer%Textzeilencounter2%!" == "  " (echo !Textpuffer%Textzeilencounter2%!) ELSE (echo.)
set /a Textzeilencounter2=%Textzeilencounter2% +1
if "%Textzeilencounter2%" == "%Textzeile%" if "!Text%Textzeilencounter2%!" == "QUIT" (goto :Ende) ELSE (echo Error in progress.&pause)
set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!!Text%Textzeilencounter2%:~%Char%,1! 
set /a Char=%Char% +1
goto :Auswertung
:Ende
pause >nul
exit