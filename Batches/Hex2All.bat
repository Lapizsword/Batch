@echo off
title Hex2Ascii converter
setlocal enabledelayedexpansion
REM *********************************
REM * Version info:
REM * ¯¯¯¯¯¯¯¯¯¯¯¯¯
REM * Edit No. 01: Corrected hexadecimal code number 22
REM * Edit No. 02: Allow using parameters [either hexcode or file containing hexcode].
REM * Edit No. 03: Corrected hexadecimal code number 21
REM *********************************
pushd %temp%
set Quote="


:Start
call :ResetVariables
:: Checks if the user started the file via CMD.
:: - If so, checks if the first given parameter is a filepath.
::   - If so, the program reads out the file for hexadecimal code.
::     [Every line is entered into Hex2All.bat.]
::   - If the first parameter is not a filepath, it sets it to the HexCode.
:: - If not, the program asks for a user prompt.
echo %1 | find ":\" >nul 2>nul && set Givenpath=1
if "%GivenPath%" == "1" FOR /F "usebackq delims=" %%A IN ("%~1") DO (
	set HexCode=%%~A
	echo Hex:   !HexCode!
	set HexCode=!HexCode!  {p8UyY}
	call :Conversion ReadingOutFile
	call :ResetVariables
)
if "!HexCode!" == "" if not "%~1" == "" (set HexCode=%~1) ELSE (set /p HexCode=Hex:   )
set HexCode=!HexCode:0x=!

echo %1 | find ":\" >nul 2>nul || if not "%~1" == "" echo Hex:   %HexCode%

:: Check the beginning and the end for parantheses
if "%HexCode:~0,1%" == "{" set Counter=1
set HexCode=!HexCode!  {p8UyY}
shift /1

if "%GivenPath%" == "1" set GivenPath=0 & goto :Start

:Conversion

set AsciiCode_Puffer=!AsciiCode!

:: Check if finished
if "!HexCode:~%Counter%,9!" == "  {p8UyY}" goto :Finished

:: Check for symbols and spaces
if "!HexCode:~%Counter%,1!" == "-" set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == " " set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == "," set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == "|" set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == "." set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == ":" set /a Counter=%Counter% + 1 & goto :Conversion
if "!HexCode:~%Counter%,1!" == ";" set /a Counter=%Counter% + 1 & goto :Conversion

:: Start of conversion from hex to ascii
if "!HexCode:~%Counter%,2!" == "00" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{NUL}& set DecimalCode=!DecimalCode!0,& set BinaryCode=!BinaryCode!00000000,
if "!HexCode:~%Counter%,2!" == "01" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!1,& set BinaryCode=!BinaryCode!00000001,
if "!HexCode:~%Counter%,2!" == "02" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!2,& set BinaryCode=!BinaryCode!00000010,
if "!HexCode:~%Counter%,2!" == "03" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!3,& set BinaryCode=!BinaryCode!00000011,
if "!HexCode:~%Counter%,2!" == "04" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!4,& set BinaryCode=!BinaryCode!00000100,
if "!HexCode:~%Counter%,2!" == "05" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!5,& set BinaryCode=!BinaryCode!00000101,
if "!HexCode:~%Counter%,2!" == "06" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!6,& set BinaryCode=!BinaryCode!00000110,
if "!HexCode:~%Counter%,2!" == "07" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{BEL}& set DecimalCode=!DecimalCode!7,& set BinaryCode=!BinaryCode!00000111,
if "!HexCode:~%Counter%,2!" == "08" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!8,& set BinaryCode=!BinaryCode!00001000,
if "!HexCode:~%Counter%,2!" == "09" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!	& set DecimalCode=!DecimalCode!9,& set BinaryCode=!BinaryCode!00001001,
if /i "!HexCode:~%Counter%,2!" == "0a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{LF}& set DecimalCode=!DecimalCode!10,& set BinaryCode=!BinaryCode!00001010,
if /i "!HexCode:~%Counter%,2!" == "0b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!11,& set BinaryCode=!BinaryCode!00001011,
if /i "!HexCode:~%Counter%,2!" == "0c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!12,& set BinaryCode=!BinaryCode!00001100,
if /i "!HexCode:~%Counter%,2!" == "0d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{CR}& set DecimalCode=!DecimalCode!13,& set BinaryCode=!BinaryCode!00001101,
if /i "!HexCode:~%Counter%,2!" == "0e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!14,& set BinaryCode=!BinaryCode!00001110,
if /i "!HexCode:~%Counter%,2!" == "0f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!15,& set BinaryCode=!BinaryCode!00001111,

if "!HexCode:~%Counter%,2!" == "10" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!16,& set BinaryCode=!BinaryCode!00010000,
if "!HexCode:~%Counter%,2!" == "11" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!17,& set BinaryCode=!BinaryCode!00010001,
if "!HexCode:~%Counter%,2!" == "12" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!18,& set BinaryCode=!BinaryCode!00010010,
if "!HexCode:~%Counter%,2!" == "13" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!19,& set BinaryCode=!BinaryCode!00010011,
if "!HexCode:~%Counter%,2!" == "14" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!20,& set BinaryCode=!BinaryCode!00010100,
if "!HexCode:~%Counter%,2!" == "15" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!21,& set BinaryCode=!BinaryCode!00010101,
if "!HexCode:~%Counter%,2!" == "16" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!22,& set BinaryCode=!BinaryCode!00010110,
if "!HexCode:~%Counter%,2!" == "17" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!23,& set BinaryCode=!BinaryCode!00010111,
if "!HexCode:~%Counter%,2!" == "18" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!24,& set BinaryCode=!BinaryCode!00011000,
if "!HexCode:~%Counter%,2!" == "19" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!25,& set BinaryCode=!BinaryCode!00011001,
if /i "!HexCode:~%Counter%,2!" == "1a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{SUB}& set DecimalCode=!DecimalCode!26,& set BinaryCode=!BinaryCode!00011010,
if /i "!HexCode:~%Counter%,2!" == "1b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{ESC}& set DecimalCode=!DecimalCode!27,& set BinaryCode=!BinaryCode!00011011,
if /i "!HexCode:~%Counter%,2!" == "1c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!28,& set BinaryCode=!BinaryCode!00011100,
if /i "!HexCode:~%Counter%,2!" == "1d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!29,& set BinaryCode=!BinaryCode!00011101,
if /i "!HexCode:~%Counter%,2!" == "1e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!30,& set BinaryCode=!BinaryCode!00011110,
if /i "!HexCode:~%Counter%,2!" == "1f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!31,& set BinaryCode=!BinaryCode!00011111,

if "!HexCode:~%Counter%,2!" == "20" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode! & set DecimalCode=!DecimalCode!32,& set BinaryCode=!BinaryCode!00100000,
if "!HexCode:~%Counter%,2!" == "21" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{ExclamationMark}& set DecimalCode=!DecimalCode!33,& set BinaryCode=!BinaryCode!00100001,
if "!HexCode:~%Counter%,2!" == "22" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!!Quote!& set DecimalCode=!DecimalCode!34,& set BinaryCode=!BinaryCode!00100010,
if "!HexCode:~%Counter%,2!" == "23" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!#& set DecimalCode=!DecimalCode!35,& set BinaryCode=!BinaryCode!00100011,
if "!HexCode:~%Counter%,2!" == "24" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!$& set DecimalCode=!DecimalCode!36,& set BinaryCode=!BinaryCode!00100100,
if "!HexCode:~%Counter%,2!" == "25" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!%%& set DecimalCode=!DecimalCode!37,& set BinaryCode=!BinaryCode!00100101,
if "!HexCode:~%Counter%,2!" == "26" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^&& set DecimalCode=!DecimalCode!38,& set BinaryCode=!BinaryCode!00100110,
if "!HexCode:~%Counter%,2!" == "27" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!'& set DecimalCode=!DecimalCode!39,& set BinaryCode=!BinaryCode!00100111,
if "!HexCode:~%Counter%,2!" == "28" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^(& set DecimalCode=!DecimalCode!40,& set BinaryCode=!BinaryCode!00101000,
if "!HexCode:~%Counter%,2!" == "29" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^)& set DecimalCode=!DecimalCode!41,& set BinaryCode=!BinaryCode!00101001,
if /i "!HexCode:~%Counter%,2!" == "2a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!*& set DecimalCode=!DecimalCode!42,& set BinaryCode=!BinaryCode!00101010,
if /i "!HexCode:~%Counter%,2!" == "2b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!+& set DecimalCode=!DecimalCode!43,& set BinaryCode=!BinaryCode!00101011,
if /i "!HexCode:~%Counter%,2!" == "2c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!,& set DecimalCode=!DecimalCode!44,& set BinaryCode=!BinaryCode!00101100,
if /i "!HexCode:~%Counter%,2!" == "2d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!-& set DecimalCode=!DecimalCode!45,& set BinaryCode=!BinaryCode!00101101,
if /i "!HexCode:~%Counter%,2!" == "2e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!.& set DecimalCode=!DecimalCode!46,& set BinaryCode=!BinaryCode!00101110,
if /i "!HexCode:~%Counter%,2!" == "2f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!/& set DecimalCode=!DecimalCode!47,& set BinaryCode=!BinaryCode!00101111,

if "!HexCode:~%Counter%,2!" == "30" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!0& set DecimalCode=!DecimalCode!48,& set BinaryCode=!BinaryCode!00110000,
if "!HexCode:~%Counter%,2!" == "31" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!1& set DecimalCode=!DecimalCode!49,& set BinaryCode=!BinaryCode!00110001,
if "!HexCode:~%Counter%,2!" == "32" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!2& set DecimalCode=!DecimalCode!50,& set BinaryCode=!BinaryCode!00110010,
if "!HexCode:~%Counter%,2!" == "33" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!3& set DecimalCode=!DecimalCode!51,& set BinaryCode=!BinaryCode!00110011,
if "!HexCode:~%Counter%,2!" == "34" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!4& set DecimalCode=!DecimalCode!52,& set BinaryCode=!BinaryCode!00110100,
if "!HexCode:~%Counter%,2!" == "35" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!5& set DecimalCode=!DecimalCode!53,& set BinaryCode=!BinaryCode!00110101,
if "!HexCode:~%Counter%,2!" == "36" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!6& set DecimalCode=!DecimalCode!54,& set BinaryCode=!BinaryCode!00110110,
if "!HexCode:~%Counter%,2!" == "37" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!7& set DecimalCode=!DecimalCode!55,& set BinaryCode=!BinaryCode!00110111,
if "!HexCode:~%Counter%,2!" == "38" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!8& set DecimalCode=!DecimalCode!56,& set BinaryCode=!BinaryCode!00111000,
if "!HexCode:~%Counter%,2!" == "39" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!9& set DecimalCode=!DecimalCode!57,& set BinaryCode=!BinaryCode!00111001,
if /i "!HexCode:~%Counter%,2!" == "3a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!:& set DecimalCode=!DecimalCode!58,& set BinaryCode=!BinaryCode!00111010,
if /i "!HexCode:~%Counter%,2!" == "3b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!;& set DecimalCode=!DecimalCode!59,& set BinaryCode=!BinaryCode!00111011,
if /i "!HexCode:~%Counter%,2!" == "3c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^<& set DecimalCode=!DecimalCode!60,& set BinaryCode=!BinaryCode!00111100,
if /i "!HexCode:~%Counter%,2!" == "3d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!=& set DecimalCode=!DecimalCode!61,& set BinaryCode=!BinaryCode!00111101,
if /i "!HexCode:~%Counter%,2!" == "3e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^>& set DecimalCode=!DecimalCode!62,& set BinaryCode=!BinaryCode!00111110,
if /i "!HexCode:~%Counter%,2!" == "3f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!?& set DecimalCode=!DecimalCode!63,& set BinaryCode=!BinaryCode!00111111,

if "!HexCode:~%Counter%,2!" == "40" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!@& set DecimalCode=!DecimalCode!64,& set BinaryCode=!BinaryCode!01000000,
if "!HexCode:~%Counter%,2!" == "41" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!A& set DecimalCode=!DecimalCode!65,& set BinaryCode=!BinaryCode!01000001,
if "!HexCode:~%Counter%,2!" == "42" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!B& set DecimalCode=!DecimalCode!66,& set BinaryCode=!BinaryCode!01000010,
if "!HexCode:~%Counter%,2!" == "43" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!C& set DecimalCode=!DecimalCode!67,& set BinaryCode=!BinaryCode!01000011,
if "!HexCode:~%Counter%,2!" == "44" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!D& set DecimalCode=!DecimalCode!68,& set BinaryCode=!BinaryCode!01000100,
if "!HexCode:~%Counter%,2!" == "45" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!E& set DecimalCode=!DecimalCode!69,& set BinaryCode=!BinaryCode!01000101,
if "!HexCode:~%Counter%,2!" == "46" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!F& set DecimalCode=!DecimalCode!70,& set BinaryCode=!BinaryCode!01000110,
if "!HexCode:~%Counter%,2!" == "47" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!G& set DecimalCode=!DecimalCode!71,& set BinaryCode=!BinaryCode!01000111,
if "!HexCode:~%Counter%,2!" == "48" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!H& set DecimalCode=!DecimalCode!72,& set BinaryCode=!BinaryCode!01001000,
if "!HexCode:~%Counter%,2!" == "49" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!I& set DecimalCode=!DecimalCode!73,& set BinaryCode=!BinaryCode!01001001,
if /i "!HexCode:~%Counter%,2!" == "4a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!J& set DecimalCode=!DecimalCode!74,& set BinaryCode=!BinaryCode!01001010,
if /i "!HexCode:~%Counter%,2!" == "4b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!K& set DecimalCode=!DecimalCode!75,& set BinaryCode=!BinaryCode!01001011,
if /i "!HexCode:~%Counter%,2!" == "4c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!L& set DecimalCode=!DecimalCode!76,& set BinaryCode=!BinaryCode!01001100,
if /i "!HexCode:~%Counter%,2!" == "4d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!M& set DecimalCode=!DecimalCode!77,& set BinaryCode=!BinaryCode!01001101,
if /i "!HexCode:~%Counter%,2!" == "4e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!N& set DecimalCode=!DecimalCode!78,& set BinaryCode=!BinaryCode!01001110,
if /i "!HexCode:~%Counter%,2!" == "4f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!O& set DecimalCode=!DecimalCode!79,& set BinaryCode=!BinaryCode!01001111,

if "!HexCode:~%Counter%,2!" == "50" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!P& set DecimalCode=!DecimalCode!80,& set BinaryCode=!BinaryCode!01010000,
if "!HexCode:~%Counter%,2!" == "51" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Q& set DecimalCode=!DecimalCode!81,& set BinaryCode=!BinaryCode!01010001,
if "!HexCode:~%Counter%,2!" == "52" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!R& set DecimalCode=!DecimalCode!82,& set BinaryCode=!BinaryCode!01010010,
if "!HexCode:~%Counter%,2!" == "53" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!S& set DecimalCode=!DecimalCode!83,& set BinaryCode=!BinaryCode!01010011,
if "!HexCode:~%Counter%,2!" == "54" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!T& set DecimalCode=!DecimalCode!84,& set BinaryCode=!BinaryCode!01010100,
if "!HexCode:~%Counter%,2!" == "55" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!U& set DecimalCode=!DecimalCode!85,& set BinaryCode=!BinaryCode!01010101,
if "!HexCode:~%Counter%,2!" == "56" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!V& set DecimalCode=!DecimalCode!86,& set BinaryCode=!BinaryCode!01010110,
if "!HexCode:~%Counter%,2!" == "57" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!W& set DecimalCode=!DecimalCode!87,& set BinaryCode=!BinaryCode!01010111,
if "!HexCode:~%Counter%,2!" == "58" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!X& set DecimalCode=!DecimalCode!88,& set BinaryCode=!BinaryCode!01011000,
if "!HexCode:~%Counter%,2!" == "59" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Y& set DecimalCode=!DecimalCode!89,& set BinaryCode=!BinaryCode!01011001,
if /i "!HexCode:~%Counter%,2!" == "5a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Z& set DecimalCode=!DecimalCode!90,& set BinaryCode=!BinaryCode!01011010,
if /i "!HexCode:~%Counter%,2!" == "5b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode![& set DecimalCode=!DecimalCode!91,& set BinaryCode=!BinaryCode!01011011,
if /i "!HexCode:~%Counter%,2!" == "5c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!\& set DecimalCode=!DecimalCode!92,& set BinaryCode=!BinaryCode!01011100,
if /i "!HexCode:~%Counter%,2!" == "5d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!]& set DecimalCode=!DecimalCode!93,& set BinaryCode=!BinaryCode!01011101,
if /i "!HexCode:~%Counter%,2!" == "5e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^^& set DecimalCode=!DecimalCode!94,& set BinaryCode=!BinaryCode!01011110,
if /i "!HexCode:~%Counter%,2!" == "5f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!_& set DecimalCode=!DecimalCode!95,& set BinaryCode=!BinaryCode!01011111,

if "!HexCode:~%Counter%,2!" == "60" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!`& set DecimalCode=!DecimalCode!96,& set BinaryCode=!BinaryCode!01100000,
if "!HexCode:~%Counter%,2!" == "61" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!a& set DecimalCode=!DecimalCode!97,& set BinaryCode=!BinaryCode!01100001,
if "!HexCode:~%Counter%,2!" == "62" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!b& set DecimalCode=!DecimalCode!98,& set BinaryCode=!BinaryCode!01100010,
if "!HexCode:~%Counter%,2!" == "63" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!c& set DecimalCode=!DecimalCode!99,& set BinaryCode=!BinaryCode!01100011,
if "!HexCode:~%Counter%,2!" == "64" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!d& set DecimalCode=!DecimalCode!100,& set BinaryCode=!BinaryCode!01100100,
if "!HexCode:~%Counter%,2!" == "65" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!e& set DecimalCode=!DecimalCode!101,& set BinaryCode=!BinaryCode!01100101,
if "!HexCode:~%Counter%,2!" == "66" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!f& set DecimalCode=!DecimalCode!102,& set BinaryCode=!BinaryCode!01100110,
if "!HexCode:~%Counter%,2!" == "67" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!g& set DecimalCode=!DecimalCode!103,& set BinaryCode=!BinaryCode!01100111,
if "!HexCode:~%Counter%,2!" == "68" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!h& set DecimalCode=!DecimalCode!104,& set BinaryCode=!BinaryCode!01101000,
if "!HexCode:~%Counter%,2!" == "69" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!i& set DecimalCode=!DecimalCode!105,& set BinaryCode=!BinaryCode!01101001,
if /i "!HexCode:~%Counter%,2!" == "6a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!j& set DecimalCode=!DecimalCode!106,& set BinaryCode=!BinaryCode!01101010,
if /i "!HexCode:~%Counter%,2!" == "6b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!k& set DecimalCode=!DecimalCode!107,& set BinaryCode=!BinaryCode!01101011,
if /i "!HexCode:~%Counter%,2!" == "6c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!l& set DecimalCode=!DecimalCode!108,& set BinaryCode=!BinaryCode!01101100,
if /i "!HexCode:~%Counter%,2!" == "6d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!m& set DecimalCode=!DecimalCode!109,& set BinaryCode=!BinaryCode!01101101,
if /i "!HexCode:~%Counter%,2!" == "6e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!n& set DecimalCode=!DecimalCode!110,& set BinaryCode=!BinaryCode!01101110,
if /i "!HexCode:~%Counter%,2!" == "6f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!o& set DecimalCode=!DecimalCode!111,& set BinaryCode=!BinaryCode!01101111,

if "!HexCode:~%Counter%,2!" == "70" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!p& set DecimalCode=!DecimalCode!112,& set BinaryCode=!BinaryCode!01110000,
if "!HexCode:~%Counter%,2!" == "71" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!q& set DecimalCode=!DecimalCode!113,& set BinaryCode=!BinaryCode!01110001,
if "!HexCode:~%Counter%,2!" == "72" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!r& set DecimalCode=!DecimalCode!114,& set BinaryCode=!BinaryCode!01110010,
if "!HexCode:~%Counter%,2!" == "73" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!s& set DecimalCode=!DecimalCode!115,& set BinaryCode=!BinaryCode!01110011,
if "!HexCode:~%Counter%,2!" == "74" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!t& set DecimalCode=!DecimalCode!116,& set BinaryCode=!BinaryCode!01110100,
if "!HexCode:~%Counter%,2!" == "75" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!u& set DecimalCode=!DecimalCode!117,& set BinaryCode=!BinaryCode!01110101,
if "!HexCode:~%Counter%,2!" == "76" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!v& set DecimalCode=!DecimalCode!118,& set BinaryCode=!BinaryCode!01110110,
if "!HexCode:~%Counter%,2!" == "77" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!w& set DecimalCode=!DecimalCode!119,& set BinaryCode=!BinaryCode!01110111,
if "!HexCode:~%Counter%,2!" == "78" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!x& set DecimalCode=!DecimalCode!120,& set BinaryCode=!BinaryCode!01111000,
if "!HexCode:~%Counter%,2!" == "79" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!y& set DecimalCode=!DecimalCode!121,& set BinaryCode=!BinaryCode!01111001,
if /i "!HexCode:~%Counter%,2!" == "7a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!z& set DecimalCode=!DecimalCode!122,& set BinaryCode=!BinaryCode!01111010,
if /i "!HexCode:~%Counter%,2!" == "7b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{& set DecimalCode=!DecimalCode!123,& set BinaryCode=!BinaryCode!01111011,
if /i "!HexCode:~%Counter%,2!" == "7c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^|& set DecimalCode=!DecimalCode!124,& set BinaryCode=!BinaryCode!01111100,
if /i "!HexCode:~%Counter%,2!" == "7d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!}& set DecimalCode=!DecimalCode!125,& set BinaryCode=!BinaryCode!01111101,
if /i "!HexCode:~%Counter%,2!" == "7e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!~& set DecimalCode=!DecimalCode!126,& set BinaryCode=!BinaryCode!01111110,
if /i "!HexCode:~%Counter%,2!" == "7f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!127,& set BinaryCode=!BinaryCode!01111111,

if "!HexCode:~%Counter%,2!" == "80" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!€& set DecimalCode=!DecimalCode!128,& set BinaryCode=!BinaryCode!10000000,
if "!HexCode:~%Counter%,2!" == "81" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!129,& set BinaryCode=!BinaryCode!10000001,
if "!HexCode:~%Counter%,2!" == "82" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!‚& set DecimalCode=!DecimalCode!130,& set BinaryCode=!BinaryCode!10000010,
if "!HexCode:~%Counter%,2!" == "83" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ƒ& set DecimalCode=!DecimalCode!131,& set BinaryCode=!BinaryCode!10000011,
if "!HexCode:~%Counter%,2!" == "84" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!„& set DecimalCode=!DecimalCode!132,& set BinaryCode=!BinaryCode!10000100,
if "!HexCode:~%Counter%,2!" == "85" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!…& set DecimalCode=!DecimalCode!133,& set BinaryCode=!BinaryCode!10000101,
if "!HexCode:~%Counter%,2!" == "86" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!†& set DecimalCode=!DecimalCode!134,& set BinaryCode=!BinaryCode!10000110,
if "!HexCode:~%Counter%,2!" == "87" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!‡& set DecimalCode=!DecimalCode!135,& set BinaryCode=!BinaryCode!10000111,
if "!HexCode:~%Counter%,2!" == "88" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ˆ& set DecimalCode=!DecimalCode!136,& set BinaryCode=!BinaryCode!10001000,
if "!HexCode:~%Counter%,2!" == "89" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!‰& set DecimalCode=!DecimalCode!137,& set BinaryCode=!BinaryCode!10001001,
if /i "!HexCode:~%Counter%,2!" == "8a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Š& set DecimalCode=!DecimalCode!138,& set BinaryCode=!BinaryCode!10001010,
if /i "!HexCode:~%Counter%,2!" == "8b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!‹& set DecimalCode=!DecimalCode!139,& set BinaryCode=!BinaryCode!10001011,
if /i "!HexCode:~%Counter%,2!" == "8c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Œ& set DecimalCode=!DecimalCode!140,& set BinaryCode=!BinaryCode!10001100,
if /i "!HexCode:~%Counter%,2!" == "8d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!141,& set BinaryCode=!BinaryCode!10001101,
if /i "!HexCode:~%Counter%,2!" == "8e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ž& set DecimalCode=!DecimalCode!142,& set BinaryCode=!BinaryCode!10001110,
if /i "!HexCode:~%Counter%,2!" == "8f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!143,& set BinaryCode=!BinaryCode!10001111,

if "!HexCode:~%Counter%,2!" == "90" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!144,& set BinaryCode=!BinaryCode!10010000,
if "!HexCode:~%Counter%,2!" == "91" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!‘& set DecimalCode=!DecimalCode!145,& set BinaryCode=!BinaryCode!10010001,
if "!HexCode:~%Counter%,2!" == "92" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!’& set DecimalCode=!DecimalCode!146,& set BinaryCode=!BinaryCode!10010010,
if "!HexCode:~%Counter%,2!" == "93" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!“& set DecimalCode=!DecimalCode!147,& set BinaryCode=!BinaryCode!10010011,
if "!HexCode:~%Counter%,2!" == "94" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!”& set DecimalCode=!DecimalCode!148,& set BinaryCode=!BinaryCode!10010100,
if "!HexCode:~%Counter%,2!" == "95" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!•& set DecimalCode=!DecimalCode!149,& set BinaryCode=!BinaryCode!10010101,
if "!HexCode:~%Counter%,2!" == "96" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!–& set DecimalCode=!DecimalCode!150,& set BinaryCode=!BinaryCode!10010110,
if "!HexCode:~%Counter%,2!" == "97" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!—& set DecimalCode=!DecimalCode!151,& set BinaryCode=!BinaryCode!10010111,
if "!HexCode:~%Counter%,2!" == "98" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!˜& set DecimalCode=!DecimalCode!152,& set BinaryCode=!BinaryCode!10011000,
if "!HexCode:~%Counter%,2!" == "99" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!™& set DecimalCode=!DecimalCode!153,& set BinaryCode=!BinaryCode!10011001,
if /i "!HexCode:~%Counter%,2!" == "9a" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!š& set DecimalCode=!DecimalCode!154,& set BinaryCode=!BinaryCode!10011010,
if /i "!HexCode:~%Counter%,2!" == "9b" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!›& set DecimalCode=!DecimalCode!155,& set BinaryCode=!BinaryCode!10011011,
if /i "!HexCode:~%Counter%,2!" == "9c" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!œ& set DecimalCode=!DecimalCode!156,& set BinaryCode=!BinaryCode!10011100,
if /i "!HexCode:~%Counter%,2!" == "9d" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!157,& set BinaryCode=!BinaryCode!10011101,
if /i "!HexCode:~%Counter%,2!" == "9e" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ž& set DecimalCode=!DecimalCode!158,& set BinaryCode=!BinaryCode!10011110,
if /i "!HexCode:~%Counter%,2!" == "9f" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ÿ& set DecimalCode=!DecimalCode!159,& set BinaryCode=!BinaryCode!10011111,

if /i "!HexCode:~%Counter%,2!" == "a0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode! & set DecimalCode=!DecimalCode!160,& set BinaryCode=!BinaryCode!10100000,
if /i "!HexCode:~%Counter%,2!" == "a1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¡& set DecimalCode=!DecimalCode!161,& set BinaryCode=!BinaryCode!10100001,
if /i "!HexCode:~%Counter%,2!" == "a2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¢& set DecimalCode=!DecimalCode!162,& set BinaryCode=!BinaryCode!10100010,
if /i "!HexCode:~%Counter%,2!" == "a3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!£& set DecimalCode=!DecimalCode!163,& set BinaryCode=!BinaryCode!10100011,
if /i "!HexCode:~%Counter%,2!" == "a4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¤& set DecimalCode=!DecimalCode!164,& set BinaryCode=!BinaryCode!10100100,
if /i "!HexCode:~%Counter%,2!" == "a5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¥& set DecimalCode=!DecimalCode!165,& set BinaryCode=!BinaryCode!10100101,
if /i "!HexCode:~%Counter%,2!" == "a6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¦& set DecimalCode=!DecimalCode!166,& set BinaryCode=!BinaryCode!10100110,
if /i "!HexCode:~%Counter%,2!" == "a7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!§& set DecimalCode=!DecimalCode!167,& set BinaryCode=!BinaryCode!10100111,
if /i "!HexCode:~%Counter%,2!" == "a8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¨& set DecimalCode=!DecimalCode!168,& set BinaryCode=!BinaryCode!10101000,
if /i "!HexCode:~%Counter%,2!" == "a9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!©& set DecimalCode=!DecimalCode!169,& set BinaryCode=!BinaryCode!10101001,
if /i "!HexCode:~%Counter%,2!" == "aa" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ª& set DecimalCode=!DecimalCode!170,& set BinaryCode=!BinaryCode!10101010,
if /i "!HexCode:~%Counter%,2!" == "ab" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!«& set DecimalCode=!DecimalCode!171,& set BinaryCode=!BinaryCode!10101011,
if /i "!HexCode:~%Counter%,2!" == "ac" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¬& set DecimalCode=!DecimalCode!172,& set BinaryCode=!BinaryCode!10101100,
if /i "!HexCode:~%Counter%,2!" == "ad" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!­& set DecimalCode=!DecimalCode!173,& set BinaryCode=!BinaryCode!10101101,
if /i "!HexCode:~%Counter%,2!" == "ae" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!®& set DecimalCode=!DecimalCode!174,& set BinaryCode=!BinaryCode!10101110,
if /i "!HexCode:~%Counter%,2!" == "af" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¯& set DecimalCode=!DecimalCode!175,& set BinaryCode=!BinaryCode!10101111,

if /i "!HexCode:~%Counter%,2!" == "b0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!°& set DecimalCode=!DecimalCode!176,& set BinaryCode=!BinaryCode!10110000,
if /i "!HexCode:~%Counter%,2!" == "b1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!±& set DecimalCode=!DecimalCode!177,& set BinaryCode=!BinaryCode!10110001,
if /i "!HexCode:~%Counter%,2!" == "b2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!²& set DecimalCode=!DecimalCode!178,& set BinaryCode=!BinaryCode!10110010,
if /i "!HexCode:~%Counter%,2!" == "b3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!³& set DecimalCode=!DecimalCode!179,& set BinaryCode=!BinaryCode!10110011,
if /i "!HexCode:~%Counter%,2!" == "b4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!´& set DecimalCode=!DecimalCode!180,& set BinaryCode=!BinaryCode!10110100,
if /i "!HexCode:~%Counter%,2!" == "b5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!µ& set DecimalCode=!DecimalCode!181,& set BinaryCode=!BinaryCode!10110101,
if /i "!HexCode:~%Counter%,2!" == "b6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¶& set DecimalCode=!DecimalCode!182,& set BinaryCode=!BinaryCode!10110110,
if /i "!HexCode:~%Counter%,2!" == "b7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!·& set DecimalCode=!DecimalCode!183,& set BinaryCode=!BinaryCode!10110111,
if /i "!HexCode:~%Counter%,2!" == "b8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¸& set DecimalCode=!DecimalCode!184,& set BinaryCode=!BinaryCode!10111000,
if /i "!HexCode:~%Counter%,2!" == "b9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¹& set DecimalCode=!DecimalCode!185,& set BinaryCode=!BinaryCode!10111001,
if /i "!HexCode:~%Counter%,2!" == "ba" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!º& set DecimalCode=!DecimalCode!186,& set BinaryCode=!BinaryCode!10111010,
if /i "!HexCode:~%Counter%,2!" == "bb" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!»& set DecimalCode=!DecimalCode!187,& set BinaryCode=!BinaryCode!10111011,
if /i "!HexCode:~%Counter%,2!" == "bc" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¼& set DecimalCode=!DecimalCode!188,& set BinaryCode=!BinaryCode!10111100,
if /i "!HexCode:~%Counter%,2!" == "bd" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!½& set DecimalCode=!DecimalCode!189,& set BinaryCode=!BinaryCode!10111101,
if /i "!HexCode:~%Counter%,2!" == "be" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¾& set DecimalCode=!DecimalCode!190,& set BinaryCode=!BinaryCode!10111110,
if /i "!HexCode:~%Counter%,2!" == "bf" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!¿& set DecimalCode=!DecimalCode!191,& set BinaryCode=!BinaryCode!10111111,

if /i "!HexCode:~%Counter%,2!" == "c0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!À& set DecimalCode=!DecimalCode!192,& set BinaryCode=!BinaryCode!11000000,
if /i "!HexCode:~%Counter%,2!" == "c1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Á& set DecimalCode=!DecimalCode!193,& set BinaryCode=!BinaryCode!11000001,
if /i "!HexCode:~%Counter%,2!" == "c2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Â& set DecimalCode=!DecimalCode!194,& set BinaryCode=!BinaryCode!11000010,
if /i "!HexCode:~%Counter%,2!" == "c3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ã& set DecimalCode=!DecimalCode!195,& set BinaryCode=!BinaryCode!11000011,
if /i "!HexCode:~%Counter%,2!" == "c4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ä& set DecimalCode=!DecimalCode!196,& set BinaryCode=!BinaryCode!11000100,
if /i "!HexCode:~%Counter%,2!" == "c5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Å& set DecimalCode=!DecimalCode!197,& set BinaryCode=!BinaryCode!11000101,
if /i "!HexCode:~%Counter%,2!" == "c6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Æ& set DecimalCode=!DecimalCode!198,& set BinaryCode=!BinaryCode!11000110,
if /i "!HexCode:~%Counter%,2!" == "c7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ç& set DecimalCode=!DecimalCode!199,& set BinaryCode=!BinaryCode!11000111,
if /i "!HexCode:~%Counter%,2!" == "c8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!È& set DecimalCode=!DecimalCode!200,& set BinaryCode=!BinaryCode!11001000,
if /i "!HexCode:~%Counter%,2!" == "c9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!É& set DecimalCode=!DecimalCode!201,& set BinaryCode=!BinaryCode!11001001,
if /i "!HexCode:~%Counter%,2!" == "ca" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ê& set DecimalCode=!DecimalCode!202,& set BinaryCode=!BinaryCode!11001010,
if /i "!HexCode:~%Counter%,2!" == "cb" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ë& set DecimalCode=!DecimalCode!203,& set BinaryCode=!BinaryCode!11001011,
if /i "!HexCode:~%Counter%,2!" == "cc" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ì& set DecimalCode=!DecimalCode!204,& set BinaryCode=!BinaryCode!11001100,
if /i "!HexCode:~%Counter%,2!" == "cd" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Í& set DecimalCode=!DecimalCode!205,& set BinaryCode=!BinaryCode!11001101,
if /i "!HexCode:~%Counter%,2!" == "ce" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Î& set DecimalCode=!DecimalCode!206,& set BinaryCode=!BinaryCode!11001110,
if /i "!HexCode:~%Counter%,2!" == "cf" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ï& set DecimalCode=!DecimalCode!207,& set BinaryCode=!BinaryCode!11001111,

if /i "!HexCode:~%Counter%,2!" == "d0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ð& set DecimalCode=!DecimalCode!208,& set BinaryCode=!BinaryCode!11010000,
if /i "!HexCode:~%Counter%,2!" == "d1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ñ& set DecimalCode=!DecimalCode!209,& set BinaryCode=!BinaryCode!11010001,
if /i "!HexCode:~%Counter%,2!" == "d2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ò& set DecimalCode=!DecimalCode!210,& set BinaryCode=!BinaryCode!11010010,
if /i "!HexCode:~%Counter%,2!" == "d3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ó& set DecimalCode=!DecimalCode!211,& set BinaryCode=!BinaryCode!11010011,
if /i "!HexCode:~%Counter%,2!" == "d4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ô& set DecimalCode=!DecimalCode!212,& set BinaryCode=!BinaryCode!11010100,
if /i "!HexCode:~%Counter%,2!" == "d5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Õ& set DecimalCode=!DecimalCode!213,& set BinaryCode=!BinaryCode!11010101,
if /i "!HexCode:~%Counter%,2!" == "d6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ö& set DecimalCode=!DecimalCode!214,& set BinaryCode=!BinaryCode!11010110,
if /i "!HexCode:~%Counter%,2!" == "d7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!×& set DecimalCode=!DecimalCode!215,& set BinaryCode=!BinaryCode!11010111,
if /i "!HexCode:~%Counter%,2!" == "d8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ø& set DecimalCode=!DecimalCode!216,& set BinaryCode=!BinaryCode!11011000,
if /i "!HexCode:~%Counter%,2!" == "d9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ù& set DecimalCode=!DecimalCode!217,& set BinaryCode=!BinaryCode!11011001,
if /i "!HexCode:~%Counter%,2!" == "da" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ú& set DecimalCode=!DecimalCode!218,& set BinaryCode=!BinaryCode!11011010,
if /i "!HexCode:~%Counter%,2!" == "db" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Û& set DecimalCode=!DecimalCode!219,& set BinaryCode=!BinaryCode!11011011,
if /i "!HexCode:~%Counter%,2!" == "dc" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ü& set DecimalCode=!DecimalCode!220,& set BinaryCode=!BinaryCode!11011100,
if /i "!HexCode:~%Counter%,2!" == "dd" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Ý& set DecimalCode=!DecimalCode!221,& set BinaryCode=!BinaryCode!11011101,
if /i "!HexCode:~%Counter%,2!" == "de" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Þ& set DecimalCode=!DecimalCode!222,& set BinaryCode=!BinaryCode!11011110,
if /i "!HexCode:~%Counter%,2!" == "df" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ß& set DecimalCode=!DecimalCode!223,& set BinaryCode=!BinaryCode!11011111,

if /i "!HexCode:~%Counter%,2!" == "e0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!à& set DecimalCode=!DecimalCode!224,& set BinaryCode=!BinaryCode!11100000,
if /i "!HexCode:~%Counter%,2!" == "e1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!á& set DecimalCode=!DecimalCode!225,& set BinaryCode=!BinaryCode!11100001,
if /i "!HexCode:~%Counter%,2!" == "e2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!â& set DecimalCode=!DecimalCode!226,& set BinaryCode=!BinaryCode!11100010,
if /i "!HexCode:~%Counter%,2!" == "e3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ã& set DecimalCode=!DecimalCode!227,& set BinaryCode=!BinaryCode!11100011,
if /i "!HexCode:~%Counter%,2!" == "e4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ä& set DecimalCode=!DecimalCode!228,& set BinaryCode=!BinaryCode!11100100,
if /i "!HexCode:~%Counter%,2!" == "e5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!å& set DecimalCode=!DecimalCode!229,& set BinaryCode=!BinaryCode!11100101,
if /i "!HexCode:~%Counter%,2!" == "e6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!æ& set DecimalCode=!DecimalCode!230,& set BinaryCode=!BinaryCode!11100110,
if /i "!HexCode:~%Counter%,2!" == "e7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ç& set DecimalCode=!DecimalCode!231,& set BinaryCode=!BinaryCode!11100111,
if /i "!HexCode:~%Counter%,2!" == "e8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!è& set DecimalCode=!DecimalCode!232,& set BinaryCode=!BinaryCode!11101000,
if /i "!HexCode:~%Counter%,2!" == "e9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!é& set DecimalCode=!DecimalCode!233,& set BinaryCode=!BinaryCode!11101001,
if /i "!HexCode:~%Counter%,2!" == "ea" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ê& set DecimalCode=!DecimalCode!234,& set BinaryCode=!BinaryCode!11101010,
if /i "!HexCode:~%Counter%,2!" == "eb" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ë& set DecimalCode=!DecimalCode!235,& set BinaryCode=!BinaryCode!11101011,
if /i "!HexCode:~%Counter%,2!" == "ec" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ì& set DecimalCode=!DecimalCode!236,& set BinaryCode=!BinaryCode!11101100,
if /i "!HexCode:~%Counter%,2!" == "ed" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!í& set DecimalCode=!DecimalCode!237,& set BinaryCode=!BinaryCode!11101101,
if /i "!HexCode:~%Counter%,2!" == "ee" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!î& set DecimalCode=!DecimalCode!238,& set BinaryCode=!BinaryCode!11101110,
if /i "!HexCode:~%Counter%,2!" == "ef" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ï& set DecimalCode=!DecimalCode!239,& set BinaryCode=!BinaryCode!11101111,

if /i "!HexCode:~%Counter%,2!" == "f0" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ð& set DecimalCode=!DecimalCode!240,& set BinaryCode=!BinaryCode!11110000,
if /i "!HexCode:~%Counter%,2!" == "f1" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ñ& set DecimalCode=!DecimalCode!241,& set BinaryCode=!BinaryCode!11110001,
if /i "!HexCode:~%Counter%,2!" == "f2" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ò& set DecimalCode=!DecimalCode!242,& set BinaryCode=!BinaryCode!11110010,
if /i "!HexCode:~%Counter%,2!" == "f3" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ó& set DecimalCode=!DecimalCode!243,& set BinaryCode=!BinaryCode!11110011,
if /i "!HexCode:~%Counter%,2!" == "f4" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ô& set DecimalCode=!DecimalCode!244,& set BinaryCode=!BinaryCode!11110100,
if /i "!HexCode:~%Counter%,2!" == "f5" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!õ& set DecimalCode=!DecimalCode!245,& set BinaryCode=!BinaryCode!11110101,
if /i "!HexCode:~%Counter%,2!" == "f6" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ö& set DecimalCode=!DecimalCode!246,& set BinaryCode=!BinaryCode!11110110,
if /i "!HexCode:~%Counter%,2!" == "f7" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!÷& set DecimalCode=!DecimalCode!247,& set BinaryCode=!BinaryCode!11110111,
if /i "!HexCode:~%Counter%,2!" == "f8" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ø& set DecimalCode=!DecimalCode!248,& set BinaryCode=!BinaryCode!11111000,
if /i "!HexCode:~%Counter%,2!" == "f9" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ù& set DecimalCode=!DecimalCode!249,& set BinaryCode=!BinaryCode!11111001,
if /i "!HexCode:~%Counter%,2!" == "fa" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ú& set DecimalCode=!DecimalCode!250,& set BinaryCode=!BinaryCode!11111010,
if /i "!HexCode:~%Counter%,2!" == "fb" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!û& set DecimalCode=!DecimalCode!251,& set BinaryCode=!BinaryCode!11111011,
if /i "!HexCode:~%Counter%,2!" == "fc" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ü& set DecimalCode=!DecimalCode!252,& set BinaryCode=!BinaryCode!11111100,
if /i "!HexCode:~%Counter%,2!" == "fd" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ý& set DecimalCode=!DecimalCode!253,& set BinaryCode=!BinaryCode!11111101,
if /i "!HexCode:~%Counter%,2!" == "fe" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!þ& set DecimalCode=!DecimalCode!254,& set BinaryCode=!BinaryCode!11111110,
if /i "!HexCode:~%Counter%,2!" == "ff" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!ÿ& set DecimalCode=!DecimalCode!255,& set BinaryCode=!BinaryCode!11111111,


:: Check if an error occured
if "!AsciiCode_Puffer!" == "!AsciiCode!" set /a Counter=%Counter% + 1

goto :Conversion





:Finished


echo !HexCode! | find "  {p8UyY}" >nul 2>nul && set HexCode=!HexCode:~0,-9!
if "!HexCode:~0,1!" == "{" set AsciiCode={!AsciiCode!&set DecimalCode={!DecimalCode!&set BinaryCode={!BinaryCode!
if "!HexCode:~-1,1!" == "}" set AsciiCode=!AsciiCode!}&set DecimalCode=!DecimalCode!}&set BinaryCode=!BinaryCode!}


echo Hex:   !HexCode! 1>Hex2All.tmp
echo Dec:   !DecimalCode! 1>>Hex2All.tmp
echo Ascii: !AsciiCode! 1>>Hex2All.tmp
echo Bin:   !BinaryCode! 1>>Hex2All.tmp
start notepad "%temp%\Hex2All.tmp"
echo Dec:   !DecimalCode!
echo Ascii: !AsciiCode!     ^<- in CMD
echo Bin:   !BinaryCode!
echo.
echo.
if "%~1" == "ReadingOutFile" exit /b
goto :Start


:ResetVariables
set Counter=0
set AsciiCode=
set AsciiCode_Puffer=
set DecimalCode=
set BinaryCode=
set HexCode=
exit /b