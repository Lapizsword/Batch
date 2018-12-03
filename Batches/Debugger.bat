@echo off

REM *******************************************************************
REM * Change this value to "0" to stop the file working.              *
REM * Keep this value on "1" to leave ascii translation code enabled. *
REM * Change this value to "2" to enable binary translation code.     *
REM *******************************************************************
set TranslationCode=1




:: Return variables to allow using command several times
set Ascii=
set Binary=
set Compact=
set Disabling=
set Encryption=
set Error=
set FilePath=
set FileName=
set Overview=
set Protocol=
set Quick=
set Spell=
set StayFile=
set Syntax=





if "%~1" == "/?" goto :Syntax
if /i "%~1" == "-TransCode" echo TransCode=%TranslationCode%&exit /b

:: Make sure the program is started by an active CMD-window
if not "%~0" == "debugger" if not "%~0" == "debugger.bat" set Error=You have to execute this file from an active CMD-window.&goto :Error
if "%~1" == "" set Error=No parameters given.&goto :Error

:: Checking parameters
echo %*|find /i "-P">nul 2>&1 && set Protocol=1
echo %*|find /i "-Q">nul 2>&1 && set Quick=1
echo %*|find /i "-Syntax">nul 2>&1 && set Syntax=1
echo %*|find /i "-Spell">nul 2>&1 && set Spell=1
echo %*|find /i "-Spell/Y">nul 2>&1 && set Spell=2
echo %*|find /i "-Comp">nul 2>&1 && set Compact=1
echo %*|find /i "-Comp+">nul 2>&1 && set Compact=2
echo %*|find /i "-overview">nul 2>&1 && set Overview=1
echo %*|find /i "-stay">nul 2>&1 && set StayFile=1
echo %*|find /i "-decrypt">nul 2>&1 && set Encryption=2
echo %*|find /i "-encrypt">nul 2>&1 && if not "%Encryption%" == "2" (set Encryption=1) ELSE (
	echo The option "-encrypt" has been disabled due to "-decrypt".
	echo Do you wish to redo the command? [Y/N]
	set /p Redo=
	if /i "%Redo%" == "y" exit /b
)
:: Checking parameters

if defined Quick if defined Compact set Disabling=1&(
	echo The option "-comp" [Compact] has been disabled due to "-Q" [Quick].
	echo Do you wish to redo the command? [Y/N]
	set /p Redo=
	if /i "%Redo%" == "y" exit /b
)
if "%Disabling%" == "1" set Syntax=
if "%Disabling%" == "1" set Compact=

:: Setting path and in case of -stay the new path
set FilePath=%~1
for %%A IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO if "%%A" == "%FilePath:~0,1%" set PathFound=1
if not "%PathFound%" == "1" set Error=Missing path.&goto :Error
if not exist "%FilePath%" set Error=Missing path.&goto :Error
FOR /F "delims=" %%A IN ("%FilePath%") DO set FileName=%%~nxA
:: Setting path


:: Checking the translation code the file should use
set /a TranslationCode=%TranslationCode:~0,1%
if "%TranslationCode%" GEQ "3" set TranslationCode=0
if "%TranslationCode%" == "0" (
	set Ascii =REM
	set Binary=REM
)
if "%TranslationCode%" == "1" set Binary=REM
if "%TranslationCode%" == "2" set Ascii =REM
:: Checking the translation code the file should use



::: Writing .INI-file
pushd "%userprofile%\Desktop"
echo %0 %* 1>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
echo File:     "%FilePath%" 1>>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
:: Ascii translation code
%Ascii % if defined Protocol (echo Protocol:  Yes>>"Debug-%FileName%.ini") ELSE (echo Protocol:  No>>"Debug-%FileName%.ini")
%Ascii % if defined Quick    (echo Quick:     Yes>>"Debug-%FileName%.ini") ELSE (echo Quick:     No>>"Debug-%FileName%.ini")
%Ascii % if defined Syntax   (echo Syntax:    Yes>>"Debug-%FileName%.ini") ELSE (echo Syntax:    No>>"Debug-%FileName%.ini")
%Ascii % if "%Spell%" == ""       echo Spell:     No>>"Debug-%FileName%.ini"
%Ascii % if "%Spell%" == "1"      echo Spell:     English and German only>>"Debug-%FileName%.ini"
%Ascii % if "%Spell%" == "2"      echo Spell:     All languages.>>"Debug-%FileName%.ini"
%Ascii % if "%Compact%" == ""     echo Compact:   No>>"Debug-%FileName%.ini"
%Ascii % if "%Compact%" == "1"    echo Compact:   Slight>>"Debug-%FileName%.ini"
%Ascii % if "%Compact%" == "2"    echo Compact:   Heavy>>"Debug-%FileName%.ini"
%Ascii % if defined Overview     (echo Overview:  Yes>>"Debug-%FileName%.ini") ELSE (echo Overview:  No>>"Debug-%FileName%.ini")
%Ascii % if defined StayFile     (echo Keep file: Yes>>"Debug-%FileName%.ini") ELSE (echo Keep file: No>>"Debug-%FileName%.ini")
%Ascii % if "%Encryption%" == ""  echo Encrypt:   No>>"Debug-%FileName%.ini"
%Ascii % if "%Encryption%" == "1" echo Encrypt:   Yes>>"Debug-%FileName%.ini"
%Ascii % if "%Encryption%" == "2" echo Encrypt:   Decrypt>>"Debug-%FileName%.ini"
:: Ascii translation code
:: Binary translation code
%Binary% if defined Protocol     (echo Protocol:  0x00000001>>"Debug-%FileName%.ini") ELSE (echo Protocol:  0x00000000>>"Debug-%FileName%.ini")
%Binary% if defined Quick        (echo Quick:     0x00000001>>"Debug-%FileName%.ini") ELSE (echo Quick:     0x00000000>>"Debug-%FileName%.ini")
%Binary% if defined Syntax       (echo Syntax:    0x00000001>>"Debug-%FileName%.ini") ELSE (echo Syntax:    0x00000000>>"Debug-%FileName%.ini")
%Binary% if "%Spell%" == ""       echo Spell:     0x00000000>>"Debug-%FileName%.ini"
%Binary% if "%Spell%" == "1"      echo Spell:     0x00000001>>"Debug-%FileName%.ini"
%Binary% if "%Spell%" == "2"      echo Spell:     0x00000002>>"Debug-%FileName%.ini"
%Binary% if "%Compact%" == ""     echo Compact:   0x00000000>>"Debug-%FileName%.ini"
%Binary% if "%Compact%" == "1"    echo Compact:   0x00000001>>"Debug-%FileName%.ini"
%Binary% if "%Compact%" == "2"    echo Compact:   0x00000002>>"Debug-%FileName%.ini"
%Binary% if defined Overview     (echo Overview:  0x00000001>>"Debug-%FileName%.ini") ELSE (echo Overview:  0x00000000>>"Debug-%FileName%.ini")
%Binary% if defined StayFile     (echo Keep file: 0x00000001>>"Debug-%FileName%.ini") ELSE (echo Keep file: 0x00000000>>"Debug-%FileName%.ini")
%Binary% if "%Encryption%" == ""  echo Encrypt:   0x00000000>>"Debug-%FileName%.ini"
%Binary% if "%Encryption%" == "1" echo Encrypt:   0x00000001>>"Debug-%FileName%.ini"
%Binary% if "%Encryption%" == "2" echo Encrypt:   0x00000002>>"Debug-%FileName%.ini"
:: Binary translation code
echo.>>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
echo Start of the source code>>"Debug-%FileName%.ini"
echo ------------------------>>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
type "%FilePath%">>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
echo ------------------------>>"Debug-%FileName%.ini"
echo  End of the source code>>"Debug-%FileName%.ini"
echo.>>"Debug-%FileName%.ini"
popd
::: Writing .INI-file


:: Complete the session
echo The file has been successfully created in:
echo   "%userprofile%\Desktop\"Debug-%FileName%.ini""
echo.
echo You can now send the file.
exit /b






:Error
echo Error: %Error%
echo.
:Syntax
echo Syntax:
echo ооооооо
echo debugger.bat "Path" [-P] [-Q ^| -Syntax [-Comp[+]]] [-Spell[/Y]] [-overview]
echo              [-stay] [-encrypt ^| -decrypt]
echo.
echo "Path"      Enter the path of the batchfile to debug.
echo -P          Enable protocol. This option protocols every done step.
echo -Q          Fasts the debug forward. This option saves time, but it disables
echo             "-comp" and "-syntax".
echo -Syntax     Tests the syntax of every command (default only difficult ones).
echo -Comp       Compacts the entire code.
echo -Comp+      Compacts the code as good as possible:
echo                 - Often used commands summarized to one,
echo                 - often used text parts set into variables,
echo                 - summarize texts,
echo                 - remove blanks,
echo                 - short variable names and spring points.
echo -Spell      Tests the spelling of English and German (ignores other languages)
echo -Spell/Y    Tests the spelling of every language (may cause errors).
echo -overview   Keeps or creates an acceptable overview of the source code.
echo -stay       Keeps the original file and creates a new one.
echo -encrypt    Encrypts important parts of the source code. You can edit the
echo             created file to specify the part to encrypt.
echo -decrypt    Decrypts every encryption in the file as good as possible.     
echo.
pause
exit /b