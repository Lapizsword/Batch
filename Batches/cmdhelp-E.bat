@echo off

REM This makes sure the file is opened by CMD and not by double click.
REM -----------------------------------------------------------
if /i "%~0" == "cmdhelp" goto :System32_Y
if /i "%~0" == "cmdhelp.bat" goto :System32_Y

(
if exist "%SystemRoot%\system32" (
	if exist "%SystemRoot%\system32\cmdhelp.bat" (echo N|comp "%SystemRoot%\system32\cmdhelp.bat" "%~0"| find "different" >nul 2>nul && move /Y "%SystemRoot%\system32\cmdhelp.bat" "%SystemRoot%\system32\cmdhelp.bkf")
	move /Y "%~0" "%SystemRoot%\system32\cmdhelp.bat"
)
if exist "%SystemRoot%\system64" (
	if exist "%SystemRoot%\system64\cmdhelp.bat" (echo N|comp "%SystemRoot%\system64\cmdhelp.bat" "%~0"| find "different" >nul 2>nul && move /Y "%SystemRoot%\system64\cmdhelp.bat" "%SystemRoot%\system64\cmdhelp.bkf")
	move /Y "%~0" "%SystemRoot%\system64\cmdhelp.bat"
)
if errorlevel 1 ping localhost -n 2 >nul
start cmd /k cmdhelp
exit
)
REM -----------------------------------------------------------

:System32_Y

if "%2" == "Headquaters" (set Exit=goto :Headquaters) ELSE (set Exit=exit /b)
if /i "%2" == "/w" if "%3" == "Headquaters" set Exit=goto :Headquaters

REM This allows detailed information to specific commands.
REM -----------------------------------------------------------
if "%1" == "/?" goto :HELP
if /i "%1" == "Programpaths" goto :Programpaths
if /i "%1" == "Arguments" goto :Arguments
if /i "%1" == "Ascii" goto :Ascii
if /i "%1" == "Commands" goto :Commands
if /i "%1" == "Errorlevel" goto :Errorlevel
if /i "%1" == "Explorer" goto :Explorer
if /i "%1" == "FTP" goto :FTP
if /i "%1" == "Shortnames" goto :Shortnames
if /i "%1" == "Symbols" goto :Symbols
if /i "%1" == "Springpoints" goto :Springpoints
if /i "%1" == "User" goto :User
if /i "%1" == "User32" goto :User
if /i "%1" == "User/User32" goto :User
if /i "%1" == "Variables" goto :Variables
if /i "%1" == "Variable" goto :Variables
if /i "%1" == "Headquaters" goto :Headquaters
if "%1" == "" goto :Read
%1 /?
%Exit%
REM -----------------------------------------------------------

:Read
echo Enter 'Command /?' for more information to a particular command
echo (from --A-- without [...]).
echo.
echo %%VAR%%             Variable set durch 'SET'.
echo %%VAR:~X,Y%%        Part of a variable: From X letter Y steps forward.
echo %%VAR:A=B%%         Variable in which the string "A" is replaced by "B".
echo %%0                Path to the currently opened batch file.
echo ^>NUL              Hides the output of a command.
echo 2^>NUL             Hides the errors of a command.
echo 2^>^&1              Hides the output of a command despite errors.
echo ------A------
echo [ARGUMENTS]       %%1, %%2... can be changed like the ones in 'FOR'.
echo [ASCII]           Special characters written in CMD another way as in notepad.
echo ASSOC             Changes the association of a file extension.
echo ATTRIB            Changes the attributes of a file or folder.
echo AT                Makes sure a command is run at a specific time or date.
echo ------B------
echo BREAK             Determines if Ctrl+C should be allowed.
echo ------C------
echo CACLS             Changes the access to files.
echo CALL              Calls batch files into the current CMD or calls springpoints.
echo CD / CHDIR        Changes the directory.
echo CHCP              Changes the codepagenumber.
echo CHKDSK            Checks the disk for errors or damaged sectors.
echo CHKNTFS           Checks the disk for errors or damaged sectors on startup.
echo CLS               Clears the screen of the currently opened CMD-window.
echo CMD               Starts a new CMD-window.
echo COLOR             Changes the colors of background and font.
echo COMMAND           Starts command.com.
echo [COMMANDS]        Shows the commands without any information.
echo COMP              Compares two files.
echo COMPACT           Shows or changes the compression of files.
echo CONVERT           Converts FAT to NTFS.
echo COPY              Copies files.
echo ------D------
echo DATE              Changes the date.
echo DEFRAG            Defrags a volume.
echo DEL / ERASE       Deletes files.
echo DIR               Shows files and folders.
echo DOSKEY            Edits command input and creates macros.
echo DRIVERQUERY       Shows installed drivers.
echo ------E------
echo ECHO              Displays messages.
echo ENDLOCAL          Closes the room of 'Setlocal'.
echo [ERRORLEVEL]      This is the value after every executed command.
echo EXIT              Closes CMD.
echo [EXPLORER]        Start the Windows Explorer.
echo ------F------
echo FC                Compares many files.
echo FIND              Looks for a string in one file.
echo FINDSTR           Looks for a string in files.
echo FOR               Executes commands for many files, strings or commands.
echo FORMAT            Formates a volume.
echo [FTP]             File transfer protocol, file transfer with other servers.
echo FTYPE             Sets the open-command for a file type.
echo ------G------
echo GOTO              Jumps to a springpoint.
echo GPRESULT          Queries group policies.
echo GRAFTABL          Allows Windows to print special characters.
echo ------H------
echo HELP              Gives information [to a command] about batch.
echo ------I------
echo IF                Sets conditions.
echo IPCONFIG          Changes settings to connect to the internet.
echo ------L------
echo LABEL             Creates, deletes or changes a volume name.
echo ------M------
echo MD / MKDIR        Creates a folder.
echo MODE              Changes settings of the CMD-window.
echo MORE              Queries the content of a file with pauses.
echo MOVE              Moves a file.
echo MSG *             Shows a message in a new window.
echo MSGBOX *          Shows a message in a new window.
echo ------N------
echo NET               Works with users and services.
echo NETSH             Works for example with the firewall.
echo NETSTAT           Shows current connections to the internet.
echo ------P------
echo PATH              Displays or modifies the environment paths.
echo PAUSE             Pauses the progress till a button was pressed.
echo PING              Time-bound pauses // Finds out IPs.
echo PRINT             Prints a textfile.
echo [PROGRAMPATHS]    See 'cmdhelp Programpaths'.
echo PROMPT            Changes the command prompt
echo PUSHD / POPD      Saves the current directory and changes it.
echo ------R------
echo RD / RMDIR        Removes an entire folder.
echo RECOVER           Recovers files from a damages sector.
echo REG               Modifies the registry.
echo REGEDIT           Opens [a path in the] registry.
echo REM               Remarks for the coder. No sense for execution.
echo REN / RENAME      Renames a file.
echo REPLACE           Replaces files.
echo ------S------
echo SC                Works with [the true names of] services.
echo SET               Sets variables // Calculations.
echo SETLOCAL          Allows advanced coding.
echo SHIFT             Changes the sequence of arguments.
echo [SHORTNAMES]      Names with max. 8 characters.
echo SHUTDOWN          Shuts the computer down.
echo [SYMBOLS]         Some cannot be displayed that easy.
echo SORT              Sorts the content of files and displays it.
echo [SPRINGPOINTS]    Regulates the work in batch files making seperate areas.
echo START             Starts a file.
echo SUBST             Assigns a path a volume name.
echo SYSTEMINFO        Queries much system information.
echo ------T------
echo TASKKILL          Kills a process.
echo TASKLIST          Queries currently running processes.
echo TIME              Queries the current time.
echo TITLE             Changes the window title of the current CMD.
echo TREE              Displays a directory structure graphically.
echo TSKILL            Kills a process (old command).
echo TYPE              Queries the content of a file.
echo ------U------
echo [USER/USER32]     Can change hardware settings.
echo ------V------
echo [VARIABLES]       =%%var%%, set by 'SET'.
echo VER               Displays the windows version.
echo VERIFY            Determines if writing files shall be verified.
echo VOL               Queries the volume name and its serial key.
echo ------W------
echo WMIC              Works with almost everything.
echo ------X------
echo XCOPY             Copies many files.
%Exit%


:Programpaths
echo.
echo The following commands open programs under Windows XP Professional:
echo.
echo --------
echo Calc           Windows Calculator
echo Certmgr.msc    Certification manager
echo Charmap        Character map
echo Cleanmgr       Windows Disk Cleanup Wizard
echo CMD            CMD.exe (see CMD /?)
echo Compmgmt.msc   Computer management
echo --------
echo Devmgmtm.msc   Device management
echo Diskmgmt.msc   Disk manager
echo Dfrg.msc       Windows XP-Defragmentation manager
echo Drwtsn32       Doctor Watson, Windows crash reporter
echo Edit           DOS Editor
echo Eudcedit       Character creation program
echo Eventvwr       NT Eventviewer
echo Start Excel    Microsoft Office Excel
echo Explorer       Windows Explorer
echo --------
echo Start firefox  Mozilla Firefox
echo Freecell       Card game
echo Fsmgmt.msc     Folder security manager
echo Gpedit.msc     Folder security manager
echo Iexplore       Windows Internet Explorer
echo Lusrmgr.msc    Local users manager
echo --------
echo Magnify        Windows Magnifier
echo Start moviemk  Windows Movie Maker
echo Mplay32        Media Player
echo Start mplayer2 Windows Media Player - old version
echo Start msconfig Microsoft configuration program for startup and tools
echo Mshearts       Card game
echo Start msinfo32 System information
echo Mspaint        Drawing program
echo Narrator       Microsoft Sam/Anna narrator
echo Notepad        Texteditor
echo Ntbackup       Backup manager
echo Ntmsmgr.msc    Removable storage manager
echo Ntmsoprq.msc   Removable storage operator requests
echo --------
echo Start OneNote  Microsoft Office OneNote
echo Osk            On-Screen-Keyboard
echo Perfmon.msc    Performance monitor
echo Start pinball  Pinball game
echo Start powerpnt Microsoft Office Powerpoint
echo Regedit        Registry-Editor
echo Regedt32       Registry-Editor
echo Rsop.msc       Resultant set of policy connecting with the internet
echo Secpol.msc     Security policies
echo Services.msc   Services
echo Sndrec32       Windows Soundrecorder
echo Sndvol32       Volume, noises
echo Sol            Card game
echo Spider         Card game
echo --------
echo Taskmgr        Windows Task-Manager
echo Tourstart      Windows XP-Tour
echo Utilman        Help-program manager
echo Verifier       Driver validation assistant
echo Winhelp        Windows Help
echo Winmine        Game
echo Winver         Windows Version
echo Start winword  Microsoft Office Word
echo Start wmplayer Windows Media Player
echo Start wordpad  Texteditor
echo Write          Texteditor
%Exit%


:HELP
echo.
echo Lists most of the commands of CMD / Batch.
echo.
echo Syntax:
echo.
echo List of the commands: ' cmdhelp '
echo Help to commands    : ' cmdhelp Command '
echo Headquaters         : ' cmdhelp Headquaters '
%Exit%


:Arguments
echo.
echo Arguments are comparable with variables, but they are used on start of a
echo batch file or when jumping to a springpoint by 'call'.
echo.
echo Arguments are written as the following:
echo %%1
echo %%2
echo %%3
echo ..
echo %%9
echo.
echo %%10 does not exist. To use this command, you have to use 'shift'.
echo.
echo Arguments can be changes the same way as the variables from the
echo 'FOR'-command, if they are paths:
echo.
echo %%~1      = Argument is used without quotation marks.
echo %%~d1     = Argument is only the drive letter of the path.
echo %%~p1     = Argument is only the path without filename of the path.
echo %%~f1     = Argument is only the entire filename of the path.
echo %%~n1     = Argument is only the filename without extension of the path.
echo %%~x1     = Argument is only the file extension of the path.
echo %%~s1     = Argument is written in shortnames only.
echo %%~a1     = Argument is the attributes of the file of the path.
echo %%~t1     = Argument is the date and time of the file of the path.
echo %%~z1     = Argument is the file size of the file of the path.
echo.
echo The letters can be combined to for example %%~nx1 or %%~dpfs1.
echo.
echo Examples for arguments:
echo 1. In the entered command ' cmdhelp Arguments ', "Arguments" is %%1.
echo 2. In the entered command ' FOR /? ', "/?" is %%1.
echo 3. In the entered command ' netsh firewall show opmode ', "firewall" is
echo    %%1, "show" is %%2 and "opmode" is %%3.
echo.
echo 4. In the command ' call :Sprinpoint "Path" Filename "Description",
echo    '"Path"' is %%1, "Filename" %%2 and '"Description"' %%3.
echo.
echo If an argument contains spaces, but it shall only be one argument, you
echo can put it into quotation marks.
%Exit%


:Ascii
echo.
echo Ascii-symbols are characters, that are read in CMD another way as written in
echo notepad.
echo You can write them by pressing ' Alt + Number from numeric keyboard '.
echo Therefore you have to hold Alt until the last number was pressed.
echo.
echo While ' Alt + 234 ' is in notepad a U with a top, it is a filled space in CMD.
echo.
echo There are the numbers 1-256 or 01-0256. The last one are the same as the first
echo in general, but they are more organised.
%Exit%


:Errorlevel
echo.
echo The errorlevel is reset after every executed command. Usually it is 0 or 1.
echo If the errorlevel is 0, the command was executed without erros.
echo If the errorlevel is 1, the command was executed with errors.
echo.
echo The errorlevel is set into %%ERRORLEVEL%%. You can use it for IF-conditions
echo to test if a command was executed rightly:
echo.
echo if errorlevel 1 echo Command did not work!
echo.
echo He is also used in the Windows-XP-Home-command 'choice'. This command is not
echo listed here.
%Exit%


:Explorer
echo.
echo 'explorer' opens the Windows Explorer. You can also enter paths:
echo.
echo explorer C:\Windows\system32
echo.
echo If you start a file by using this command, Windows shows (under XP Prof.)
echo a warning before that this file wants to be executed.
echo.
echo Instead of 'explorer' you can use 'start'.
%Exit%


:FTP
echo.
echo FTP stands for "File Transfer Protocol". This means that files can be sent
echo over the Internet.
echo To make this possible, you need an FTP-able server and a login.
echo.
echo The FTP-command can either be used in an automatically or manually form.
echo Parameters for the automatic form are the followings:
echo.
echo Syntax: FTP [-v] [-d] [-i] [-n] [-g] [-s:Filename] [-A] [Host]
echo îîîîîîî
echo -A	        Logs the user in as "Anonym". 
echo -d         Activates debugging. 
echo -g         Deactivates placeholders.
echo -i         Loads mulitple files up without demand.
echo -n         No sudden login when opening a site. 
echo -s:File    Declares a file from which FTP-commands shall be read.
echo -v         Do not show any information.
echo Host       Website or IP.
echo.
echo To use the automatic form best, you should have a file from which manual FTP-
echo commands are read (-s:File).
echo.
echo For the manual version, there are the following commands:
echo.
echo !               delete          literal         prompt          send
echo ?               debug           ls              put             status
echo append          dir             mdelete         pwd             trace
echo ascii           disconnect      mdir            quit            type
echo bell            get             mget            quote           user
echo binary          glob            mkdir           recv            verbose
echo bye             hash            mls             remotehelp
echo cd              help            mput            rename
echo close           lcd             open            rmdir
echo.
echo For further explanation of these commands, enter "FTP" into CMD and then "?".
echo Here a useful command row:
echo.
echo open www.ftp-server.com
echo user FTP_001
echo FTP-Tester_001
echo ascii
echo prompt
%EXIT%


:Shortnames
echo.
echo Shortnames are shorted names of files and folders that can make the work
echo easier if you use for example 'start'.
echo.
echo They are also called 8-point-3-names, because the names never contain more
echo thatn 8 characters and their extension not more than 3.
echo.
echo Spaces are deleted in shortnames. It also does not use case sensitive.
echo.
echo Shortnames of a path are easy to find out:
echo Take the first 6 characters of the path part and add a ~1.
echo If there may be the same name two times, the program uses the alphabet.
echo Therefore the second path is ~2:
echo.
echo C:\Documents and Settings\User\Locale Settings\Temp
echo C:\DOCUME~1\USER\LOCALE~1\Temp
echo ---^> The first 6 letters and added a ~1.
echo.
echo C:\This is a folder\And this a file.txt
echo C:\THISIS~1\ANDTHI~1.TXT
echo ---^> The spaces are removed, the first 6 letters are taken, added a
echo      ~1 and the extension behind the point.
%Exit%


:Springpoints
echo.
echo Springpoints are marks inside a batchfile that allow to work with particular
echo functions easier.
echo.
echo A springpoint begins with a colon.
echo :Springpoint
echo.
echo It contains never spaces and it is case-sensitive. If there is another word
echo right behind the springpoint, then it is an argument (%%1, %%2 etc.).
echo.
echo Springpoints are called by 'goto' or'call':
echo goto Springpoint
echo call Springpoint
echo.
echo The 'goto-command' is irreversible in contrast to the 'call-command'. A
echo batchfile continues with the commands below the 'call-command' if it would
echo usually quit.
echo Here a short example:
echo _______________________________________________________________
echo @echo off
echo echo This is definitely the first line that appears.
echo call :Ende
echo echo This line is displayed at last.
echo pause ^>nul
echo :Ende
echo echo This line is the second one that appers.
echo exit /b
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo.
echo 'exit /b' closes a batchfile, but not the CMD-window.
%Exit%


:Symbols
echo.
echo Symbols like ^&, ^| or %% are used in batch to support commands.
echo.
echo ^&    = Command division. Command1 ^& Command2 are executed.
echo ^&^&   = Command division. Command2 is only executed if Command1 successed.
echo ^|    = Command linking. The commands refer to each other. There are a few
echo        rules. More about that see below.
echo ^|^|   = Command division. Command2 is only executed if Command1 failed.
echo %%    = Multiple usage: 1. Variables
echo                        2. Arguments
echo                        3. FOR-command
echo.
echo Most of the symbols can be printed if you put a ^^ in front of it.
echo In front of percent symbols you have to put another %% to print it.
echo For variables      : %%%%var%%%%
echo For arguments      : %%%%1
echo For the FOR-command: %%%%%%%%A
echo.
echo ^| links commands. A command always refers to the output of the other one,
echo but 'echo' is written first if used.
echo 'sort' or 'more' e.g. are the last one, though.
echo.
echo Therefore in 'echo.^|date', the 'echo' answers the question of 'date', which
echo new date the user wants to enter.
echo.
echo In 'systeminfo^|sort', 'sort' sorts the output of 'systeminfo' by the
echo alphabet.
%Exit%


:User
echo.
echo There are not enough information about User/User32 to give a detailed
echo explanation. We ask for apology.
%Exit%


:Variables
echo.
echo Variables are values that are set to a string by the 'SET'-command.
echo.
echo They are enclosed by percent signs or, under usage of
echo 'setlocal enabledelayedexpansion', by exclamation marks:
echo.
echo %%Variable%%
echo !Variable!
echo.
echo There the strings are called. It can be used to analyze user prompts, to
echo let the program count or to write a game in using for every place a variable.
echo.
echo The last one is for advanced coders only, though.
echo.
echo Examples:
echo set Startup=C:\Documents and Settings\User\Start menu\Programs
echo set Startup=%%Startup%%\Startup
echo echo The startup folder is %%Startup%%.
echo.
echo The output would be:
echo The startup folder is C:\Documents and Settings\User\Start menu\Programs\Startup.
%Exit%


:Commands
echo.
REM 98 / 4 = 25
if not "%2" == "/w" (
echo Under usage of /w you can display the commands in widescreen.
echo.
	FOR /F "skip=22 tokens=1-3" %%A IN ('"cmdhelp|sort"') DO (
		if not "%%A" == "(from" (
			if not "%%A" == "Enter" (
				if not "%%B" == "/" (
					echo %%A
				) ELSE (
					echo %%A %%B %%C
				)
			)
		)
	)
) ELSE (
REM  1                  2                  3                  4
echo %%0                 CHKNTFS            GPRESULT           REN / RENAME
echo %%var%%              CLS                GFRATABL           REPLACE
echo %%var:~X,Y%%         CMD                HELP               SC
echo [ARGUMENTS]        COLOR              IF                 SET
echo [ASCII]            COMMAND            LABEL              SETLOCAL
echo [COMMANDS]         COMP               MD / MKDIR         SHIFT
echo [ERRORLEVEL]       COMPACT            MODE               SHUTDOWN
echo [EXPLORER]         CONVERT            MORE               SORT
echo [PROGRAMPATHS]     COPY               MOVE               START
echo [SHORTNAMES]       DATE               MSG                SUBST
echo [SPRINGPOINTS]     DEFRAG             MSGBOX             SYSTEMINFO
echo [SYMBOLS]          DEL / ERASE        NET                TASKKILL
echo [USER/USER32]      DIR                NETSH              TASKLIST
echo [VARIABLES]        DOSKEY             NETSTAT            TIME
echo ^>NUL               DRIVERQUERY        PATH               TITLE
echo 2^>^&1               ECHO               PAUSE              TREE
echo ASSOC              ENDLOCAL           PING               TSKILL
echo AT                 EXIT               PRINT              TYPE
echo ATTRIB             FC                 PROMPT             VER
echo BREAK              FIND               PUSHD / POPD       VERIFY
echo CACLS              FINDSTR            RD / RMDIR         VOL
echo CALL               FOR                RECOVER            WMIC
echo CD / CHDIR         FORMAT             REG                XCOPY
echo CHCP               FTYPE              REGEDIT
echo CHKDSK             GOTO               REM
)
%Exit%


:Headquaters
echo.
set Command=
set /p Command=%cd% ^| cmdhelp ^> 
if /i "%Command%" == "q" exit /b
if /i "%Command%" == "quit" exit /b
if /i "%Command%" == "stop" exit /b
if "%Command%" == "" (goto :Read) ELSE (cmdhelp %Command% Headquaters)
goto :Headquaters


REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************