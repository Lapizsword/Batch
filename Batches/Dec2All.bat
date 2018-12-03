@echo off
title Decimal2All converter
setlocal enabledelayedexpansion
pushd %temp%
echo Remember not to put numbers greater than 999 in.
echo ÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓ

set Quote="

:Start
:: Reset variables
set AsciiCode=
set AsciiCode_Puffer=
set BinaryCode=
set Counter=0
set DecimalCode=
set ErrorFound=
set HexCode=

:: Ask for decimal code
set /p DecimalCode=Dec:   
set DecimalCode=%DecimalCode%

:: Check the beginning and the end for parantheses
if "%DecimalCode:~0,1%" == "{" set Counter=1
if "%DecimalCode:~0,1%" == "(" set Counter=1
if "%DecimalCode:~0,1%" == "[" set Counter=1



:: Check for symbols
set DecimalCode=%DecimalCode:-= %
set DecimalCode=%DecimalCode:^&= %
set DecimalCode=%DecimalCode:^|= %
set DecimalCode=%DecimalCode:,= %
set DecimalCode=%DecimalCode::= %
set DecimalCode=%DecimalCode:;= %
set DecimalCode=%DecimalCode:.= %
set DecimalCode=%DecimalCode:/= %
set DecimalCode=%DecimalCode:\= %
set DecimalCode=%DecimalCode:{=%
set DecimalCode=%DecimalCode:}=%
set DecimalCode=%DecimalCode:^(=%
set DecimalCode=%DecimalCode:^)=%
set DecimalCode=%DecimalCode:[=%
set DecimalCode=%DecimalCode:]=%




:: Have a look at the end of code for more information.
call :ErrorSearch %DecimalCode%


:: Reset counter
set Counter=0


:Conversion
set AsciiCode_Puffer=!AsciiCode!

:: Check if finished
if "!DecimalCode:~%Counter%,9!" == "  {p8UyY}" goto :Finished

:: Check for commas as separation symbols
if "!DecimalCode:~%Counter%,1!" == "," set /a Counter=%Counter% + 1 & goto :Conversion


:: Start of conversion from hex to ascii
:: --- Reverse, because "100" also contains a "1" and twice a "0" which would cause [{SOH}{NUL}{NUL}].

if "!DecimalCode:~%Counter%,3!" == "100" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!d& set HexCode=!HexCode!64,& set BinaryCode=!BinaryCode!01100100,
if "!DecimalCode:~%Counter%,3!" == "101" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!e& set HexCode=!HexCode!65,& set BinaryCode=!BinaryCode!01100101,
if "!DecimalCode:~%Counter%,3!" == "102" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!f& set HexCode=!HexCode!66,& set BinaryCode=!BinaryCode!01100110,
if "!DecimalCode:~%Counter%,3!" == "103" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!g& set HexCode=!HexCode!67,& set BinaryCode=!BinaryCode!01100111,
if "!DecimalCode:~%Counter%,3!" == "104" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!h& set HexCode=!HexCode!68,& set BinaryCode=!BinaryCode!01101000,
if "!DecimalCode:~%Counter%,3!" == "105" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!i& set HexCode=!HexCode!69,& set BinaryCode=!BinaryCode!01101001,
if "!DecimalCode:~%Counter%,3!" == "106" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!j& set HexCode=!HexCode!6a,& set BinaryCode=!BinaryCode!01101010,
if "!DecimalCode:~%Counter%,3!" == "107" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!k& set HexCode=!HexCode!6b,& set BinaryCode=!BinaryCode!01101011,
if "!DecimalCode:~%Counter%,3!" == "108" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!l& set HexCode=!HexCode!6c,& set BinaryCode=!BinaryCode!01101100,
if "!DecimalCode:~%Counter%,3!" == "109" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!m& set HexCode=!HexCode!6d,& set BinaryCode=!BinaryCode!01101101,

if "!DecimalCode:~%Counter%,3!" == "110" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!n& set HexCode=!HexCode!6e,& set BinaryCode=!BinaryCode!01101110,
if "!DecimalCode:~%Counter%,3!" == "111" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!o& set HexCode=!HexCode!6f,& set BinaryCode=!BinaryCode!01101111,
if "!DecimalCode:~%Counter%,3!" == "112" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!p& set HexCode=!HexCode!70,& set BinaryCode=!BinaryCode!01110000,
if "!DecimalCode:~%Counter%,3!" == "113" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!q& set HexCode=!HexCode!71,& set BinaryCode=!BinaryCode!01110001,
if "!DecimalCode:~%Counter%,3!" == "114" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!r& set HexCode=!HexCode!72,& set BinaryCode=!BinaryCode!01110010,
if "!DecimalCode:~%Counter%,3!" == "115" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!s& set HexCode=!HexCode!73,& set BinaryCode=!BinaryCode!01110011,
if "!DecimalCode:~%Counter%,3!" == "116" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!t& set HexCode=!HexCode!74,& set BinaryCode=!BinaryCode!01110100,
if "!DecimalCode:~%Counter%,3!" == "117" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!u& set HexCode=!HexCode!75,& set BinaryCode=!BinaryCode!01110101,
if "!DecimalCode:~%Counter%,3!" == "118" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!v& set HexCode=!HexCode!76,& set BinaryCode=!BinaryCode!01110110,
if "!DecimalCode:~%Counter%,3!" == "119" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!w& set HexCode=!HexCode!77,& set BinaryCode=!BinaryCode!01110111,

if "!DecimalCode:~%Counter%,3!" == "120" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!x& set HexCode=!HexCode!78,& set BinaryCode=!BinaryCode!01111000,
if "!DecimalCode:~%Counter%,3!" == "121" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!y& set HexCode=!HexCode!79,& set BinaryCode=!BinaryCode!01111001,
if "!DecimalCode:~%Counter%,3!" == "122" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!z& set HexCode=!HexCode!7a,& set BinaryCode=!BinaryCode!01111010,
if "!DecimalCode:~%Counter%,3!" == "123" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!{& set HexCode=!HexCode!7b,& set BinaryCode=!BinaryCode!01111011,
if "!DecimalCode:~%Counter%,3!" == "124" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!^|& set HexCode=!HexCode!7c,& set BinaryCode=!BinaryCode!01111100,
if "!DecimalCode:~%Counter%,3!" == "125" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!}& set HexCode=!HexCode!7d,& set BinaryCode=!BinaryCode!01111101,
if "!DecimalCode:~%Counter%,3!" == "126" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!~& set HexCode=!HexCode!7e& set BinaryCode=!BinaryCode!01111110,
if "!DecimalCode:~%Counter%,3!" == "127" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!7f,& set BinaryCode=!BinaryCode!01111111,
if "!DecimalCode:~%Counter%,3!" == "128" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ä& set HexCode=!HexCode!80,& set BinaryCode=!BinaryCode!10000000,
if "!DecimalCode:~%Counter%,3!" == "129" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Å& set HexCode=!HexCode!81,& set BinaryCode=!BinaryCode!10000001,

if "!DecimalCode:~%Counter%,3!" == "130" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ç& set HexCode=!HexCode!82,& set BinaryCode=!BinaryCode!10000010,
if "!DecimalCode:~%Counter%,3!" == "131" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!É& set HexCode=!HexCode!83,& set BinaryCode=!BinaryCode!10000011,
if "!DecimalCode:~%Counter%,3!" == "132" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ñ& set HexCode=!HexCode!84,& set BinaryCode=!BinaryCode!10000100,
if "!DecimalCode:~%Counter%,3!" == "133" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ö& set HexCode=!HexCode!85,& set BinaryCode=!BinaryCode!10000101,
if "!DecimalCode:~%Counter%,3!" == "134" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ü& set HexCode=!HexCode!86,& set BinaryCode=!BinaryCode!10000110,
if "!DecimalCode:~%Counter%,3!" == "135" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!á& set HexCode=!HexCode!87,& set BinaryCode=!BinaryCode!10000111,
if "!DecimalCode:~%Counter%,3!" == "136" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!à& set HexCode=!HexCode!88,& set BinaryCode=!BinaryCode!10001000,
if "!DecimalCode:~%Counter%,3!" == "137" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!â& set HexCode=!HexCode!89,& set BinaryCode=!BinaryCode!10001001,
if "!DecimalCode:~%Counter%,3!" == "138" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ä& set HexCode=!HexCode!8a,& set BinaryCode=!BinaryCode!10001010,
if "!DecimalCode:~%Counter%,3!" == "139" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ã& set HexCode=!HexCode!8b,& set BinaryCode=!BinaryCode!10001011,

if "!DecimalCode:~%Counter%,3!" == "140" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!å& set HexCode=!HexCode!8c,& set BinaryCode=!BinaryCode!10001100,
if "!DecimalCode:~%Counter%,3!" == "141" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ç& set HexCode=!HexCode!8d,& set BinaryCode=!BinaryCode!10001101,
if "!DecimalCode:~%Counter%,3!" == "142" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!é& set HexCode=!HexCode!8e,& set BinaryCode=!BinaryCode!10001110,
if "!DecimalCode:~%Counter%,3!" == "143" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!è& set HexCode=!HexCode!8f,& set BinaryCode=!BinaryCode!10001111,
if "!DecimalCode:~%Counter%,3!" == "144" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ê& set HexCode=!HexCode!90,& set BinaryCode=!BinaryCode!10010000,
if "!DecimalCode:~%Counter%,3!" == "145" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ë& set HexCode=!HexCode!91,& set BinaryCode=!BinaryCode!10010001,
if "!DecimalCode:~%Counter%,3!" == "146" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!í& set HexCode=!HexCode!92,& set BinaryCode=!BinaryCode!10010010,
if "!DecimalCode:~%Counter%,3!" == "147" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ì& set HexCode=!HexCode!93,& set BinaryCode=!BinaryCode!10010011,
if "!DecimalCode:~%Counter%,3!" == "148" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!î& set HexCode=!HexCode!94,& set BinaryCode=!BinaryCode!10010100,
if "!DecimalCode:~%Counter%,3!" == "149" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ï& set HexCode=!HexCode!95,& set BinaryCode=!BinaryCode!10010101,

if "!DecimalCode:~%Counter%,3!" == "150" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ñ& set HexCode=!HexCode!96,& set BinaryCode=!BinaryCode!10010110,
if "!DecimalCode:~%Counter%,3!" == "151" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ó& set HexCode=!HexCode!97,& set BinaryCode=!BinaryCode!10010111,
if "!DecimalCode:~%Counter%,3!" == "152" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ò& set HexCode=!HexCode!98,& set BinaryCode=!BinaryCode!10011000,
if "!DecimalCode:~%Counter%,3!" == "153" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ô& set HexCode=!HexCode!99,& set BinaryCode=!BinaryCode!10011001,
if "!DecimalCode:~%Counter%,3!" == "154" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ö& set HexCode=!HexCode!9a,& set BinaryCode=!BinaryCode!10011010,
if "!DecimalCode:~%Counter%,3!" == "155" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!õ& set HexCode=!HexCode!9b,& set BinaryCode=!BinaryCode!10011011,
if "!DecimalCode:~%Counter%,3!" == "156" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ú& set HexCode=!HexCode!9c,& set BinaryCode=!BinaryCode!10011100,
if "!DecimalCode:~%Counter%,3!" == "157" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ù& set HexCode=!HexCode!9d,& set BinaryCode=!BinaryCode!10011101,
if "!DecimalCode:~%Counter%,3!" == "158" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!û& set HexCode=!HexCode!9e,& set BinaryCode=!BinaryCode!10011110,
if "!DecimalCode:~%Counter%,3!" == "159" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ü& set HexCode=!HexCode!9f,& set BinaryCode=!BinaryCode!10011111,

if "!DecimalCode:~%Counter%,3!" == "160" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!†& set HexCode=!HexCode!a0,& set BinaryCode=!BinaryCode!10100000,
if "!DecimalCode:~%Counter%,3!" == "161" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!°& set HexCode=!HexCode!a1,& set BinaryCode=!BinaryCode!10100001,
if "!DecimalCode:~%Counter%,3!" == "162" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¢& set HexCode=!HexCode!a2,& set BinaryCode=!BinaryCode!10100010,
if "!DecimalCode:~%Counter%,3!" == "163" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!£& set HexCode=!HexCode!a3,& set BinaryCode=!BinaryCode!10100011,
if "!DecimalCode:~%Counter%,3!" == "164" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!§& set HexCode=!HexCode!a4,& set BinaryCode=!BinaryCode!10100100,
if "!DecimalCode:~%Counter%,3!" == "165" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!•& set HexCode=!HexCode!a5,& set BinaryCode=!BinaryCode!10100101,
if "!DecimalCode:~%Counter%,3!" == "166" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¶& set HexCode=!HexCode!a6,& set BinaryCode=!BinaryCode!10100110,
if "!DecimalCode:~%Counter%,3!" == "167" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ß& set HexCode=!HexCode!a7,& set BinaryCode=!BinaryCode!10100111,
if "!DecimalCode:~%Counter%,3!" == "168" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!®& set HexCode=!HexCode!a8,& set BinaryCode=!BinaryCode!10101000,
if "!DecimalCode:~%Counter%,3!" == "169" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!©& set HexCode=!HexCode!a9,& set BinaryCode=!BinaryCode!10101001,

if "!DecimalCode:~%Counter%,3!" == "170" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!™& set HexCode=!HexCode!aa,& set BinaryCode=!BinaryCode!10101010,
if "!DecimalCode:~%Counter%,3!" == "171" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!´& set HexCode=!HexCode!ab,& set BinaryCode=!BinaryCode!10101011,
if "!DecimalCode:~%Counter%,3!" == "172" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¨& set HexCode=!HexCode!ac,& set BinaryCode=!BinaryCode!10101100,
if "!DecimalCode:~%Counter%,3!" == "173" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!≠& set HexCode=!HexCode!ad,& set BinaryCode=!BinaryCode!10101101,
if "!DecimalCode:~%Counter%,3!" == "174" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Æ& set HexCode=!HexCode!ae,& set BinaryCode=!BinaryCode!10101110,
if "!DecimalCode:~%Counter%,3!" == "175" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ø& set HexCode=!HexCode!af,& set BinaryCode=!BinaryCode!10101111,
if "!DecimalCode:~%Counter%,3!" == "176" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∞& set HexCode=!HexCode!b0,& set BinaryCode=!BinaryCode!10110000,
if "!DecimalCode:~%Counter%,3!" == "177" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!±& set HexCode=!HexCode!b1,& set BinaryCode=!BinaryCode!10110001,
if "!DecimalCode:~%Counter%,3!" == "178" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!≤& set HexCode=!HexCode!b2,& set BinaryCode=!BinaryCode!10110010,
if "!DecimalCode:~%Counter%,3!" == "179" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!≥& set HexCode=!HexCode!b3,& set BinaryCode=!BinaryCode!10110011,

if "!DecimalCode:~%Counter%,3!" == "180" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¥& set HexCode=!HexCode!b4,& set BinaryCode=!BinaryCode!10110100,
if "!DecimalCode:~%Counter%,3!" == "181" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!µ& set HexCode=!HexCode!b5,& set BinaryCode=!BinaryCode!10110101,
if "!DecimalCode:~%Counter%,3!" == "182" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∂& set HexCode=!HexCode!b6,& set BinaryCode=!BinaryCode!10110110,
if "!DecimalCode:~%Counter%,3!" == "183" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∑& set HexCode=!HexCode!b7,& set BinaryCode=!BinaryCode!10110111,
if "!DecimalCode:~%Counter%,3!" == "184" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∏& set HexCode=!HexCode!b8,& set BinaryCode=!BinaryCode!10111000,
if "!DecimalCode:~%Counter%,3!" == "185" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!π& set HexCode=!HexCode!b9,& set BinaryCode=!BinaryCode!10111001,
if "!DecimalCode:~%Counter%,3!" == "186" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∫& set HexCode=!HexCode!ba,& set BinaryCode=!BinaryCode!10111010,
if "!DecimalCode:~%Counter%,3!" == "187" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ª& set HexCode=!HexCode!bb,& set BinaryCode=!BinaryCode!10111011,
if "!DecimalCode:~%Counter%,3!" == "188" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!º& set HexCode=!HexCode!bc,& set BinaryCode=!BinaryCode!10111100,
if "!DecimalCode:~%Counter%,3!" == "189" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ω& set HexCode=!HexCode!bd,& set BinaryCode=!BinaryCode!10111101,

if "!DecimalCode:~%Counter%,3!" == "190" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!æ& set HexCode=!HexCode!be,& set BinaryCode=!BinaryCode!10111110,
if "!DecimalCode:~%Counter%,3!" == "191" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ø& set HexCode=!HexCode!bf,& set BinaryCode=!BinaryCode!10111111,
if "!DecimalCode:~%Counter%,3!" == "192" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¿& set HexCode=!HexCode!c0,& set BinaryCode=!BinaryCode!11000000,
if "!DecimalCode:~%Counter%,3!" == "193" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¡& set HexCode=!HexCode!c1,& set BinaryCode=!BinaryCode!11000001,
if "!DecimalCode:~%Counter%,3!" == "194" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¬& set HexCode=!HexCode!c2,& set BinaryCode=!BinaryCode!11000010,
if "!DecimalCode:~%Counter%,3!" == "195" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!√& set HexCode=!HexCode!c3,& set BinaryCode=!BinaryCode!11000011,
if "!DecimalCode:~%Counter%,3!" == "196" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ƒ& set HexCode=!HexCode!c4,& set BinaryCode=!BinaryCode!11000100,
if "!DecimalCode:~%Counter%,3!" == "197" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!≈& set HexCode=!HexCode!c5,& set BinaryCode=!BinaryCode!11000101,
if "!DecimalCode:~%Counter%,3!" == "198" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!∆& set HexCode=!HexCode!c6,& set BinaryCode=!BinaryCode!11000110,
if "!DecimalCode:~%Counter%,3!" == "199" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!«& set HexCode=!HexCode!c7,& set BinaryCode=!BinaryCode!11000111,

if "!DecimalCode:~%Counter%,3!" == "200" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!»& set HexCode=!HexCode!c8,& set BinaryCode=!BinaryCode!11001000,
if "!DecimalCode:~%Counter%,3!" == "201" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!…& set HexCode=!HexCode!c9,& set BinaryCode=!BinaryCode!11001001,
if "!DecimalCode:~%Counter%,3!" == "202" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode! & set HexCode=!HexCode!ca,& set BinaryCode=!BinaryCode!11001010,
if "!DecimalCode:~%Counter%,3!" == "203" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!À& set HexCode=!HexCode!cb,& set BinaryCode=!BinaryCode!11001011,
if "!DecimalCode:~%Counter%,3!" == "204" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ã& set HexCode=!HexCode!cc,& set BinaryCode=!BinaryCode!11001100,
if "!DecimalCode:~%Counter%,3!" == "205" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Õ& set HexCode=!HexCode!cd,& set BinaryCode=!BinaryCode!11001101,
if "!DecimalCode:~%Counter%,3!" == "206" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Œ& set HexCode=!HexCode!ce,& set BinaryCode=!BinaryCode!11001110,
if "!DecimalCode:~%Counter%,3!" == "207" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!œ& set HexCode=!HexCode!cf,& set BinaryCode=!BinaryCode!11001111,
if "!DecimalCode:~%Counter%,3!" == "208" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!–& set HexCode=!HexCode!d0,& set BinaryCode=!BinaryCode!11010000,
if "!DecimalCode:~%Counter%,3!" == "209" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!—& set HexCode=!HexCode!d1,& set BinaryCode=!BinaryCode!11010001,

if "!DecimalCode:~%Counter%,3!" == "210" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!“& set HexCode=!HexCode!d2,& set BinaryCode=!BinaryCode!11010010,
if "!DecimalCode:~%Counter%,3!" == "211" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!”& set HexCode=!HexCode!d3,& set BinaryCode=!BinaryCode!11010011,
if "!DecimalCode:~%Counter%,3!" == "212" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!‘& set HexCode=!HexCode!d4,& set BinaryCode=!BinaryCode!11010100,
if "!DecimalCode:~%Counter%,3!" == "213" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!’& set HexCode=!HexCode!d5,& set BinaryCode=!BinaryCode!11010101,
if "!DecimalCode:~%Counter%,3!" == "214" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!÷& set HexCode=!HexCode!d6,& set BinaryCode=!BinaryCode!11010110,
if "!DecimalCode:~%Counter%,3!" == "215" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!◊& set HexCode=!HexCode!d7,& set BinaryCode=!BinaryCode!11010111,
if "!DecimalCode:~%Counter%,3!" == "216" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ÿ& set HexCode=!HexCode!d8,& set BinaryCode=!BinaryCode!11011000,
if "!DecimalCode:~%Counter%,3!" == "217" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ÿ& set HexCode=!HexCode!d9,& set BinaryCode=!BinaryCode!11011001,
if "!DecimalCode:~%Counter%,3!" == "218" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!⁄& set HexCode=!HexCode!da,& set BinaryCode=!BinaryCode!11011010,
if "!DecimalCode:~%Counter%,3!" == "219" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!€& set HexCode=!HexCode!db,& set BinaryCode=!BinaryCode!11011011,

if "!DecimalCode:~%Counter%,3!" == "220" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!‹& set HexCode=!HexCode!dc,& set BinaryCode=!BinaryCode!11011100,
if "!DecimalCode:~%Counter%,3!" == "221" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!›& set HexCode=!HexCode!dd,& set BinaryCode=!BinaryCode!11011101,
if "!DecimalCode:~%Counter%,3!" == "222" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ﬁ& set HexCode=!HexCode!de,& set BinaryCode=!BinaryCode!11011110,
if "!DecimalCode:~%Counter%,3!" == "223" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ﬂ& set HexCode=!HexCode!df,& set BinaryCode=!BinaryCode!11011111,
if "!DecimalCode:~%Counter%,3!" == "224" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!‡& set HexCode=!HexCode!e0,& set BinaryCode=!BinaryCode!11100000,
if "!DecimalCode:~%Counter%,3!" == "225" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!·& set HexCode=!HexCode!e1,& set BinaryCode=!BinaryCode!11100001,
if "!DecimalCode:~%Counter%,3!" == "226" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!‚& set HexCode=!HexCode!e2,& set BinaryCode=!BinaryCode!11100010,
if "!DecimalCode:~%Counter%,3!" == "227" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!„& set HexCode=!HexCode!e3,& set BinaryCode=!BinaryCode!11100011,
if "!DecimalCode:~%Counter%,3!" == "228" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!‰& set HexCode=!HexCode!e4,& set BinaryCode=!BinaryCode!11100100,
if "!DecimalCode:~%Counter%,3!" == "229" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Â& set HexCode=!HexCode!e5,& set BinaryCode=!BinaryCode!11100101,

if "!DecimalCode:~%Counter%,3!" == "230" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ê& set HexCode=!HexCode!e6,& set BinaryCode=!BinaryCode!11100110,
if "!DecimalCode:~%Counter%,3!" == "231" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Á& set HexCode=!HexCode!e7,& set BinaryCode=!BinaryCode!11100111,
if "!DecimalCode:~%Counter%,3!" == "232" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ë& set HexCode=!HexCode!e8,& set BinaryCode=!BinaryCode!11101000,
if "!DecimalCode:~%Counter%,3!" == "233" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!È& set HexCode=!HexCode!e9,& set BinaryCode=!BinaryCode!11101001,
if "!DecimalCode:~%Counter%,3!" == "234" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Í& set HexCode=!HexCode!ea,& set BinaryCode=!BinaryCode!11101010,
if "!DecimalCode:~%Counter%,3!" == "235" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Î& set HexCode=!HexCode!eb,& set BinaryCode=!BinaryCode!11101011,
if "!DecimalCode:~%Counter%,3!" == "236" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ï& set HexCode=!HexCode!ec,& set BinaryCode=!BinaryCode!11101100,
if "!DecimalCode:~%Counter%,3!" == "237" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ì& set HexCode=!HexCode!ed,& set BinaryCode=!BinaryCode!11101101,
if "!DecimalCode:~%Counter%,3!" == "238" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ó& set HexCode=!HexCode!ee,& set BinaryCode=!BinaryCode!11101110,
if "!DecimalCode:~%Counter%,3!" == "239" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ô& set HexCode=!HexCode!ef,& set BinaryCode=!BinaryCode!11101111,

if "!DecimalCode:~%Counter%,3!" == "240" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!f0,& set BinaryCode=!BinaryCode!11110000,
if "!DecimalCode:~%Counter%,3!" == "241" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ò& set HexCode=!HexCode!f1,& set BinaryCode=!BinaryCode!11110001,
if "!DecimalCode:~%Counter%,3!" == "242" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ú& set HexCode=!HexCode!f2,& set BinaryCode=!BinaryCode!11110010,
if "!DecimalCode:~%Counter%,3!" == "243" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Û& set HexCode=!HexCode!f3,& set BinaryCode=!BinaryCode!11110011,
if "!DecimalCode:~%Counter%,3!" == "244" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!Ù& set HexCode=!HexCode!f4,& set BinaryCode=!BinaryCode!11110100,
if "!DecimalCode:~%Counter%,3!" == "245" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ı& set HexCode=!HexCode!f5,& set BinaryCode=!BinaryCode!11110101,
if "!DecimalCode:~%Counter%,3!" == "246" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ˆ& set HexCode=!HexCode!f6,& set BinaryCode=!BinaryCode!11110110,
if "!DecimalCode:~%Counter%,3!" == "247" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˜& set HexCode=!HexCode!f7,& set BinaryCode=!BinaryCode!11110111,
if "!DecimalCode:~%Counter%,3!" == "248" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¯& set HexCode=!HexCode!f8,& set BinaryCode=!BinaryCode!11111000,
if "!DecimalCode:~%Counter%,3!" == "249" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˘& set HexCode=!HexCode!f9,& set BinaryCode=!BinaryCode!11111001,

if "!DecimalCode:~%Counter%,3!" == "250" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˙& set HexCode=!HexCode!fa,& set BinaryCode=!BinaryCode!11111010,
if "!DecimalCode:~%Counter%,3!" == "251" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˚& set HexCode=!HexCode!fb,& set BinaryCode=!BinaryCode!11111011,
if "!DecimalCode:~%Counter%,3!" == "252" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!¸& set HexCode=!HexCode!fc,& set BinaryCode=!BinaryCode!11111100,
if "!DecimalCode:~%Counter%,3!" == "253" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˝& set HexCode=!HexCode!fd,& set BinaryCode=!BinaryCode!11111101,
if "!DecimalCode:~%Counter%,3!" == "254" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!˛& set HexCode=!HexCode!fe,& set BinaryCode=!BinaryCode!11111110,
if "!DecimalCode:~%Counter%,3!" == "255" set /a Counter=%Counter% + 3 & set AsciiCode=!AsciiCode!ˇ& set HexCode=!HexCode!ff,& set BinaryCode=!BinaryCode!11111111,

if "!DecimalCode:~%Counter%,2!" == "10" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{LF}& set HexCode=!HexCode!0a,& set BinaryCode=!BinaryCode!00001010,
if "!DecimalCode:~%Counter%,2!" == "11" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!0b,& set BinaryCode=!BinaryCode!00001011,
if "!DecimalCode:~%Counter%,2!" == "12" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!0c,& set BinaryCode=!BinaryCode!00001100,
if "!DecimalCode:~%Counter%,2!" == "13" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{CR}& set HexCode=!HexCode!0d,& set BinaryCode=!BinaryCode!00001101,
if "!DecimalCode:~%Counter%,2!" == "14" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!0e,& set BinaryCode=!BinaryCode!00001110,
if "!DecimalCode:~%Counter%,2!" == "15" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!0f,& set BinaryCode=!BinaryCode!00001111,
if "!DecimalCode:~%Counter%,2!" == "16" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!10,& set BinaryCode=!BinaryCode!00010000,
if "!DecimalCode:~%Counter%,2!" == "17" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!11,& set BinaryCode=!BinaryCode!00010001,
if "!DecimalCode:~%Counter%,2!" == "18" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!12,& set BinaryCode=!BinaryCode!00010010,
if "!DecimalCode:~%Counter%,2!" == "19" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!13,& set BinaryCode=!BinaryCode!00010011,

if "!DecimalCode:~%Counter%,2!" == "20" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!14,& set BinaryCode=!BinaryCode!00010100,
if "!DecimalCode:~%Counter%,2!" == "21" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!15,& set BinaryCode=!BinaryCode!00010101,
if "!DecimalCode:~%Counter%,2!" == "22" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!16,& set BinaryCode=!BinaryCode!00010110,
if "!DecimalCode:~%Counter%,2!" == "23" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!17,& set BinaryCode=!BinaryCode!00010111,
if "!DecimalCode:~%Counter%,2!" == "24" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!18,& set BinaryCode=!BinaryCode!00011000,
if "!DecimalCode:~%Counter%,2!" == "25" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!19,& set BinaryCode=!BinaryCode!00011001,
if "!DecimalCode:~%Counter%,2!" == "26" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{SUB}& set HexCode=!HexCode!1a,& set BinaryCode=!BinaryCode!00011010,
if "!DecimalCode:~%Counter%,2!" == "27" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{ESC}& set HexCode=!HexCode!1b,& set BinaryCode=!BinaryCode!00011011,
if "!DecimalCode:~%Counter%,2!" == "28" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!1c,& set BinaryCode=!BinaryCode!00011100,
if "!DecimalCode:~%Counter%,2!" == "29" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!1d,& set BinaryCode=!BinaryCode!00011101,

if "!DecimalCode:~%Counter%,2!" == "30" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!1e,& set BinaryCode=!BinaryCode!00011110,
if "!DecimalCode:~%Counter%,2!" == "31" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!1f,& set BinaryCode=!BinaryCode!00011111,
if "!DecimalCode:~%Counter%,2!" == "32" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode! & set HexCode=!HexCode!20,& set BinaryCode=!BinaryCode!00100000,
if "!DecimalCode:~%Counter%,2!" == "33" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!{ExclamationMark}& set HexCode=!HexCode!21,& set BinaryCode=!BinaryCode!00100001,
if "!DecimalCode:~%Counter%,2!" == "34" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!!Quote!& set HexCode=!HexCode!22,& set BinaryCode=!BinaryCode!00100010,
if "!DecimalCode:~%Counter%,2!" == "35" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!#& set HexCode=!HexCode!23,& set BinaryCode=!BinaryCode!00100011,
if "!DecimalCode:~%Counter%,2!" == "36" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!$& set HexCode=!HexCode!24,& set BinaryCode=!BinaryCode!00100100,
if "!DecimalCode:~%Counter%,2!" == "37" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!%%& set HexCode=!HexCode!25,& set BinaryCode=!BinaryCode!00100101,
if "!DecimalCode:~%Counter%,2!" == "38" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^&& set HexCode=!HexCode!26,& set BinaryCode=!BinaryCode!00100110,
if "!DecimalCode:~%Counter%,2!" == "39" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!'& set HexCode=!HexCode!27,& set BinaryCode=!BinaryCode!00100111,

if "!DecimalCode:~%Counter%,2!" == "40" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^(& set HexCode=!HexCode!28,& set BinaryCode=!BinaryCode!00101000,
if "!DecimalCode:~%Counter%,2!" == "41" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^)& set HexCode=!HexCode!29,& set BinaryCode=!BinaryCode!00101001,
if "!DecimalCode:~%Counter%,2!" == "42" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!*& set HexCode=!HexCode!2a,& set BinaryCode=!BinaryCode!00101010,
if "!DecimalCode:~%Counter%,2!" == "43" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!+& set HexCode=!HexCode!2b,& set BinaryCode=!BinaryCode!00101011,
if "!DecimalCode:~%Counter%,2!" == "44" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!,& set HexCode=!HexCode!2c,& set BinaryCode=!BinaryCode!00101100,
if "!DecimalCode:~%Counter%,2!" == "45" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!-& set HexCode=!HexCode!2d,& set BinaryCode=!BinaryCode!00101101,
if "!DecimalCode:~%Counter%,2!" == "46" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!.& set HexCode=!HexCode!2e,& set BinaryCode=!BinaryCode!00101110,
if "!DecimalCode:~%Counter%,2!" == "47" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!/& set HexCode=!HexCode!2f,& set BinaryCode=!BinaryCode!00101111,
if "!DecimalCode:~%Counter%,2!" == "48" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!0& set HexCode=!HexCode!30,& set BinaryCode=!BinaryCode!00110000,
if "!DecimalCode:~%Counter%,2!" == "49" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!1& set HexCode=!HexCode!31,& set BinaryCode=!BinaryCode!00110001,

if "!DecimalCode:~%Counter%,2!" == "50" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!2& set HexCode=!HexCode!32,& set BinaryCode=!BinaryCode!00110010,
if "!DecimalCode:~%Counter%,2!" == "51" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!3& set HexCode=!HexCode!33,& set BinaryCode=!BinaryCode!00110011,
if "!DecimalCode:~%Counter%,2!" == "52" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!4& set HexCode=!HexCode!34,& set BinaryCode=!BinaryCode!00110100,
if "!DecimalCode:~%Counter%,2!" == "53" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!5& set HexCode=!HexCode!35,& set BinaryCode=!BinaryCode!00110101,
if "!DecimalCode:~%Counter%,2!" == "54" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!6& set HexCode=!HexCode!36,& set BinaryCode=!BinaryCode!00110110,
if "!DecimalCode:~%Counter%,2!" == "55" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!7& set HexCode=!HexCode!37,& set BinaryCode=!BinaryCode!00110111,
if "!DecimalCode:~%Counter%,2!" == "56" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!8& set HexCode=!HexCode!38,& set BinaryCode=!BinaryCode!00111000,
if "!DecimalCode:~%Counter%,2!" == "57" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!9& set HexCode=!HexCode!39,& set BinaryCode=!BinaryCode!00111001,
if "!DecimalCode:~%Counter%,2!" == "58" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!:& set HexCode=!HexCode!3a,& set BinaryCode=!BinaryCode!00111010,
if "!DecimalCode:~%Counter%,2!" == "59" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!;& set HexCode=!HexCode!3b,& set BinaryCode=!BinaryCode!00111011,

if "!DecimalCode:~%Counter%,2!" == "60" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^<& set HexCode=!HexCode!3c,& set BinaryCode=!BinaryCode!00111100,
if "!DecimalCode:~%Counter%,2!" == "61" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!=& set HexCode=!HexCode!3d,& set BinaryCode=!BinaryCode!00111101,
if "!DecimalCode:~%Counter%,2!" == "62" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^>& set HexCode=!HexCode!3e,& set BinaryCode=!BinaryCode!00111110,
if "!DecimalCode:~%Counter%,2!" == "63" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!?& set HexCode=!HexCode!3f,& set BinaryCode=!BinaryCode!00111111,
if "!DecimalCode:~%Counter%,2!" == "64" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!@& set HexCode=!HexCode!40,& set BinaryCode=!BinaryCode!01000100,
if "!DecimalCode:~%Counter%,2!" == "65" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!A& set HexCode=!HexCode!41,& set BinaryCode=!BinaryCode!01000001,
if "!DecimalCode:~%Counter%,2!" == "66" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!B& set HexCode=!HexCode!42,& set BinaryCode=!BinaryCode!01000010,
if "!DecimalCode:~%Counter%,2!" == "67" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!C& set HexCode=!HexCode!43,& set BinaryCode=!BinaryCode!01000011,
if "!DecimalCode:~%Counter%,2!" == "68" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!D& set HexCode=!HexCode!44,& set BinaryCode=!BinaryCode!01000100,
if "!DecimalCode:~%Counter%,2!" == "69" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!E& set HexCode=!HexCode!45,& set BinaryCode=!BinaryCode!01000101,

if "!DecimalCode:~%Counter%,2!" == "70" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!F& set HexCode=!HexCode!46,& set BinaryCode=!BinaryCode!01000110,
if "!DecimalCode:~%Counter%,2!" == "71" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!G& set HexCode=!HexCode!47,& set BinaryCode=!BinaryCode!01000111,
if "!DecimalCode:~%Counter%,2!" == "72" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!H& set HexCode=!HexCode!48,& set BinaryCode=!BinaryCode!01001000,
if "!DecimalCode:~%Counter%,2!" == "73" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!I& set HexCode=!HexCode!49,& set BinaryCode=!BinaryCode!01001001,
if "!DecimalCode:~%Counter%,2!" == "74" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!J& set HexCode=!HexCode!4a,& set BinaryCode=!BinaryCode!01001010,
if "!DecimalCode:~%Counter%,2!" == "75" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!K& set HexCode=!HexCode!4b,& set BinaryCode=!BinaryCode!01001011,
if "!DecimalCode:~%Counter%,2!" == "76" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!L& set HexCode=!HexCode!4c,& set BinaryCode=!BinaryCode!01001100,
if "!DecimalCode:~%Counter%,2!" == "77" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!M& set HexCode=!HexCode!4d,& set BinaryCode=!BinaryCode!01001101,
if "!DecimalCode:~%Counter%,2!" == "78" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!N& set HexCode=!HexCode!4e,& set BinaryCode=!BinaryCode!01001110,
if "!DecimalCode:~%Counter%,2!" == "79" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!O& set HexCode=!HexCode!4f,& set BinaryCode=!BinaryCode!01001111,

if "!DecimalCode:~%Counter%,2!" == "80" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!P& set HexCode=!HexCode!50,& set BinaryCode=!BinaryCode!01010000,
if "!DecimalCode:~%Counter%,2!" == "81" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Q& set HexCode=!HexCode!51,& set BinaryCode=!BinaryCode!01010001,
if "!DecimalCode:~%Counter%,2!" == "82" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!R& set HexCode=!HexCode!52,& set BinaryCode=!BinaryCode!01010010,
if "!DecimalCode:~%Counter%,2!" == "83" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!S& set HexCode=!HexCode!53,& set BinaryCode=!BinaryCode!01010011,
if "!DecimalCode:~%Counter%,2!" == "84" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!T& set HexCode=!HexCode!54,& set BinaryCode=!BinaryCode!01010100,
if "!DecimalCode:~%Counter%,2!" == "85" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!U& set HexCode=!HexCode!55,& set BinaryCode=!BinaryCode!01010101,
if "!DecimalCode:~%Counter%,2!" == "86" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!V& set HexCode=!HexCode!56,& set BinaryCode=!BinaryCode!01010110,
if "!DecimalCode:~%Counter%,2!" == "87" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!W& set HexCode=!HexCode!57,& set BinaryCode=!BinaryCode!01010111,
if "!DecimalCode:~%Counter%,2!" == "88" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!X& set HexCode=!HexCode!58,& set BinaryCode=!BinaryCode!01011000,
if "!DecimalCode:~%Counter%,2!" == "89" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Y& set HexCode=!HexCode!59,& set BinaryCode=!BinaryCode!01011001,

if "!DecimalCode:~%Counter%,2!" == "90" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!Z& set HexCode=!HexCode!5a,& set BinaryCode=!BinaryCode!01011010,
if "!DecimalCode:~%Counter%,2!" == "91" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode![& set HexCode=!HexCode!5b,& set BinaryCode=!BinaryCode!01011011,
if "!DecimalCode:~%Counter%,2!" == "92" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!\& set HexCode=!HexCode!5c,& set BinaryCode=!BinaryCode!01011100,
if "!DecimalCode:~%Counter%,2!" == "93" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!]& set HexCode=!HexCode!5d,& set BinaryCode=!BinaryCode!01011101,
if "!DecimalCode:~%Counter%,2!" == "94" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!^^& set HexCode=!HexCode!5e,& set BinaryCode=!BinaryCode!01011110,
if "!DecimalCode:~%Counter%,2!" == "95" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!_& set HexCode=!HexCode!5f,& set BinaryCode=!BinaryCode!01011111,
if "!DecimalCode:~%Counter%,2!" == "96" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!`& set HexCode=!HexCode!60,& set BinaryCode=!BinaryCode!01100000,
if "!DecimalCode:~%Counter%,2!" == "97" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!a& set HexCode=!HexCode!61,& set BinaryCode=!BinaryCode!01100001,
if "!DecimalCode:~%Counter%,2!" == "98" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!b& set HexCode=!HexCode!62,& set BinaryCode=!BinaryCode!01100010,
if "!DecimalCode:~%Counter%,2!" == "99" set /a Counter=%Counter% + 2 & set AsciiCode=!AsciiCode!c& set HexCode=!HexCode!63,& set BinaryCode=!BinaryCode!01100011,

if "!DecimalCode:~%Counter%,1!" == "0" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!{NUL}& set HexCode=!HexCode!00,& set BinaryCode=!BinaryCode!00000000,
if "!DecimalCode:~%Counter%,1!" == "1" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!01,& set BinaryCode=!BinaryCode!00000001,
if "!DecimalCode:~%Counter%,1!" == "1" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!02,& set BinaryCode=!BinaryCode!00000010,
if "!DecimalCode:~%Counter%,1!" == "3" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!03,& set BinaryCode=!BinaryCode!00000011,
if "!DecimalCode:~%Counter%,1!" == "4" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!04,& set BinaryCode=!BinaryCode!00000100,
if "!DecimalCode:~%Counter%,1!" == "5" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!05,& set BinaryCode=!BinaryCode!00000101,
if "!DecimalCode:~%Counter%,1!" == "6" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!06,& set BinaryCode=!BinaryCode!00000110,
if "!DecimalCode:~%Counter%,1!" == "7" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!{BEL}& set HexCode=!HexCode!07,& set BinaryCode=!BinaryCode!00000111,
if "!DecimalCode:~%Counter%,1!" == "8" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!& set HexCode=!HexCode!08,& set BinaryCode=!BinaryCode!00001000,
if "!DecimalCode:~%Counter%,1!" == "9" set /a Counter=%Counter% + 1 & set AsciiCode=!AsciiCode!	& set HexCode=!HexCode!09,& set BinaryCode=!BinaryCode!00001001,


:: Check if an error occured
if "!AsciiCode_Puffer!" == "!AsciiCode!" set /a Counter=%Counter% + 1

goto :Conversion





:Finished

echo !DecimalCode! | find "  {p8UyY}" >nul 2>nul && set DecimalCode=!DecimalCode:~0,-9!


echo Dec:   !DecimalCode! 1>Dec2All.tmp
echo Ascii: !AsciiCode! 1>>Dec2All.tmp
echo Hex:   !HexCode! 1>>Dec2All.tmp
echo Bin:   !BinaryCode! 1>>Dec2All.tmp
start notepad "%temp%\Dec2All.tmp"
echo Ascii: !AsciiCode!     ^<- in CMD
echo Hex:   !HexCode!
echo Bin:   !BinaryCode!
echo.
echo.
goto :Start







:ErrorSearch
:: Saves the numbers into variables
set /a Counter=%Counter% + 1
set Var%Counter%=%~1
if "!Var%Counter%!" == ")" set Var%Counter%=&set Counter=%Counter% - 1
if "!Var%Counter%!" == "}" set Var%Counter%=&set Counter=%Counter% - 1
if "!Var%Counter%!" == "]" set Var%Counter%=&set Counter=%Counter% - 1
shift /1
if "%~1" == "" goto :ErrorSearch_Step2
goto :ErrorSearch

:ErrorSearch_Step2
:: Checks for numbers greater than or equal "256" six times.
:: --- If there is still one on fifth check, program errors.
:: --- Else is decreases the number by 256.
FOR /L %%M IN (1,1,4) DO FOR /L %%C IN (1,1,%Counter%) DO if not "!Var%%C:~2,1!" == "" if "!Var%%C!" GTR "255" set /a Var%%C=!Var%%C! - 256
FOR /L %%C IN (1,1,%Counter%) DO if not "!Var%%C:~2,1!" == "" if "!Var%%C!" GTR "256" set ErrorFound=1
FOR /L %%C IN (1,1,%Counter%) DO if not "!Var%%C:~3,1!" == "" if "!Var%%C!" GEQ "0" set ErrorFound=1
if "!ErrorFound!" == "1" (
	echo Error: Decimal numbers can be at last 999.
	pause
	goto :Start
)
:: Rewrites the given decimal code.
:: --- Divides the numbers by commas.
set DecimalCode=
FOR /L %%C IN (1,1,%Counter%) DO set DecimalCode=!DecimalCode!,!Var%%C!
:: Determine the end of progress
set DecimalCode=!DecimalCode!  {p8UyY}
set DecimalCode=!DecimalCode:~1,-1!}
:: Resets the useless variables.
FOR /L %%C IN (1,1,%Counter%) DO set Var%%C=
EXIT /B