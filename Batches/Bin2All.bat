@echo off
title Binary2Ascii converter
setlocal enabledelayedexpansion
pushd %temp%


:Start
:: Reset variables
set Counter=0
set AsciiCode=
set AsciiCode_Puffer=
set DecimalCode=
set BinaryCode=
set HexCode=

:: Ask for hexadecimal code
set /p BinaryCode=Bin:   

:: Check the beginning and the end for parantheses
if "%BinaryCode:~0,1%" == "{" set Counter=1
set BinaryCode=!BinaryCode!  {p8UyY}


:Conversion

set AsciiCode_Puffer=!AsciiCode!

:: Check if finished
if "!BinaryCode:~%Counter%,9!" == "  {p8UyY}" goto :Finished

:: Check for symbols and spaces
if "!BinaryCode:~%Counter%,1!" == "-" set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == " " set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == "," set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == "|" set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == "." set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == ":" set /a Counter=%Counter% + 1 & goto :Conversion
if "!BinaryCode:~%Counter%,1!" == ";" set /a Counter=%Counter% + 1 & goto :Conversion

:: Start of conversion from hex to ascii
if "!BinaryCode:~%Counter%,8!" == "00000000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{NUL}& set DecimalCode=!DecimalCode!0,& set HexCode=!HexCode!00,
if "!BinaryCode:~%Counter%,8!" == "00000001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!1,& set HexCode=!HexCode!01,
if "!BinaryCode:~%Counter%,8!" == "00000010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!2,& set HexCode=!HexCode!02,
if "!BinaryCode:~%Counter%,8!" == "00000011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!3,& set HexCode=!HexCode!03,
if "!BinaryCode:~%Counter%,8!" == "00000100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!4,& set HexCode=!HexCode!04,
if "!BinaryCode:~%Counter%,8!" == "00000101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!5,& set HexCode=!HexCode!05,
if "!BinaryCode:~%Counter%,8!" == "00000110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!6,& set HexCode=!HexCode!06,
if "!BinaryCode:~%Counter%,8!" == "00000111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{BEL}& set DecimalCode=!DecimalCode!7,& set HexCode=!HexCode!07,
if "!BinaryCode:~%Counter%,8!" == "00001000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!8,& set HexCode=!HexCode!08,
if "!BinaryCode:~%Counter%,8!" == "00001001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!	& set DecimalCode=!DecimalCode!9,& set HexCode=!HexCode!09,
if "!BinaryCode:~%Counter%,8!" == "00001010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{LF}& set DecimalCode=!DecimalCode!10,& set HexCode=!HexCode!0a,
if "!BinaryCode:~%Counter%,8!" == "00001011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!11,& set HexCode=!HexCode!0b,
if "!BinaryCode:~%Counter%,8!" == "00001100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!12,& set HexCode=!HexCode!0c,
if "!BinaryCode:~%Counter%,8!" == "00001101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{CR}& set DecimalCode=!DecimalCode!13,& set HexCode=!HexCode!0d,
if "!BinaryCode:~%Counter%,8!" == "00001110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!14,& set HexCode=!HexCode!0e,
if "!BinaryCode:~%Counter%,8!" == "00001111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!15,& set HexCode=!HexCode!0f,

if "!BinaryCode:~%Counter%,8!" == "00010000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!16,& set HexCode=!HexCode!10,
if "!BinaryCode:~%Counter%,8!" == "00010001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!17,& set HexCode=!HexCode!11,
if "!BinaryCode:~%Counter%,8!" == "00010010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!18,& set HexCode=!HexCode!12,
if "!BinaryCode:~%Counter%,8!" == "00010011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!19,& set HexCode=!HexCode!13,
if "!BinaryCode:~%Counter%,8!" == "00010100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!20,& set HexCode=!HexCode!14,
if "!BinaryCode:~%Counter%,8!" == "00010101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!21,& set HexCode=!HexCode!15,
if "!BinaryCode:~%Counter%,8!" == "00010110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!22,& set HexCode=!HexCode!16,
if "!BinaryCode:~%Counter%,8!" == "00010111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!23,& set HexCode=!HexCode!17,
if "!BinaryCode:~%Counter%,8!" == "00011000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!24,& set HexCode=!HexCode!18,
if "!BinaryCode:~%Counter%,8!" == "00011001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!25,& set HexCode=!HexCode!19,
if "!BinaryCode:~%Counter%,8!" == "00011010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{SUB}& set DecimalCode=!DecimalCode!26,& set HexCode=!HexCode!1a,
if "!BinaryCode:~%Counter%,8!" == "00011011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{ESC}& set DecimalCode=!DecimalCode!27,& set HexCode=!HexCode!1b,
if "!BinaryCode:~%Counter%,8!" == "00011100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!28,& set HexCode=!HexCode!1c,
if "!BinaryCode:~%Counter%,8!" == "00011101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!29,& set HexCode=!HexCode!1d,
if "!BinaryCode:~%Counter%,8!" == "00011110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!30,& set HexCode=!HexCode!1e,
if "!BinaryCode:~%Counter%,8!" == "00011111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!31,& set HexCode=!HexCode!1f,

if "!BinaryCode:~%Counter%,8!" == "00100000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode! & set DecimalCode=!DecimalCode!32,& set HexCode=!HexCode!20,
if "!BinaryCode:~%Counter%,8!" == "00100001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!!& set DecimalCode=!DecimalCode!33,& set HexCode=!HexCode!21,
if "!BinaryCode:~%Counter%,8!" == "00100010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!"& set DecimalCode=!DecimalCode!34,& set HexCode=!HexCode!22,
if "!BinaryCode:~%Counter%,8!" == "00100011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!#& set DecimalCode=!DecimalCode!35,& set HexCode=!HexCode!23,
if "!BinaryCode:~%Counter%,8!" == "00100100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!$& set DecimalCode=!DecimalCode!36,& set HexCode=!HexCode!24,
if "!BinaryCode:~%Counter%,8!" == "00100101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!%%& set DecimalCode=!DecimalCode!37,& set HexCode=!HexCode!25,
if "!BinaryCode:~%Counter%,8!" == "00100110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^&& set DecimalCode=!DecimalCode!38,& set HexCode=!HexCode!26,
if "!BinaryCode:~%Counter%,8!" == "00100111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!'& set DecimalCode=!DecimalCode!39,& set HexCode=!HexCode!27,
if "!BinaryCode:~%Counter%,8!" == "00101000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^(& set DecimalCode=!DecimalCode!40,& set HexCode=!HexCode!28,
if "!BinaryCode:~%Counter%,8!" == "00101001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^)& set DecimalCode=!DecimalCode!41,& set HexCode=!HexCode!29,
if "!BinaryCode:~%Counter%,8!" == "00101010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!*& set DecimalCode=!DecimalCode!42,& set HexCode=!HexCode!2a,
if "!BinaryCode:~%Counter%,8!" == "00101011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!+& set DecimalCode=!DecimalCode!43,& set HexCode=!HexCode!2b,
if "!BinaryCode:~%Counter%,8!" == "00101100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!,& set DecimalCode=!DecimalCode!44,& set HexCode=!HexCode!2c,
if "!BinaryCode:~%Counter%,8!" == "00101101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!-& set DecimalCode=!DecimalCode!45,& set HexCode=!HexCode!2d,
if "!BinaryCode:~%Counter%,8!" == "00101110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!.& set DecimalCode=!DecimalCode!46,& set HexCode=!HexCode!2e,
if "!BinaryCode:~%Counter%,8!" == "00101111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!/& set DecimalCode=!DecimalCode!47,& set HexCode=!HexCode!2f,

if "!BinaryCode:~%Counter%,8!" == "00110000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!0& set DecimalCode=!DecimalCode!48,& set HexCode=!HexCode!30,
if "!BinaryCode:~%Counter%,8!" == "00110001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!1& set DecimalCode=!DecimalCode!49,& set HexCode=!HexCode!31,
if "!BinaryCode:~%Counter%,8!" == "00110010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!2& set DecimalCode=!DecimalCode!50,& set HexCode=!HexCode!32,
if "!BinaryCode:~%Counter%,8!" == "00110011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!3& set DecimalCode=!DecimalCode!51,& set HexCode=!HexCode!33,
if "!BinaryCode:~%Counter%,8!" == "00110100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!4& set DecimalCode=!DecimalCode!52,& set HexCode=!HexCode!34,
if "!BinaryCode:~%Counter%,8!" == "00110101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!5& set DecimalCode=!DecimalCode!53,& set HexCode=!HexCode!35,
if "!BinaryCode:~%Counter%,8!" == "00110110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!6& set DecimalCode=!DecimalCode!54,& set HexCode=!HexCode!36,
if "!BinaryCode:~%Counter%,8!" == "00110111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!7& set DecimalCode=!DecimalCode!55,& set HexCode=!HexCode!37,
if "!BinaryCode:~%Counter%,8!" == "00111000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!8& set DecimalCode=!DecimalCode!56,& set HexCode=!HexCode!38,
if "!BinaryCode:~%Counter%,8!" == "00111001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!9& set DecimalCode=!DecimalCode!57,& set HexCode=!HexCode!39,
if "!BinaryCode:~%Counter%,8!" == "00111010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!:& set DecimalCode=!DecimalCode!58,& set HexCode=!HexCode!3a,
if "!BinaryCode:~%Counter%,8!" == "00111011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!;& set DecimalCode=!DecimalCode!59,& set HexCode=!HexCode!3b,
if "!BinaryCode:~%Counter%,8!" == "00111100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^<& set DecimalCode=!DecimalCode!60,& set HexCode=!HexCode!3c,
if "!BinaryCode:~%Counter%,8!" == "00111101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!=& set DecimalCode=!DecimalCode!61,& set HexCode=!HexCode!3d,
if "!BinaryCode:~%Counter%,8!" == "00111110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^>& set DecimalCode=!DecimalCode!62,& set HexCode=!HexCode!3e,
if "!BinaryCode:~%Counter%,8!" == "00111111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!?& set DecimalCode=!DecimalCode!63,& set HexCode=!HexCode!3f,

if "!BinaryCode:~%Counter%,8!" == "01000000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!@& set DecimalCode=!DecimalCode!64,& set HexCode=!HexCode!40,
if "!BinaryCode:~%Counter%,8!" == "01000001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!A& set DecimalCode=!DecimalCode!65,& set HexCode=!HexCode!41,
if "!BinaryCode:~%Counter%,8!" == "01000010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!B& set DecimalCode=!DecimalCode!66,& set HexCode=!HexCode!42,
if "!BinaryCode:~%Counter%,8!" == "01000011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!C& set DecimalCode=!DecimalCode!67,& set HexCode=!HexCode!43,
if "!BinaryCode:~%Counter%,8!" == "01000100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!D& set DecimalCode=!DecimalCode!68,& set HexCode=!HexCode!44,
if "!BinaryCode:~%Counter%,8!" == "01000101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!E& set DecimalCode=!DecimalCode!69,& set HexCode=!HexCode!45,
if "!BinaryCode:~%Counter%,8!" == "01000110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!F& set DecimalCode=!DecimalCode!70,& set HexCode=!HexCode!46,
if "!BinaryCode:~%Counter%,8!" == "01000111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!G& set DecimalCode=!DecimalCode!71,& set HexCode=!HexCode!47,
if "!BinaryCode:~%Counter%,8!" == "01001000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!H& set DecimalCode=!DecimalCode!72,& set HexCode=!HexCode!48,
if "!BinaryCode:~%Counter%,8!" == "01001001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!I& set DecimalCode=!DecimalCode!73,& set HexCode=!HexCode!49,
if "!BinaryCode:~%Counter%,8!" == "01001010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!J& set DecimalCode=!DecimalCode!74,& set HexCode=!HexCode!4a,
if "!BinaryCode:~%Counter%,8!" == "01001011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!K& set DecimalCode=!DecimalCode!75,& set HexCode=!HexCode!4b,
if "!BinaryCode:~%Counter%,8!" == "01001100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!L& set DecimalCode=!DecimalCode!76,& set HexCode=!HexCode!4c,
if "!BinaryCode:~%Counter%,8!" == "01001101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!M& set DecimalCode=!DecimalCode!77,& set HexCode=!HexCode!4d,
if "!BinaryCode:~%Counter%,8!" == "01001110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!N& set DecimalCode=!DecimalCode!78,& set HexCode=!HexCode!4e,
if "!BinaryCode:~%Counter%,8!" == "01001111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!O& set DecimalCode=!DecimalCode!79,& set HexCode=!HexCode!4f,

if "!BinaryCode:~%Counter%,8!" == "01010000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!P& set DecimalCode=!DecimalCode!80,& set HexCode=!HexCode!50,
if "!BinaryCode:~%Counter%,8!" == "01010001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Q& set DecimalCode=!DecimalCode!81,& set HexCode=!HexCode!51,
if "!BinaryCode:~%Counter%,8!" == "01010010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!R& set DecimalCode=!DecimalCode!82,& set HexCode=!HexCode!52,
if "!BinaryCode:~%Counter%,8!" == "01010011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!S& set DecimalCode=!DecimalCode!83,& set HexCode=!HexCode!53,
if "!BinaryCode:~%Counter%,8!" == "01010100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!T& set DecimalCode=!DecimalCode!84,& set HexCode=!HexCode!54,
if "!BinaryCode:~%Counter%,8!" == "01010101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!U& set DecimalCode=!DecimalCode!85,& set HexCode=!HexCode!55,
if "!BinaryCode:~%Counter%,8!" == "01010110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!V& set DecimalCode=!DecimalCode!86,& set HexCode=!HexCode!56,
if "!BinaryCode:~%Counter%,8!" == "01010111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!W& set DecimalCode=!DecimalCode!87,& set HexCode=!HexCode!57,
if "!BinaryCode:~%Counter%,8!" == "01011000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!X& set DecimalCode=!DecimalCode!88,& set HexCode=!HexCode!58,
if "!BinaryCode:~%Counter%,8!" == "01011001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Y& set DecimalCode=!DecimalCode!89,& set HexCode=!HexCode!59,
if "!BinaryCode:~%Counter%,8!" == "01011010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Z& set DecimalCode=!DecimalCode!90,& set HexCode=!HexCode!5a,
if "!BinaryCode:~%Counter%,8!" == "01011011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode![& set DecimalCode=!DecimalCode!91,& set HexCode=!HexCode!5b,
if "!BinaryCode:~%Counter%,8!" == "01011100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!\& set DecimalCode=!DecimalCode!92,& set HexCode=!HexCode!5c,
if "!BinaryCode:~%Counter%,8!" == "01011101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!]& set DecimalCode=!DecimalCode!93,& set HexCode=!HexCode!5d,
if "!BinaryCode:~%Counter%,8!" == "01011110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^^& set DecimalCode=!DecimalCode!94,& set HexCode=!HexCode!5e,
if "!BinaryCode:~%Counter%,8!" == "01011111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!_& set DecimalCode=!DecimalCode!95,& set HexCode=!HexCode!5f,

if "!BinaryCode:~%Counter%,8!" == "01100000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!`& set DecimalCode=!DecimalCode!96,& set HexCode=!HexCode!60,
if "!BinaryCode:~%Counter%,8!" == "01100001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!a& set DecimalCode=!DecimalCode!97,& set HexCode=!HexCode!61,
if "!BinaryCode:~%Counter%,8!" == "01100010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!b& set DecimalCode=!DecimalCode!98,& set HexCode=!HexCode!62,
if "!BinaryCode:~%Counter%,8!" == "01100011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!c& set DecimalCode=!DecimalCode!99,& set HexCode=!HexCode!63,
if "!BinaryCode:~%Counter%,8!" == "01100100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!d& set DecimalCode=!DecimalCode!100,& set HexCode=!HexCode!64,
if "!BinaryCode:~%Counter%,8!" == "01100101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!e& set DecimalCode=!DecimalCode!101,& set HexCode=!HexCode!65,
if "!BinaryCode:~%Counter%,8!" == "01100110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!f& set DecimalCode=!DecimalCode!102,& set HexCode=!HexCode!66,
if "!BinaryCode:~%Counter%,8!" == "01100111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!g& set DecimalCode=!DecimalCode!103,& set HexCode=!HexCode!67,
if "!BinaryCode:~%Counter%,8!" == "01101000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!h& set DecimalCode=!DecimalCode!104,& set HexCode=!HexCode!68,
if "!BinaryCode:~%Counter%,8!" == "01101001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!i& set DecimalCode=!DecimalCode!105,& set HexCode=!HexCode!69,
if "!BinaryCode:~%Counter%,8!" == "01101010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!j& set DecimalCode=!DecimalCode!106,& set HexCode=!HexCode!6a,
if "!BinaryCode:~%Counter%,8!" == "01101011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!k& set DecimalCode=!DecimalCode!107,& set HexCode=!HexCode!6b,
if "!BinaryCode:~%Counter%,8!" == "01101100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!l& set DecimalCode=!DecimalCode!108,& set HexCode=!HexCode!6c,
if "!BinaryCode:~%Counter%,8!" == "01101101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!m& set DecimalCode=!DecimalCode!109,& set HexCode=!HexCode!6d,
if "!BinaryCode:~%Counter%,8!" == "01101110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!n& set DecimalCode=!DecimalCode!110,& set HexCode=!HexCode!6e,
if "!BinaryCode:~%Counter%,8!" == "01101111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!o& set DecimalCode=!DecimalCode!111,& set HexCode=!HexCode!6f,

if "!BinaryCode:~%Counter%,8!" == "01110000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!p& set DecimalCode=!DecimalCode!112,& set HexCode=!HexCode!70,
if "!BinaryCode:~%Counter%,8!" == "01110001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!q& set DecimalCode=!DecimalCode!113,& set HexCode=!HexCode!71,
if "!BinaryCode:~%Counter%,8!" == "01110010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!r& set DecimalCode=!DecimalCode!114,& set HexCode=!HexCode!72,
if "!BinaryCode:~%Counter%,8!" == "01110011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!s& set DecimalCode=!DecimalCode!115,& set HexCode=!HexCode!73,
if "!BinaryCode:~%Counter%,8!" == "01110100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!t& set DecimalCode=!DecimalCode!116,& set HexCode=!HexCode!74,
if "!BinaryCode:~%Counter%,8!" == "01110101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!u& set DecimalCode=!DecimalCode!117,& set HexCode=!HexCode!75,
if "!BinaryCode:~%Counter%,8!" == "01110110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!v& set DecimalCode=!DecimalCode!118,& set HexCode=!HexCode!76,
if "!BinaryCode:~%Counter%,8!" == "01110111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!w& set DecimalCode=!DecimalCode!119,& set HexCode=!HexCode!77,
if "!BinaryCode:~%Counter%,8!" == "01111000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!x& set DecimalCode=!DecimalCode!120,& set HexCode=!HexCode!78,
if "!BinaryCode:~%Counter%,8!" == "01111001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!y& set DecimalCode=!DecimalCode!121,& set HexCode=!HexCode!79,
if "!BinaryCode:~%Counter%,8!" == "01111010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!z& set DecimalCode=!DecimalCode!122,& set HexCode=!HexCode!7a,
if "!BinaryCode:~%Counter%,8!" == "01111011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!{& set DecimalCode=!DecimalCode!123,& set HexCode=!HexCode!7b,
if "!BinaryCode:~%Counter%,8!" == "01111100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!^|& set DecimalCode=!DecimalCode!124,& set HexCode=!HexCode!7c,
if "!BinaryCode:~%Counter%,8!" == "01111101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!}& set DecimalCode=!DecimalCode!125,& set HexCode=!HexCode!7d,
if "!BinaryCode:~%Counter%,8!" == "01111110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!~& set DecimalCode=!DecimalCode!126,& set HexCode=!HexCode!7e,
if "!BinaryCode:~%Counter%,8!" == "01111111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!127,& set HexCode=!HexCode!7f,

if "!BinaryCode:~%Counter%,8!" == "10000000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!€& set DecimalCode=!DecimalCode!128,& set HexCode=!HexCode!80,
if "!BinaryCode:~%Counter%,8!" == "10000001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!129,& set HexCode=!HexCode!81,
if "!BinaryCode:~%Counter%,8!" == "10000010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!‚& set DecimalCode=!DecimalCode!130,& set HexCode=!HexCode!82,
if "!BinaryCode:~%Counter%,8!" == "10000011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ƒ& set DecimalCode=!DecimalCode!131,& set HexCode=!HexCode!83,
if "!BinaryCode:~%Counter%,8!" == "10000100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!„& set DecimalCode=!DecimalCode!132,& set HexCode=!HexCode!84,
if "!BinaryCode:~%Counter%,8!" == "10000101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!…& set DecimalCode=!DecimalCode!133,& set HexCode=!HexCode!85,
if "!BinaryCode:~%Counter%,8!" == "10000110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!†& set DecimalCode=!DecimalCode!134,& set HexCode=!HexCode!86,
if "!BinaryCode:~%Counter%,8!" == "10000111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!‡& set DecimalCode=!DecimalCode!135,& set HexCode=!HexCode!87,
if "!BinaryCode:~%Counter%,8!" == "10001000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ˆ& set DecimalCode=!DecimalCode!136,& set HexCode=!HexCode!88,
if "!BinaryCode:~%Counter%,8!" == "8100010019" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!‰& set DecimalCode=!DecimalCode!137,& set HexCode=!HexCode!89,
if "!BinaryCode:~%Counter%,8!" == "10001010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Š& set DecimalCode=!DecimalCode!138,& set HexCode=!HexCode!8a,
if "!BinaryCode:~%Counter%,8!" == "10001011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!‹& set DecimalCode=!DecimalCode!139,& set HexCode=!HexCode!8b,
if "!BinaryCode:~%Counter%,8!" == "10001100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Œ& set DecimalCode=!DecimalCode!140,& set HexCode=!HexCode!8c,
if "!BinaryCode:~%Counter%,8!" == "10001101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!141,& set HexCode=!HexCode!8d,
if "!BinaryCode:~%Counter%,8!" == "10001110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ž& set DecimalCode=!DecimalCode!142,& set HexCode=!HexCode!8e,
if "!BinaryCode:~%Counter%,8!" == "10001111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!143,& set HexCode=!HexCode!8f,

if "!BinaryCode:~%Counter%,8!" == "10010000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!144,& set HexCode=!HexCode!90,
if "!BinaryCode:~%Counter%,8!" == "10010001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!‘& set DecimalCode=!DecimalCode!145,& set HexCode=!HexCode!91,
if "!BinaryCode:~%Counter%,8!" == "10010010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!’& set DecimalCode=!DecimalCode!146,& set HexCode=!HexCode!92,
if "!BinaryCode:~%Counter%,8!" == "10010011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!“& set DecimalCode=!DecimalCode!147,& set HexCode=!HexCode!93,
if "!BinaryCode:~%Counter%,8!" == "10010100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!”& set DecimalCode=!DecimalCode!148,& set HexCode=!HexCode!94,
if "!BinaryCode:~%Counter%,8!" == "10010101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!•& set DecimalCode=!DecimalCode!149,& set HexCode=!HexCode!95,
if "!BinaryCode:~%Counter%,8!" == "10010110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!–& set DecimalCode=!DecimalCode!150,& set HexCode=!HexCode!96,
if "!BinaryCode:~%Counter%,8!" == "10010111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!—& set DecimalCode=!DecimalCode!151,& set HexCode=!HexCode!97,
if "!BinaryCode:~%Counter%,8!" == "10011000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!˜& set DecimalCode=!DecimalCode!152,& set HexCode=!HexCode!98,
if "!BinaryCode:~%Counter%,8!" == "10011001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!™& set DecimalCode=!DecimalCode!153,& set HexCode=!HexCode!99,
if "!BinaryCode:~%Counter%,8!" == "10011010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!š& set DecimalCode=!DecimalCode!154,& set HexCode=!HexCode!9a,
if "!BinaryCode:~%Counter%,8!" == "10011011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!›& set DecimalCode=!DecimalCode!155,& set HexCode=!HexCode!9b,
if "!BinaryCode:~%Counter%,8!" == "10011100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!œ& set DecimalCode=!DecimalCode!156,& set HexCode=!HexCode!9c,
if "!BinaryCode:~%Counter%,8!" == "10011101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!& set DecimalCode=!DecimalCode!157,& set HexCode=!HexCode!9d,
if "!BinaryCode:~%Counter%,8!" == "10011110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ž& set DecimalCode=!DecimalCode!158,& set HexCode=!HexCode!9e,
if "!BinaryCode:~%Counter%,8!" == "10011111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ÿ& set DecimalCode=!DecimalCode!159,& set HexCode=!HexCode!9f,

if "!BinaryCode:~%Counter%,8!" == "10100000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode! & set DecimalCode=!DecimalCode!160,& set HexCode=!HexCode!a0,
if "!BinaryCode:~%Counter%,8!" == "10100001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¡& set DecimalCode=!DecimalCode!161,& set HexCode=!HexCode!a1,
if "!BinaryCode:~%Counter%,8!" == "10100010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¢& set DecimalCode=!DecimalCode!162,& set HexCode=!HexCode!a2,
if "!BinaryCode:~%Counter%,8!" == "10100011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!£& set DecimalCode=!DecimalCode!163,& set HexCode=!HexCode!a3,
if "!BinaryCode:~%Counter%,8!" == "10100100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¤& set DecimalCode=!DecimalCode!164,& set HexCode=!HexCode!a4,
if "!BinaryCode:~%Counter%,8!" == "10100101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¥& set DecimalCode=!DecimalCode!165,& set HexCode=!HexCode!a5,
if "!BinaryCode:~%Counter%,8!" == "10100110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¦& set DecimalCode=!DecimalCode!166,& set HexCode=!HexCode!a6,
if "!BinaryCode:~%Counter%,8!" == "10100111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!§& set DecimalCode=!DecimalCode!167,& set HexCode=!HexCode!a7,
if "!BinaryCode:~%Counter%,8!" == "10101000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¨& set DecimalCode=!DecimalCode!168,& set HexCode=!HexCode!a8,
if "!BinaryCode:~%Counter%,8!" == "10101001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!©& set DecimalCode=!DecimalCode!169,& set HexCode=!HexCode!a9,
if "!BinaryCode:~%Counter%,8!" == "10101010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ª& set DecimalCode=!DecimalCode!170,& set HexCode=!HexCode!aa,
if "!BinaryCode:~%Counter%,8!" == "10101011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!«& set DecimalCode=!DecimalCode!171,& set HexCode=!HexCode!ab,
if "!BinaryCode:~%Counter%,8!" == "10101100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¬& set DecimalCode=!DecimalCode!172,& set HexCode=!HexCode!ac,
if "!BinaryCode:~%Counter%,8!" == "10101101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!­& set DecimalCode=!DecimalCode!173,& set HexCode=!HexCode!ad,
if "!BinaryCode:~%Counter%,8!" == "10101110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!®& set DecimalCode=!DecimalCode!174,& set HexCode=!HexCode!ae,
if "!BinaryCode:~%Counter%,8!" == "10101111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¯& set DecimalCode=!DecimalCode!175,& set HexCode=!HexCode!af,

if "!BinaryCode:~%Counter%,8!" == "10110000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!°& set DecimalCode=!DecimalCode!176,& set HexCode=!HexCode!b0,
if "!BinaryCode:~%Counter%,8!" == "10110001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!±& set DecimalCode=!DecimalCode!177,& set HexCode=!HexCode!b1,
if "!BinaryCode:~%Counter%,8!" == "10110010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!²& set DecimalCode=!DecimalCode!178,& set HexCode=!HexCode!b2,
if "!BinaryCode:~%Counter%,8!" == "10110011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!³& set DecimalCode=!DecimalCode!179,& set HexCode=!HexCode!b3,
if "!BinaryCode:~%Counter%,8!" == "10110100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!´& set DecimalCode=!DecimalCode!180,& set HexCode=!HexCode!b4,
if "!BinaryCode:~%Counter%,8!" == "10110101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!µ& set DecimalCode=!DecimalCode!181,& set HexCode=!HexCode!b5,
if "!BinaryCode:~%Counter%,8!" == "10110110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¶& set DecimalCode=!DecimalCode!182,& set HexCode=!HexCode!b6,
if "!BinaryCode:~%Counter%,8!" == "10110111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!·& set DecimalCode=!DecimalCode!183,& set HexCode=!HexCode!b7,
if "!BinaryCode:~%Counter%,8!" == "10111000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¸& set DecimalCode=!DecimalCode!184,& set HexCode=!HexCode!b8,
if "!BinaryCode:~%Counter%,8!" == "10111001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¹& set DecimalCode=!DecimalCode!185,& set HexCode=!HexCode!b9,
if "!BinaryCode:~%Counter%,8!" == "10111010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!º& set DecimalCode=!DecimalCode!186,& set HexCode=!HexCode!ba,
if "!BinaryCode:~%Counter%,8!" == "10111011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!»& set DecimalCode=!DecimalCode!187,& set HexCode=!HexCode!bb,
if "!BinaryCode:~%Counter%,8!" == "10111100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¼& set DecimalCode=!DecimalCode!188,& set HexCode=!HexCode!bc,
if "!BinaryCode:~%Counter%,8!" == "10111101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!½& set DecimalCode=!DecimalCode!189,& set HexCode=!HexCode!bd,
if "!BinaryCode:~%Counter%,8!" == "10111110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¾& set DecimalCode=!DecimalCode!190,& set HexCode=!HexCode!be,
if "!BinaryCode:~%Counter%,8!" == "10111111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!¿& set DecimalCode=!DecimalCode!191,& set HexCode=!HexCode!bf,

if "!BinaryCode:~%Counter%,8!" == "11000000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!À& set DecimalCode=!DecimalCode!192,& set HexCode=!HexCode!c0,
if "!BinaryCode:~%Counter%,8!" == "11000001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Á& set DecimalCode=!DecimalCode!193,& set HexCode=!HexCode!c1,
if "!BinaryCode:~%Counter%,8!" == "11000010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Â& set DecimalCode=!DecimalCode!194,& set HexCode=!HexCode!c2,
if "!BinaryCode:~%Counter%,8!" == "11000011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ã& set DecimalCode=!DecimalCode!195,& set HexCode=!HexCode!c3,
if "!BinaryCode:~%Counter%,8!" == "11000100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ä& set DecimalCode=!DecimalCode!196,& set HexCode=!HexCode!c4,
if "!BinaryCode:~%Counter%,8!" == "11000101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Å& set DecimalCode=!DecimalCode!197,& set HexCode=!HexCode!c5,
if "!BinaryCode:~%Counter%,8!" == "11000110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Æ& set DecimalCode=!DecimalCode!198,& set HexCode=!HexCode!c6,
if "!BinaryCode:~%Counter%,8!" == "11000111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ç& set DecimalCode=!DecimalCode!199,& set HexCode=!HexCode!c7,
if "!BinaryCode:~%Counter%,8!" == "11001000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!È& set DecimalCode=!DecimalCode!200,& set HexCode=!HexCode!c8,
if "!BinaryCode:~%Counter%,8!" == "11001001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!É& set DecimalCode=!DecimalCode!201,& set HexCode=!HexCode!c9,
if "!BinaryCode:~%Counter%,8!" == "11001010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ê& set DecimalCode=!DecimalCode!202,& set HexCode=!HexCode!ca,
if "!BinaryCode:~%Counter%,8!" == "11001011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ë& set DecimalCode=!DecimalCode!203,& set HexCode=!HexCode!cb,
if "!BinaryCode:~%Counter%,8!" == "11001100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ì& set DecimalCode=!DecimalCode!204,& set HexCode=!HexCode!cc,
if "!BinaryCode:~%Counter%,8!" == "11001101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Í& set DecimalCode=!DecimalCode!205,& set HexCode=!HexCode!cd,
if "!BinaryCode:~%Counter%,8!" == "11001110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Î& set DecimalCode=!DecimalCode!206,& set HexCode=!HexCode!ce,
if "!BinaryCode:~%Counter%,8!" == "11001111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ï& set DecimalCode=!DecimalCode!207,& set HexCode=!HexCode!cf,

if "!BinaryCode:~%Counter%,8!" == "11010000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ð& set DecimalCode=!DecimalCode!208,& set HexCode=!HexCode!d0,
if "!BinaryCode:~%Counter%,8!" == "11010001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ñ& set DecimalCode=!DecimalCode!209,& set HexCode=!HexCode!d1,
if "!BinaryCode:~%Counter%,8!" == "11010010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ò& set DecimalCode=!DecimalCode!210,& set HexCode=!HexCode!d2,
if "!BinaryCode:~%Counter%,8!" == "11010011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ó& set DecimalCode=!DecimalCode!211,& set HexCode=!HexCode!d3,
if "!BinaryCode:~%Counter%,8!" == "11010100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ô& set DecimalCode=!DecimalCode!212,& set HexCode=!HexCode!d4,
if "!BinaryCode:~%Counter%,8!" == "11010101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Õ& set DecimalCode=!DecimalCode!213,& set HexCode=!HexCode!d5,
if "!BinaryCode:~%Counter%,8!" == "11010110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ö& set DecimalCode=!DecimalCode!214,& set HexCode=!HexCode!d6,
if "!BinaryCode:~%Counter%,8!" == "11010111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!×& set DecimalCode=!DecimalCode!215,& set HexCode=!HexCode!d7,
if "!BinaryCode:~%Counter%,8!" == "11011000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ø& set DecimalCode=!DecimalCode!216,& set HexCode=!HexCode!d8,
if "!BinaryCode:~%Counter%,8!" == "11011001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ù& set DecimalCode=!DecimalCode!217,& set HexCode=!HexCode!d9,
if "!BinaryCode:~%Counter%,8!" == "11011010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ú& set DecimalCode=!DecimalCode!218,& set HexCode=!HexCode!da,
if "!BinaryCode:~%Counter%,8!" == "11011011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Û& set DecimalCode=!DecimalCode!219,& set HexCode=!HexCode!db,
if "!BinaryCode:~%Counter%,8!" == "11011100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ü& set DecimalCode=!DecimalCode!220,& set HexCode=!HexCode!dc,
if "!BinaryCode:~%Counter%,8!" == "11011101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Ý& set DecimalCode=!DecimalCode!221,& set HexCode=!HexCode!dd,
if "!BinaryCode:~%Counter%,8!" == "11011110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!Þ& set DecimalCode=!DecimalCode!222,& set HexCode=!HexCode!de,
if "!BinaryCode:~%Counter%,8!" == "11011111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ß& set DecimalCode=!DecimalCode!223,& set HexCode=!HexCode!df,

if "!BinaryCode:~%Counter%,8!" == "11100000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!à& set DecimalCode=!DecimalCode!224,& set HexCode=!HexCode!e0,
if "!BinaryCode:~%Counter%,8!" == "11100001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!á& set DecimalCode=!DecimalCode!225,& set HexCode=!HexCode!e1,
if "!BinaryCode:~%Counter%,8!" == "11100010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!â& set DecimalCode=!DecimalCode!226,& set HexCode=!HexCode!e2,
if "!BinaryCode:~%Counter%,8!" == "11100011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ã& set DecimalCode=!DecimalCode!227,& set HexCode=!HexCode!e3,
if "!BinaryCode:~%Counter%,8!" == "11100100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ä& set DecimalCode=!DecimalCode!228,& set HexCode=!HexCode!e4,
if "!BinaryCode:~%Counter%,8!" == "11100101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!å& set DecimalCode=!DecimalCode!229,& set HexCode=!HexCode!e5,
if "!BinaryCode:~%Counter%,8!" == "11100110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!æ& set DecimalCode=!DecimalCode!230,& set HexCode=!HexCode!e6,
if "!BinaryCode:~%Counter%,8!" == "11100111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ç& set DecimalCode=!DecimalCode!231,& set HexCode=!HexCode!e7,
if "!BinaryCode:~%Counter%,8!" == "11101000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!è& set DecimalCode=!DecimalCode!232,& set HexCode=!HexCode!e8,
if "!BinaryCode:~%Counter%,8!" == "11101001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!é& set DecimalCode=!DecimalCode!233,& set HexCode=!HexCode!e9,
if "!BinaryCode:~%Counter%,8!" == "11101010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ê& set DecimalCode=!DecimalCode!234,& set HexCode=!HexCode!ea,
if "!BinaryCode:~%Counter%,8!" == "11101011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ë& set DecimalCode=!DecimalCode!235,& set HexCode=!HexCode!eb,
if "!BinaryCode:~%Counter%,8!" == "11101100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ì& set DecimalCode=!DecimalCode!236,& set HexCode=!HexCode!ec,
if "!BinaryCode:~%Counter%,8!" == "11101101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!í& set DecimalCode=!DecimalCode!237,& set HexCode=!HexCode!ed,
if "!BinaryCode:~%Counter%,8!" == "11101110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!î& set DecimalCode=!DecimalCode!238,& set HexCode=!HexCode!ee,
if "!BinaryCode:~%Counter%,8!" == "11101111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ï& set DecimalCode=!DecimalCode!239,& set HexCode=!HexCode!ef,

if "!BinaryCode:~%Counter%,8!" == "11110000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ð& set DecimalCode=!DecimalCode!240,& set HexCode=!HexCode!f0,
if "!BinaryCode:~%Counter%,8!" == "11110001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ñ& set DecimalCode=!DecimalCode!241,& set HexCode=!HexCode!f1,
if "!BinaryCode:~%Counter%,8!" == "11110010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ò& set DecimalCode=!DecimalCode!242,& set HexCode=!HexCode!f2,
if "!BinaryCode:~%Counter%,8!" == "11110011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ó& set DecimalCode=!DecimalCode!243,& set HexCode=!HexCode!f3,
if "!BinaryCode:~%Counter%,8!" == "11110100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ô& set DecimalCode=!DecimalCode!244,& set HexCode=!HexCode!f4,
if "!BinaryCode:~%Counter%,8!" == "11110101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!õ& set DecimalCode=!DecimalCode!245,& set HexCode=!HexCode!f5,
if "!BinaryCode:~%Counter%,8!" == "11110110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ö& set DecimalCode=!DecimalCode!246,& set HexCode=!HexCode!f6,
if "!BinaryCode:~%Counter%,8!" == "11110111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!÷& set DecimalCode=!DecimalCode!247,& set HexCode=!HexCode!f7,
if "!BinaryCode:~%Counter%,8!" == "11111000" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ø& set DecimalCode=!DecimalCode!248,& set HexCode=!HexCode!f8,
if "!BinaryCode:~%Counter%,8!" == "11111001" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ù& set DecimalCode=!DecimalCode!249,& set HexCode=!HexCode!f9,
if "!BinaryCode:~%Counter%,8!" == "11111010" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ú& set DecimalCode=!DecimalCode!250,& set HexCode=!HexCode!fa,
if "!BinaryCode:~%Counter%,8!" == "11111011" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!û& set DecimalCode=!DecimalCode!251,& set HexCode=!HexCode!fb,
if "!BinaryCode:~%Counter%,8!" == "11111100" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ü& set DecimalCode=!DecimalCode!252,& set HexCode=!HexCode!fc,
if "!BinaryCode:~%Counter%,8!" == "11111101" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ý& set DecimalCode=!DecimalCode!253,& set HexCode=!HexCode!fd,
if "!BinaryCode:~%Counter%,8!" == "11111110" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!þ& set DecimalCode=!DecimalCode!254,& set HexCode=!HexCode!fe,
if "!BinaryCode:~%Counter%,8!" == "11111111" set /a Counter=%Counter% + 8 & set AsciiCode=!AsciiCode!ÿ& set DecimalCode=!DecimalCode!255,& set HexCode=!HexCode!ff,


:: Check if an error occured
if "!AsciiCode_Puffer!" == "!AsciiCode!" set /a Counter=%Counter% + 1

goto :Conversion





:Finished

echo !BinaryCode! | find "  {p8UyY}" >nul 2>nul && set BinaryCode=!BinaryCode:~0,-9!
if "!BinaryCode:~0,1!" == "{" set AsciiCode={!AsciiCode!&set DecimalCode={!DecimalCode!&set HexCode={!HexCode!
if "!BinaryCode:~-1,1!" == "}" set AsciiCode=!AsciiCode!}&set DecimalCode=!DecimalCode!}&set HexCode=!HexCode!}


echo Bin:   !BinaryCode! 1>Bin2All.tmp
echo Ascii: !AsciiCode! 1>>Bin2All.tmp
echo Dec:   !DecimalCode! 1>>Bin2All.tmp
echo Hex:   !HexCode! 1>>Bin2All.tmp
start notepad "%temp%\Bin2All.tmp"
echo Ascii: !AsciiCode!     ^<- in CMD
echo Dec:   !DecimalCode!
echo Hex:   !HexCode!
echo.
echo.
goto :Start