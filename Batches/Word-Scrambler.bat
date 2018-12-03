@echo off
title Word scrambler
setlocal enabledelayedexpansion
:Main-Start
set Char=0
set Textzeile=1
set Textzeilencounter1=1
set Textzeilencounter2=1
echo When you finished your text, enter in a new line "QUIT".
echo.
echo Input:
echo оооооо
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
set Done=0
if "!Text%Textzeilencounter2%:~%Char%,8!" == " {p8UyY}" set /a Textzeilencounter2=%Textzeilencounter2% +1&& set /a Char=0
if "%Textzeilencounter2%" == "%Textzeile%" if "!Text%Textzeilencounter2%!" == "QUIT" (goto :Ende) ELSE (echo Fehler in der Verarbeitung.&pause)
set Nummer1=%random%
set /a Nummer2=%Nummer1% / 2
set /a Nummer2=%Nummer2% * 2
if "%Nummer1%" == "%Nummer2%" (
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "a" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!A&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "b" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!B&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "c" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!C&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "d" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!D&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "e" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!E&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "f" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!F&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "g" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!G&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "h" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!H&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "i" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!I&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "j" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!J&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "k" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!K&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "l" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!L&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "m" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!M&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "n" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!N&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "o" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!O&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "p" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!P&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "q" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!Q&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "r" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!R&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "s" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!S&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "t" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!T&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "u" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!U&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "v" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!V&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "w" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!W&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "x" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!X&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "y" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!Y&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "z" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!Z&set Done=1
) ELSE (
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "A" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!a&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "B" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!b&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "C" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!c&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "D" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!d&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "E" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!e&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "F" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!f&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "G" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!g&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "H" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!h&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "I" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!i&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "J" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!j&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "K" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!k&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "L" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!l&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "M" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!m&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "N" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!n&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "O" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!o&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "P" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!p&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "Q" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!q&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "R" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!r&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "S" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!s&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "T" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!t&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "U" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!u&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "V" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!v&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "W" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!w&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "X" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!x&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "Y" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!y&set Done=1
	if /i "!Text%Textzeilencounter2%:~%Char%,1!" == "Z" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!z&set Done=1
)
if not "!Done!" == "1" set Textpuffer%Textzeilencounter2%=!Textpuffer%Textzeilencounter2%!!Text%Textzeilencounter2%:~%Char%,1!
set /a Char=%Char% +1
goto :Auswertung
:Ende
cls
echo When you finished your text, enter in a new line "QUIT".
echo.
echo Output:
echo ооооооо
set /a Textzeile=!Textzeile! - 1
FOR /L %%A IN (1,1,%Textzeile%) DO echo %%A: !Textpuffer%%A!
pause >nul
set /a Textzeile=!Textzeile! + 1
FOR /L %%A IN (1,1,%Textzeile%) DO set Text%%A=
FOR /L %%A IN (1,1,%Textzeile%) DO set Textpuffer%%A=
cls
goto :Main-Start