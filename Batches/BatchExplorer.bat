:: !!! GOTO-BEFEHL UNTER COLOR ZUR KORREKTEN AUSF�HRUNG ENTFERNEN !!!

:: ":Algorithm_TrashSet" gibt Fehler nach erster Benutzung eines Laufwerks.
:: ":Algorithm_TrashSet" macht Fehler bei mehr als 10 Dateien: Reihenfolge der "wahren" Dateinamen ungleich!
:: ---> Alle Ordner gleichzeitig mit DIR und anschlie�end ^| sort

:: Ver�nderbare Ordner-Icons hinzuf�gen! [set FolderIcon_Line1=���] �ber :Initializer! Ver�nderbar durch Benutzer! Hinweis in :HELP > 2
:: Ver�nderbaren Wert "ResetVariables" (0 / 1) hinzuf�gen.
:: --- 0 = Benutzte Variablen f�r Dateien und Ordner nicht resetten (spart Zeit)
:: --- 1 = Benutzte Variablen f�r Dateien und Ordner bei jedem Refresh resetten (verhindert Fehler)


@echo off
title Batch Explorer
REM (C) Copyright 2011 GrellesLicht28
REM This is a creation of Makroware.
Setlocal EnableDelayedExpansion
color 0a


:: Checking amount of characters in the username for main display
FOR /L %%A IN (0,1,17) DO if not "!username:~%%A,1!" == "" set /a UserLetters_Amount=!UserLetters_Amount! + 1
FOR /L %%A IN (0,1,!UserLetters_Amount!) DO set /a UserLetters_Borders=!UserLetters_Borders! + 1
FOR /L %%A IN (!UserLetters_Amount!,1,17) DO set /a UserLetters_Space=!UserLetters_Space! + 1
FOR /L %%A IN (1,1,!UserLetters_Space!)   DO set Sidebar_Space= !Sidebar_Space!
FOR /L %%A IN (1,1,!UserLetters_Borders!) DO set Sidebar_Borders=!Sidebar_Borders!�


Setlocal
set DefaultCols=157
if "%1" == "" mode con cols=%DefaultCols%
Endlocal






 :Initializer
:Initializer
	set ErrorFix=0
	call :Check_WindowSettings
	call :Check_CountFolders
	call :Check_CountFiles
	call :Check_CurrentDirectory
	call :Algorithm_CurrentDirectory
	call :Algorithm_FolderSet
	call :Algorithm_FileSet
	set CurrentPage=1
	set Display=Folder
goto :StartDisplay_Folder



 :Check_WindowSettings
:Check_WindowSettings
	:: Set the total amount of available columns and lines from the current CMD-window
		:: This program does not support a higher line amount than 80. In case, only 80 lines will be used.
	set Cols=
	set Lines=
	set Line_Space=
	set TableHeaderSpace_1=
	set TableHeaderSpace_2=
	:: Languages (lines) in this row: German - English and Italian - French - Dutch - Polish - Portugese - Spanish x3 - Czech - Turkish x3
	:: Languages (cols)  in this row: German - English - French - Italian - Dutch - Polish - Portugese - Spanish - Czech - Turkish x2
	FOR /F "tokens=1,2 delims=: " %%A IN ('mode con') DO (
		if "%%A" == "Zeilen" set Lines=%%B
		if "%%A" == "Lines" set Lines=%%B
		if "%%A" == "Lignes" set Lines=%%B
		if "%%A" == "Lijnen" set Lines=%%B
		if "%%A" == "Linie" set Lines=%%B
		if "%%A" == "Linhas" set Lines=%%B
		if "%%A" == "Lineas" set Lines=%%B
		if "%%A" == "L�neas" set Lines=%%B
		if "%%A" == "L�neas" set Lines=%%B
		if "%%A" == "Linky" set Lines=%%B
		if "%%A" == "Cizgyler" set Lines=%%B
		if "%%A" == "�izgyler" set Lines=%%B
		if "%%A" == "�izgyler" set Lines=%%B
		if "%%A" == "Spalten" set Cols=%%B
		if "%%A" == "Columns" set Cols=%%B
		if "%%A" == "Colonnes" set Cols=%%B
		if "%%A" == "Colonne" set Cols=%%B
		if "%%A" == "Kolommen" set Cols=%%B
		if "%%A" == "Kolumny" set Cols=%%B
		if "%%A" == "Colunas" set Cols=%%B
		if "%%A" == "Columnas" set Cols=%%B
		if "%%A" == "Sloupcu" set Cols=%%B
		if "%%A" == "S�tunlar" set Cols=%%B
		if "%%A" == "S�tunlar" set Cols=%%B
	)
	if "!Cols!" == "" set Cols=80
	if "!Lines!" == "" set Lines=80
	set /a Lines=!Lines! - 80
	if not "!Lines:~0,1!" == "-" (set Lines=80) ELSE (set Lines=!Lines! + 80)
	
	
	:: ERROR-Fix: Prevent the program from getting too less space for displaying
	:: Minimum:    60 columns //    30 lines
	:: Default:    80 columns //   300 lines
	:: Maximum: 32766 columns // 32766 lines (based on Windows XP Prof. SP 3)
	set /a TemporaryCalc=!Cols! - 60
	if "!TemporaryCalc:~0,1!" == "-" (
		cls
		echo Window size not supported.
		echo ��������������������������
		echo The explorer does not
		echo support a lower amount of
		echo columns than 60.
		echo If you continue, it may
		echo cause some errors.
		echo.
		echo Do you wish to
		set /p TemporaryCalc=continue? [Y / N] - 
		if not "!TemporaryCalc!" == "y" if not "!TemporaryCalc!" == "Y" (
			mode con cols=80 lines=300
			goto :Check_WindowSettings
		)
	)
	set /a TemporaryCalc=!Lines! - 30
	if "!TemporaryCalc:~0,1!" == "-" (
		cls
		echo Window size not supported.
		echo ��������������������������
		echo The explorer does not support a lower amount of lines than 30.
		echo If you continue, it may cause some errors.
		echo.
		set /p TemporaryCalc=Do you wish to continue? [Y / N] - 
		if not "!TemporaryCalc!" == "y" if not "!TemporaryCalc!" == "Y" (
			mode con cols=80 lines=300
			goto :Check_WindowSettings
		)
	)
	
	:: -37 because of sidebar and free space between borders and folders
	:: /10 because of used horizontal space per folder
	set /a FoldersPerLine=(!Cols! - 37) / 10
	
	:: *10 to fit to the folders' table
	:: -26 because of file extension (10) and extra file extension column (16)
	set /a FilenameSpacePerLine=(!FoldersPerLine! * 10) - 26
	
	:: -19 because of necessary vertical free space
	:: /8  because of used vertical space per folder
	set /a LineMaximum_Folder=(!Lines! - 19) / 8
	
	:: -20 because of the space above and below, the current path and the table header
	set /a LineMaximum_File=!LineMaximum_Folder! * 8
	
	:: *10 because of /10 from "FoldersPerLine"
	:: +3  because of 4 places left at the left (one reserved for border)
	set /a CurPathSpace=(!FoldersPerLine! * 10) + 3
	
	:: Space between the headers "Filename" and "Extension" and borders
	:: "TableHeaderSpace_1": +2 because of the word "Filename" (-8) and the file extension in the Filename-column (+10)
	:: "TableHeaderSpace_2": -19 because of EXE-alert (-3), the word "Filename" (-8), the space between "Filename" and "Extension" and the word "Extension" (-9)
	set /a TableHeader_1=!FilenameSpacePerLine! + 2
	set /a TableHeader_2=(!CurPathSpace! + 1) - 3 - 8 - !TableHeader_1! - 9
	
	:: %%S = Set value
	FOR /L %%S IN (1,1,!TableHeader_1!) DO set TableHeaderSpace_1=!TableHeaderSpace_1! 
	FOR /L %%S IN (1,1,!TableHeader_2!) DO set TableHeaderSpace_2=!TableHeaderSpace_2! 
	
	
	:: Set space for blanks in the table
	FOR /L %%C IN (1,1,!FoldersPerLine!) DO FOR /L %%S IN (1,1,10) DO set Line_Space=!Line_Space! 
	
	
	:: Settings of the desktop
		:: -5  because of borders
		:: /18 because of used horizontal space per desktop content
		set /a DesktopPerLine=(!Cols! - 5) / 18
		
		:: -8 because of upper and lower borders (4), user input request (2) and the menus on the top (2)
		:: /8 because of 2 blanks to the upper one, 4 lines for the icon and 2 lines for the filename
		set /a LineMaximum_Desktop=(!Lines! - 8) / 8
		
		:: -3 because of borders and 1 space at the end (to prevent line breaks)
		:: This variable also works for the upper and the lower border
		:: This variable also works for the current path
		set /a Desktop_LineSpace=!Cols! - 3
		
		FOR /L %%S IN (1,1,!Desktop_LineSpace!) DO (
			set Desktop_Border=!Desktop_Border!�
			set Desktop_LineSpace_Space=!Desktop_LineSpace_Space! 
		)
	:: End of desktop
exit /b




 :Check_CountFolders
:Check_CountFolders
	:: ERROR-Fix: Prevent the program from too much time to calculate in extremely large folders (e.g. system32)
	set Overload=
	FOR /F "delims=" %%E IN ('cd') DO (
		FOR %%N IN (system32 system64 dllcache i386) DO if /i "%%~nxE" == "%%N" set Overload=1
		if /i "%%~E" == "!SystemRoot!\Help" set Overload=1
		if /i "%%~E" == "!SystemRoot!\inf" set Overload=1
	)
	if "!Overload!" == "1" (
		cls
		echo System overload.
		echo ����������������
		echo This error is occured when trying to access a folder that contains too many
		echo files. It is meant to prevent the program from calculating too long.
		echo.
		echo To use a particular command from the Explorer, please switch to another
		echo directory and enter "Foldername\FileNameHere" when being asked for a file's
		echo name.
		echo.
		echo Example: "Please enter the file's name: "
		echo - "system32\cmd.exe"
		echo.
		echo If this does not work, you may use commands in batch to solve the problem.
		echo Example: Function "File > New"
		echo Command: "echo.>FileNameHere.Extension"
		echo.
		echo "echo." allows to create the mentioned file.
		echo Warning: This command will overwrite existing files with the same name.
		echo          Be careful.
		echo.
		pause
		goto :StartDisplay_Overload
	)
		
		
		
	FOR /L %%R IN (1,1,!FolderCount!) DO set Folder%%R=
	set FolderCount=0
	FOR /F "delims=" %%A IN ('dir /AD /B 2^>nul') DO (
		set /a FolderCount=!FolderCount! + 1
		set Folder!FolderCount!=%%A
	)
exit /b


 :Check_CountFiles
:Check_CountFiles
	FOR /L %%R IN (1,1,!FileCount!) DO set File%%R=
	set FileCount=0
	FOR /F "delims=" %%A IN ('dir /A-D /B 2^>nul') DO (
		set /a FileCount=!FileCount! + 1
		set File!FileCount!=%%A
	)
exit /b


 :Check_CurrentDirectory
:Check_CurrentDirectory
	:: %~1 equals "NoReset" in case "Check_CurrentDirectory" is called by "Algorithm_CurrentDirectory"
	if not "%~1" == "NoReset" (
		set EditPath=0
		:: The program overwrites the CD-variable. This command resets the variable to its true value.
		FOR /F "delims=" %%S IN ('cd') DO set cd=%%S
	)
	:: Check if the amount of characters from the current directory's path is less than the available space
		:: If not, the path is shortened. This progress is done in "Algorithm_CurrentDirectory".
	:: CurPathSpaceUsed is already set to 3 because every path is forced to contain at least X:\
	set CurPathSpaceUsed=3
	set CurPathSpaceLeft=0
	FOR /L %%A IN (3,1,%CurPathSpace%) DO (
		if "!cd:~%%A,1!" == "" (set /a CurPathSpaceLeft=!CurPathSpaceLeft! + 1) ELSE (set /a CurPathSpaceUsed=!CurPathSpaceUsed! + 1)
	)
	if not "!cd:~%CurPathSpace%,1!" == "" set /a EditPath=!EditPath! + 1
exit /b




 :Check_SwitchPage
:Check_SwitchPage
	if /i "!Userinput!" == "Previous" set /a CurrentPage=%CurrentPage% - 1
	if /i "!Userinput!" == "Previous" if "!LineA_%CurrentPage%_1!" == "" if "!LineF_%CurrentPage%_1!" == "" set /a CurrentPage=%CurrentPage% + 1
	if /i "!Userinput!" == "Next" set /a CurrentPage=%CurrentPage% + 1
	if /i "!Userinput!" == "Next" if "!LineA_%CurrentPage%_1!" == "" if "!LineF_%CurrentPage%_1!" == "" set /a CurrentPage=%CurrentPage% - 1
	set /a TemporaryCalc=!FilePageStart! - 1
	if "%CurrentPage%" == "%TemporaryCalc%" set Display=Folder
	if "%CurrentPage%" == "!FilePageStart!" set Display=File
goto :StartDisplay_%Display%






 :Algorithm_CurrentDirectory
:Algorithm_CurrentDirectory
	:: EditPath = 1 = Use shortnames of each folder in the current directory
	:: EditPath = 2 = Shorten the name of each folder to 4 letters and add .. (6 characters totally)
	:: EditPath = 3 = Shorten the name of each folder to 3 letters and add .. (5 characters totally)
	:: EditPath = 4 = Keep the name of each folder, but replace the ".." by "~" (4 characters totally)
	:: EditPath = 5 = Shorten the name of each folder to 2 letters (2 characters totally)
	
	:: (2,1,20) allows 20 subfolders at last. This value can be changed.

	set Line_Borders=
	set CurPathSpace_Space=
	set CurPathSpace_Borders=
	if "!EditPath!" == "1" (
		FOR /F "delims=" %%E IN ("!cd!") DO set cd=%%~sE
		call :Check_CurrentDirectory NoReset
	)
	set Token=2
	if "!EditPath!" == "2" call :SubAlgorithm_EditPath_2
	if "!EditPath!" == "2" call :Check_CurrentDirectory NoReset
	set Token=2
	if "!EditPath!" == "3" call :SubAlgorithm_EditPath_3
	if "!EditPath!" == "3" call :Check_CurrentDirectory NoReset
	set Token=2
	if "!EditPath!" == "4" call :SubAlgorithm_EditPath_4
	if "!EditPath!" == "4" call :Check_CurrentDirectory NoReset
	set Token=2
	if "!EditPath!" == "5" call :SubAlgorithm_EditPath_5
	if "!EditPath!" == "5" call :Check_CurrentDirectory NoReset
	FOR /L %%A IN (2,1,!CurPathSpaceLeft!) DO (
		set CurPathSpace_Space=!CurPathSpace_Space! 
		set Line_Borders=!Line_Borders!�
	)
	FOR /L %%A IN (1,1,!CurPathSpaceUsed!) DO set CurPathSpace_Borders=!CurPathSpace_Borders!�
exit /b




 :SubAlgorithm_EditPath_2
:SubAlgorithm_EditPath_2
	FOR /F "tokens=%Token% delims=\" %%E IN ("!cd!") DO (
		set TemporaryCalc=%%E
		if not "!TemporaryCalc:~5,1!" == "" if not "!TemporaryCalc:~5,1!" == "~5,1" (
			set TemporaryCalc=!TemporaryCalc:~0,4!..
			FOR /F "delims=" %%T IN ("!TemporaryCalc!") DO set cd=!cd:%%E=%%T!
		)
	)
	set /a Token=!Token! + 1
	if "!Token!" == "21" exit /b
goto :SubAlgorithm_EditPath_2


 :SubAlgorithm_EditPath_3
:SubAlgorithm_EditPath_3
	FOR /F "tokens=%Token% delims=\" %%E IN ("!cd!") DO (
		set TemporaryCalc=%%E
		if not "!TemporaryCalc:~6,1!" == "" if not "!TemporaryCalc:~6,1!" == "~6,1" (
			set TemporaryCalc=!TemporaryCalc:~0,3!..
			FOR /F "delims=" %%T IN ("!TemporaryCalc!") DO set cd=!cd:%%E=%%T!
		)
	)
	set /a Token=!Token! + 1
	if "!Token!" == "21" exit /b
goto :SubAlgorithm_EditPath_3


 :SubAlgorithm_EditPath_4
:SubAlgorithm_EditPath_4
	FOR /F "tokens=%Token% delims=\" %%E IN ("!cd!") DO (
		set TemporaryCalc=%%E
		if not "!TemporaryCalc:~5,1!" == "" if not "!TemporaryCalc:~5,1!" == "~5,1" (
			set TemporaryCalc=!TemporaryCalc:~0,3!~
			FOR /F "delims=" %%T IN ("!TemporaryCalc!") DO set cd=!cd:%%E=%%T!
		)
	)
	set /a Token=!Token! + 1
	if "!Token!" == "21" exit /b
goto :SubAlgorithm_EditPath_4


 :SubAlgorithm_EditPath_5
:SubAlgorithm_EditPath_5
	FOR /F "tokens=%Token% delims=\" %%E IN ("!cd!") DO (
		set TemporaryCalc=%%E
		if not "!TemporaryCalc:~3,1!" == "" if not "!TemporaryCalc:~3,1!" == "~3,1" (
			set TemporaryCalc=!TemporaryCalc:~0,2!~
			FOR /F "delims=" %%T IN ("!TemporaryCalc!") DO set cd=!cd:%%E=%%T!
			FOR /F "delims=" %%T IN ("!TemporaryCalc!") DO echo set cd == cd:%%E=%%T == !cd:%%E=%%T!
		)
	)
	set /a Token=!Token! + 1
	if "!Token!" == "21" exit /b
goto :SubAlgorithm_EditPath_5






 :Algorithm_FolderSet
:Algorithm_FolderSet
	:: FolderDisplay-variable defintion: FolderDisplay_!Page!_!Line!_!Column!=Name of the folder
		:: FolderDisplay   = String to identify variable
		:: !Page!          = The folder is displayed on page "Page"
		:: !Line!          = The folder is displayed in line "Line" of the display
		:: !Column! / %%C  = The folder is displayed in column "Column" of the display
	:: TemporaryCalc is used to change the line of the display
	
	
	:: Resetting possible variables from the "Trash"-menu
	FOR /L %%A IN (1,1,!Counter!) DO (
		set RecycleBinContent%%A=
		set RecycleBinType%%A=
	)
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		set RecycleBinContent%%P_%%L=
		set RecycleBinType%%P_%%L=
	)
	
	:: Resetting used variables
	set TemporaryCalc=!FoldersPerLine!
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
		FOR /L %%C IN (1,1,!FoldersPerLine!) DO set FolderDisplay_%%P_%%L_%%C=
		set LineA_%%P_%%L=
		set LineB_%%P_%%L=
		set LineC_%%P_%%L=
		set FolderDisplayLine_%%P_%%L=
	)
	FOR /L %%P IN (!FilePageStart!,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		set File%%P_%%L=
		set File%%P_%%L_ExeAlert=
		set FileExtension%%P_%%L=
		set LineF_%%P_%%L=
	)
	
	set Line=1
	set Page=1
	set Col=1
	FOR /L %%F IN (1,1,!FolderCount!) DO (
		if not "!Folder%%F!" == "" set FolderDisplay_!Page!_!Line!_!Col!=!Folder%%F!
		set /a Col=!Col! + 1
		if "!Line!" == "!LineMaximum_Folder!" if "!Col!" GTR "!FoldersPerLine!" (
			set Col=1
			set Line=0
			set /a Page=!Page! + 1
		)
		if "%%F" == "!TemporaryCalc!" (
			set Col=1
			set /a Line=!Line! + 1
			set /a TemporaryCalc=!TemporaryCalc! + !FoldersPerLine!
		)
	)
	
	
	
	
	set TemporaryCalc=0
	
	:: %%P = Page // %%L = Line // %%C = Column // %%A = Add space
	:: Removing spaces from the start and the end of each folder's name
	:: Adding ".." to the display name in case the name is too long for the icon (max. 9 letters)
		:: If the name is shorter than 9 letters, it adds spaces to the name until the name is exactly 9 letters long
	:: Mark the text to see invisible spaces
	:: Important notice:
		:: Every variable that uses "_%%P_%%L_%%C" contains one single name
		:: Every variable that does not contain "_%%C" contains an entire line with multiple names
	
	FOR /L %%P IN (1,1,!Page!) DO (
		FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
			FOR /L %%C IN (1,1,!FoldersPerLine!) DO (
				set TemporaryCalc=0
				if not "!FolderDisplay_%%P_%%L_%%C!" == "" (
					if not "!FolderDisplay_%%P_%%L_%%C:~9,1!" == "" if not "!FolderDisplay_%%P_%%L_%%C:~9,1!" == "~9,1" set FolderDisplay_%%P_%%L_%%C=!FolderDisplay_%%P_%%L_%%C: =!
					if not "!FolderDisplay_%%P_%%L_%%C:~9,1!" == "" if not "!FolderDisplay_%%P_%%L_%%C:~9,1!" == "~9,1" set FolderDisplay_%%P_%%L_%%C=!FolderDisplay_%%P_%%L_%%C:~0,7!..
					FOR /L %%A IN (1,1,8) DO (
						if "!FolderDisplay_%%P_%%L_%%C:~%%A,1!" == "" set /a TemporaryCalc=!TemporaryCalc! + 1
						if "!FolderDisplay_%%P_%%L_%%C:~%%A,1!" == "~%%A,1" set /a TemporaryCalc=!TemporaryCalc! + 1
					)
					set /a TemporaryCalc=!TemporaryCalc! / 2
					FOR /L %%A IN (1,1,!TemporaryCalc!) DO (
						set FolderDisplay_%%P_%%L_%%C= !FolderDisplay_%%P_%%L_%%C!
						set FolderDisplay_%%P_%%L_%%C=!FolderDisplay_%%P_%%L_%%C! 
					)
					if "!FolderDisplay_%%P_%%L_%%C:~8,1!" == "" set FolderDisplay_%%P_%%L_%%C=!FolderDisplay_%%P_%%L_%%C! 
					if "!FolderDisplay_%%P_%%L_%%C:~8,1!" == "~8,1" set FolderDisplay_%%P_%%L_%%C=!FolderDisplay_%%P_%%L_%%C! 
					set LineA_%%P_%%L=!LineA_%%P_%%L!���       
					set LineB_%%P_%%L=!LineB_%%P_%%L!���       
					set LineC_%%P_%%L=!LineC_%%P_%%L!���       
				) ELSE (
					set FolderDisplay_%%P_%%L_%%C=         
					set LineA_%%P_%%L=!LineA_%%P_%%L!          
					set LineB_%%P_%%L=!LineB_%%P_%%L!          
					set LineC_%%P_%%L=!LineC_%%P_%%L!          
				)
				set FolderDisplayLine_%%P_%%L=!FolderDisplayLine_%%P_%%L! !FolderDisplay_%%P_%%L_%%C!
			)
		)
	)
	
	:: Enable 2nd line of each page to prevent error in case !LineMaximum_Folder! = 1
	:: %%R = Replace A, B, C to make the code shorter
	FOR %%R IN (A B C) DO FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
		if "!Line%%E_%%P_%%L!" == "" set Line%%E_%%P_%%L=!Line_Space!
		if "!FolderDisplayLine_%%P_%%L!" == "" set FolderDisplayLine_%%P_%%L=!Line_Space!
	)
	
	:: ERROR-Fix: Fixing an error caused by an unknown reason
	if "!Cols:~-1,1!" == "6" set ErrorFix=1
	if "!Cols:~-1,1!" == "7" set ErrorFix=1
	if "!ErrorFix!" == "1" (
		FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
			set LineA_%%P_%%L=!LineA_%%P_%%L:~0,-1!
			set LineB_%%P_%%L=!LineB_%%P_%%L:~0,-1!
			set LineC_%%P_%%L=!LineC_%%P_%%L:~0,-1!
			set FolderDisplayLine_%%P_%%L=!FolderDisplayLine_%%P_%%L:~0,-1!
		)
		set Line_Space=!Line_Space:~0,-1!
		set Line_Borders=!Line_Borders:~0,-1!
		set CurPathSpace_Space=!CurPathSpace_Space:~0,-1!
	)
exit /b







 :Algorithm_FileSet
:Algorithm_FileSet
	:: The FileDisplay-variable works the same as the FolderDisplay-variable, except for the fact
	:: that there is only one file per line at last.
	:: "Algorithm_FolderSet" has to be executed before "Algorithm_FileSet". Otherwise, the pages will be
	:: set incorrectly.
	set Line=1
	set /a Page=!Page! + 1
	set FilePageStart=!Page!
	FOR /L %%F IN (1,1,!FileCount!) DO (
		if not "!File%%F!" == "" set File!Page!_!Line!=!File%%F!
		FOR /F "delims=" %%E IN ("!File%%F!") DO (
			set FileExtension!Page!_!Line!=%%~xE
			if not "%%~xE" == "" assoc %%~xE>nul 2>nul || set FileExtension!Page!_!Line!=-----   Unknown
		)
		if "!Line!" == "!LineMaximum_File!" (
			set Line=0
			set /a Page=!Page! + 1
		)
		set /a Line=!Line! + 1
	)
	
	
	set /a TemporaryCalc=!FilenameSpacePerLine! - 2
	
	
	:: %%P = Page // %%L =  Line // %%E = Extension filler // %%N = Name filler // %%X = Extension keeper (%%~nX = Filename / %%~xX = File extension)
	:: // %%R = Replace letter // %%A = Add space
	:: "FilenameSpacePerLine" is the maximum amount of characters that a filename can contain (including .extension)
	:: "TemporaryCalc" is the maximum amount of characters that a filename can contain when added "~1" to it (works the same as shortnames)
		:: This addition is used to shorten filenames to the available space per file ("FilenameSpacePerLine")
		:: Files contain dots, so it is not recommended to shorten the filenames by using ".."
		:: The reason why folders are not shortened by "~1" as well is that they are at last 9 letters long. This is why the chance that 2 folders
			:: are named almost the same as each other is way higher, so "~1" would be incorrect in one case. The program had to use "~2" as well,
			:: which requires unnecessary work.
	:: The file extension (BEFORE the extension column in the table) can be at last 10 letters long including the dot.
	:: WARNING: "FileExtension" is only temporary in this command row!
	FOR /L %%P IN (!FilePageStart!,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		set NameFiller_Space=
		set ExtensionFiller_Space=
		set FileExtension=
		if not "!File%%P_%%L!" == "" (
			FOR /F "delims=" %%N IN ("!File%%P_%%L!") DO set Filename=%%~nN
			FOR /F "delims=" %%X IN ("!File%%P_%%L!") DO (
				set FileExtension=%%~xX
				if /i "%%~xX" == ".exe" (set File%%P_%%L_ExeAlert=) ELSE (set File%%P_%%L_ExeAlert= )
				FOR /L %%E IN (0,1,9) DO (
					if "!FileExtension:~%%E,1!" == "" set /a ExtensionFiller_Space=!ExtensionFiller_Space! + 1
					if "!FileExtension:~%%E,1!" == "~%%E,1" set /a ExtensionFiller_Space=!ExtensionFiller_Space! + 1
				)
				if not "!FileExtension:~10,1!" == "" if not "!FileExtension:~10,1!" == "~10,1" set FileExtension=!FileExtension:~0,10!
				FOR /L %%E IN (1,1,!ExtensionFiller_Space!) DO set FileExtension=!FileExtension! 
			) 
			if not "!Filename:~%FilenameSpacePerLine%,1!" == "" (
				set File%%P_%%L=!Filename:~0,%TemporaryCalc%!**!FileExtension!
			) ELSE (
				FOR /L %%N IN (0,1,%FilenameSpacePerLine%) DO (
					if "!Filename:~%%N,1!" == "" set /a NameFiller_Space=!NameFiller_Space! + 1
					if "!Filename:~%%N,1!" == "~%%N,1" set /a NameFiller_Space=!NameFiller_Space! + 1
				)
				FOR /L %%N IN (2,1,!NameFiller_Space!) DO set FileExtension=!FileExtension! 
				set File%%P_%%L=!Filename!!FileExtension!
			)
		) ELSE (
			set LineF_%%P_%%L=    !Line_Space!
		)
	)
	
	:: Change all letters to upper case and complete extension-column by adding spaces
	:: Complete each line by putting the Exe-alert, the filename (including lower case extension) and the file extension column together
	FOR /L %%P IN (!FilePageStart!,1,!Page!) DO (
		FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
			set ExtensionFiller_Space=
			FOR %%R IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO if not "!FileExtension%%P_%%L!" == "" if not "!FileExtension%%P_%%L!" == "-----   Unknown" set FileExtension%%P_%%L=!FileExtension%%P_%%L:%%R=%%R!
			FOR /L %%A IN (0,1,14) DO (
				if "!FileExtension%%P_%%L:~%%A,1!" == "" set /a ExtensionFiller_Space=!ExtensionFiller_Space! + 1
				if "!FileExtension%%P_%%L:~%%A,1!" == "~%%A,1" set /a ExtensionFiller_Space=!ExtensionFiller_Space! + 1
			)
			FOR /L %%A IN (0,1,!ExtensionFiller_Space!) DO set FileExtension%%P_%%L=!FileExtension%%P_%%L! 
			if not "!LineF_%%P_%%L!" == "    !Line_Space!" set LineF_%%P_%%L= !File%%P_%%L_ExeAlert! !File%%P_%%L!!FileExtension%%P_%%L! 
		)
	)
	
	:: ERROR-Fix: Fixing an error caused by an unknown reason
	if "!ErrorFix!" == "1" (
		FOR /L %%P IN (!FilePageStart!,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO if not "!LineF_%%P_%%L!" == "    !Line_Space!" set LineF_%%P_%%L=!LineF_%%P_%%L:~0,-1!
		set TableHeaderSpace_2=!TableHeaderSpace_2:~0,-1!
	)
exit /b




	









 :Algorithm_LineWriter_Folder
:Algorithm_LineWriter_Folder
	:: %1 = %CurrentPage%
	:: %2 = %%G = Current line (%%G because of Goto)
	echo �                            � �    !LineA_%1_%2!�
	echo �                            � �    !LineB_%1_%2!�
	echo �                            � �    !LineB_%1_%2!�
	echo �                            � �    !LineC_%1_%2!�
	echo �                            � �    !Line_Space!�
	echo �                            � �!FolderDisplayLine_%1_%2!    �
	echo �                            � �    !Line_Space!�
	echo �                            � �    !Line_Space!�
exit /b



:: Overview over the labels
:: ------------------------


:: Initializer
:: Initializer_Trash

:: Check_WindowSettings
:: Check_CountFolders
:: Check_CountFiles
:: Check_SwitchPage
:: Check_SwitchPage_Trash
:: Check_CurrentDirectory

:: Algorithm_FolderSet
:: Algorithm_FileSet
:: Algorithm_TrashSet
:: Algorithm_CurrentDirectory
	:: SubAlgorithm_EditPath_2
	:: SubAlgorithm_EditPath_3
	:: SubAlgorithm_EditPath_4
	:: SubAlgorithm_EditPath_5
:: Algorithm_LineWriter_Folder
:: Algorithm_LineWriter_Desktop

:: StartDisplay_Folder
	:: Menu_File_SentFromFolders
		:: New_Folder
		:: Properties_Folder
	:: Menu_View_SentFromFolders
	:: Menu_Go_SentFromFolders
	:: Menu_Help_SentFromFolders

:: StartDisplay_File
	:: Menu_File_SentFromFiles
		:: OpenWith
		:: Find
		:: New_File
		:: Properties_File
	:: Menu_Edit_SentFromFiles
		:: SubMenu_Edit_SentFromFiles
		:: SubMenu_Edit_SentFromFiles_MS-DOS
	:: Menu_View_SentFromFiles
	:: Menu_Go_SentFromFiles
	::?:: Menu_Help_SentFromFiles

:: StartDisplay_Trash
	:: Menu_File_SentFromTrash
		:: RestoreFile
		:: Properties_Trash
			:: Properties_Trash_Folder
	:: Menu_View_SentFromTrash
	:: Menu_Go_SentFromTrash
	:: Menu_Help_SentFromTrash

:: StartDisplay_Desktop

:: StartDisplay_Overload




:: Help
	:: Help_CoveredErrors
	:: Help_Customization
:: Commands
:: Settings
:: About







 :StartDisplay_Folder
:StartDisplay_Folder
cls
set UserInput=
echo File  View  Go  Help
echo �     �     �   �
echo ����������������������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���                      � ��� ��home��� %username% �
echo �   [ ]    %username%!Sidebar_Space!� ���ͼ���������!Sidebar_Borders!�
echo �   ���                      �
echo �                            � �!CurPathSpace_Borders!�!Line_Borders!�
echo �   -^>                       � �!cd!�!CurPathSpace_Space!�
echo �        Trash             � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo �   �                       � �    !LineA_%CurrentPage%_1!�
echo �                            � �    !LineB_%CurrentPage%_1!�
echo � �����Ŀ                    � �    !LineB_%CurrentPage%_1!�
echo � �     �  Desktop           � �    !LineC_%CurrentPage%_1!�
echo � �������                    � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_1!    �
echo ������������������������������ �    !Line_Space!�
echo �����������File�system�������� �    !Line_Space!�
echo ������������������������������ �    !LineA_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineC_%CurrentPage%_2!�
echo �                            � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_2!    �
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
FOR /L %%G IN (3,1,!LineMaximum_Folder!) DO call :Algorithm_LineWriter_Folder %CurrentPage% %%G
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "F" goto :Menu_File_SentFromFolders
if /i "!UserInput!" == "File" goto :Menu_File_SentFromFolders
if /i "!UserInput!" == "V" goto :Menu_View_SentFromFolders
if /i "!UserInput!" == "View" goto :Menu_View_SentFromFolders
if /i "!UserInput!" == "G" goto :Menu_Go_SentFromFolders
if /i "!UserInput!" == "Go" goto :Menu_Go_SentFromFolders
if /i "!UserInput!" == "H" goto :Menu_Help_SentFromFolders
if /i "!UserInput!" == "Help" goto :Menu_Help_SentFromFolders
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput% 
	pause
	goto :Initializer
)
goto :StartDisplay_Folder





REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_File_SentFromFolders
:Menu_File_SentFromFolders
if "!UniversalCut!" == "" (set Cut=      ) ELSE (set Cut=/Paste)
cls
set UserInput=
echo File  View  Go  Help
echo �  ���������ͻ  �
echo � Explore    ���������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo � Find       �               � ��� ��home��� %username% �
echo ������������ĺ%username:~3%!Sidebar_Space!� ���ͼ���������!Sidebar_Borders!�
echo � Copy       �               �
echo � Move       �               � �!CurPathSpace_Borders!�!Line_Borders!�
echo � Rename     �               � �!cd!�!CurPathSpace_Space!�
echo � Cut!Cut!  �sh             � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo � Delete     �               � �    !LineA_%CurrentPage%_1!�
echo ������������ĺ               � �    !LineB_%CurrentPage%_1!�
echo � New        �               � �    !LineB_%CurrentPage%_1!�
echo ������������ĺktop           � �    !LineC_%CurrentPage%_1!�
echo � Properties �               � �    !Line_Space!�
echo ������������ĺ               � �!FolderDisplayLine_%CurrentPage%_1!    �
echo � Close      ����������������� �    !Line_Space!�
echo ������������ͼe�system�������� �    !Line_Space!�
echo ������������������������������ �    !LineA_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineC_%CurrentPage%_2!�
echo �                            � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_2!    �
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
FOR /L %%G IN (3,1,!LineMaximum_Folder!) DO call :Algorithm_LineWriter_Folder %CurrentPage% %%G
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "F" goto :StartDisplay_Folder
if /i "!UserInput!" == "File" goto :StartDisplay_Folder
if /i "!UserInput!" == "Explore" (
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	set /p UserInput=Change directory to: 
	set UserInput=!UserInput:"=!
	if exist "!UserInput!" (cd /D "!UserInput!") ELSE (
		echo The directory does not exist. Make sure to type it correctly.
		pause
		goto :StartDisplay_File
	)
	goto :Initializer
)
if /i "!UserInput!" == "Find" goto :Find
if /i "!UserInput!" == "Copy" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	set /p Copy=Folder to copy: 
	set /p To=Copy to: 
	set Copy=!Copy:"=!
	set To=!To:"=!
	if exist "!Copy!" (xcopy /S /E /I /H /R /K /O /X /-Y "!Copy!" "!To!") ELSE (
		echo The folder does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Move" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	set /p Move=Folder to move: 
	set /p To=Move to: 
	set Move=!Move:"=!
	set To=!To:"=!
	if exist "!Move!" (move /-Y "!Move!" "!To!") ELSE (
		echo The folder does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)
if /i "!UserInput!" == "Rename" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	:: "Move" is used in this case to allow to overwrite an existing file.
	set /p Move=Folder to rename: 
	set /p To=Rename to: 
	set Move=!Move:"=!
	set To=!To:"=!
	if exist "!Move!" (move /-Y "!Move!" "!To!") ELSE (
		echo The folder does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)
if /i "!UserInput!" == "Cut" (
	if not "!UniversalCut!" == "" (
		echo You have already cut a file. This file will be lost when cutting another one.
		set /p UserInput=Do you wish to continue? [Y / N] - 
		if not "!UserInput!" == "y" if not "!UserInput!" == "Y" goto :StartDisplay_Folder
		del /F "!temp!\!UniversalCut!" >nul 2>nul
		set UniversalCut=
		echo.
		echo.
	)
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	set /p UniversalCut=Folder to cut: 
	set UniversalCut=!UniversalCut:"=!
	if exist "!UniversalCut!" (move /Y "!UniversalCut!" "!temp!\!UniversalCut!") ELSE (
		echo The folder does not exist. Make sure to type the name correctly.
		pause
	)
	goto :Initializer
)
if /i "!UserInput!" == "Paste" (
	if not "!UniversalCut!" == "" (copy /-Y "!temp!\!UniversalCut!" "!UniversalCut!") ELSE (
		echo You have no file cut, yet.
		pause
	)
	goto :Initializer
)
if /i "!UserInput!" == "Delete" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /AD /D
	echo.
	set /p Delete=Folder to delete: 
	set Delete=!Delete:"=!
	if exist "!Delete!" (RD /S /Q "!Delete!") ELSE (
		echo The folder does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)
if /i "!UserInput!" == "New" goto :New_Folder
if /i "!UserInput!" == "Properties" goto :Properties_Folder
if /i "!UserInput!" == "Close" (
	set /p UserInput=Are you sure you want to close the batch explorer? [Y / N] - 
	if /i "!UserInput!" == "Y" exit
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
goto :Menu_File_SentFromFolders






 :New_Folder
:New_Folder
:: Reset variables to prevent unwanted effect
set Filename=
set Error_New=
set Overwrite_File=

echo.
set /p Filename=Enter the folder's name here: 

if "%Filename%" == "" goto :StartDisplay_Folder
:: ERROR-Fix: Custom error message in case of impossible character usage like /, :, ?, " etc.
::			  It also checks if the file already exists to prevent unwanted overwriting.
	set Filename=%Filename:"=%
	echo %Filename% | find "\" >nul 2>nul && set Error_New=1
	echo %Filename% | find "/" >nul 2>nul && set Error_New=1
	echo %Filename% | find ":" >nul 2>nul && set Error_New=1
	echo %Filename% | find "*" >nul 2>nul && set Error_New=1
	echo %Filename% | find "?" >nul 2>nul && set Error_New=1
	echo %Filename% | find "<" >nul 2>nul && set Error_New=1
	echo %Filename% | find ">" >nul 2>nul && set Error_New=1
	echo %Filename% | find "|" >nul 2>nul && set Error_New=1
	if "!Error_New!" == "1" (
		echo A folder's name must not contain the following characters:
		:: You can leave <, > and | in the ECHO-command below as they are because of the single "
		echo \ / : * ? " < > |
		echo.
		pause
		goto :New_Folder
	)
	if exist "%Filename%" (
		echo The folder does already exist. Do you want to overwrite it? [Y / N]
		set /p Overwrite_File=
		if not "!Overwrite_File!" == "Y" if not "!Overwrite_File!" == "y" (
			echo.
			echo The folder has not been overwritten.
			pause
			goto :StartDisplay_Folder
		)
	)
:: END of Error-Fix
	
md "%Filename%" || (
	echo There was an unknown error caused. Please try it again.
	pause
	echo.
	echo.
	goto :New_Folder
)

goto :Initializer






 :Properties_Folder
:Properties_Folder
:: Reset variables to prevent unwanted effect
setlocal EnableDelayedExpansion

echo.
echo.
echo Whose properties do you want to view?
set /p Filename=-^> 
set Filename=%Filename:"=%
set Filename=%Filename:/=\%
if "%Filename:~1,2%" == ".\" set Filename=%Filename:~0,1%:\%Filename:~3%
:: ERROR-Fix: Check if folder does exist
	if not exist "%Filename%" (
		echo.
		echo The folder does not exist. Please make sure to type its name correctly.
		pause
		endlocal
		goto :StartDisplay_Folder
	)
:: END of Error-Fix


echo.
echo.


:: Generating properties
	:: File size, location and content
		FOR /F "delims=" %%A IN ("%Filename%") DO (
			set Directory=%%~dpA
			set FileNameOnly=%%~nxA
		)
		:: ERROR-Fix: If the user enters a drive only, the location would equal the drive and the FileNameOnly would be nothing.
		if /i "!Directory!" == "%Filename%" (
			set Directory=My Computer
			set FileNameOnly=%Filename%
		)
		if "!Directory!" == "" FOR /F "delims=" %%A IN ('cd') DO set Directory=%%~A
		echo Foldername:    %FileNameOnly%
		echo File type:     Folder
		echo ����������������������������������
		echo Location:      !Directory!
		
		:: ERROR-Fix: A number greater than 2147483647 is not allowed in CMD. To pass this by, the program
		::            uses a variable called "Difference" and one called "PreviousFileSize".
		::            2147483647 = (2^31) - 1 =~ 2 GB
		:: The "SET /P"-command is used to allow an instant output of the file size, BS = Backspace
		set GB=
		FOR /F "delims=" %%A IN ('dir /A-D /B /S "%Filename%" 2^>nul') DO (
			set /a TemporaryCalc=%%~zA 2>nul || set Folder_GTR=Greater than 
			set /p ".=File size:     !Folder_GTR!!GB!!GB_Addition!!FileSize! bytes   " <nul
			set /a FileSize=!FileSize! + %%~zA 2>nul
			set /a Difference=2147483647 - !FileSize!
			if "!Difference:~0,1!" == "-" (
				if "!GB!" == "28" set PreviousFileSize=32212254705
				if "!GB!" == "26" set PreviousFileSize=30064771058
				if "!GB!" == "24" set PreviousFileSize=27917287411
				if "!GB!" == "22" set PreviousFileSize=25769803764
				if "!GB!" == "20" set PreviousFileSize=23622320117
				if "!GB!" == "18" set PreviousFileSize=21474836470
				if "!GB!" == "16" set PreviousFileSize=19327352823
				if "!GB!" == "14" set PreviousFileSize=17179869176
				if "!GB!" == "12" set PreviousFileSize=15032385529
				if "!GB!" == "10" set PreviousFileSize=12884901882
				if "!GB!" == "8" set PreviousFileSize=10737418235
				if "!GB!" == "6" set PreviousFileSize=8589934588
				if "!GB!" == "4" set PreviousFileSize=6442450941
				if "!GB!" == "2" set PreviousFileSize=4294967294
				if "!GB!" == "" set PreviousFileSize=2147483647
				set /a FileSize=!Difference:~1!
				set /a GB=!GB! + 2
				set GB_Addition= GB + 
			)
			:: Placed here to optimize the speed
			set /a Folder_FileAmount=!Folder_FileAmount! + 1
		)
		
		
		:: Manual calculation (addition) of two numbers. the "SET /A"-command does only work up to 2147483647. Any further produces errors.
		:: The addition works backwards. Add the last two numbers, then the previous last ones and so on. Attend sums greater than 10.
		:: %Digit1% is the last digit, %Digit11% is the very first digit.
		if not "!PreviousFileSize!" == "" FOR /L %%A IN (1,1,11) DO (
			set /a TemporaryCalc=%%A - 1
			FOR %%B IN (!TemporaryCalc!) DO (
				if not "!PreviousFileSize:~%%B,1!" == "" (
					if not "!FileSize:~%%B,1!" == "" (set /a Digit%%A=!Digit%%A! + !PreviousFileSize:~-%%A,1! + !FileSize:~-%%A,1!) ELSE (set /a Digit%%A=!Digit%%A! + !PreviousFileSize:~-%%A,1!)
				) ELSE (set Digit%%A=!Digit%%A!)
			)
			set /a Differenz=9 - !Digit%%A! 2>nul
			if "!Differenz:~0,1!" == "-" (
				set /a Digit%%A=!Digit%%A! - 10
				set /a TemporaryCalc=%%A + 1
				set Digit!TemporaryCalc!=1
			)
		)
		if "!FileSize!" == "" set FileSize=0
		set FileSizePuffer=!FileSize!
		if not "!PreviousFileSize!" == "" set FileSize=
		if not "!PreviousFileSize!" == "" FOR /L %%A IN (11,-1,1) DO set FileSize=!FileSize!!Digit%%A!
		if "!FileSize!" == "" set FileSize=0
		
		set SizeType= MB 
		set /a TemporaryCalc=!FileSizePuffer! / 1048576
		if "!TemporaryCalc!" == "0" (
			set SizeType= KB 
			set /a TemporaryCalc=!FileSizePuffer! / 1024
		)
		if "!TemporaryCalc!" == "0" (
			set SizeType=
			set TemporaryCalc=
		)
		if "!SizeType!" == " MB " (
			set /a Difference=1023 - !TemporaryCalc!
			if not "!GB_Addition!" == "" set Enable_GB=1
			if "!Difference:~0,1!" == "-" set Enable_GB=1
			if "!Enable_GB!" == "1" (
				if "!Difference:~0,1!" == "-" (
					set /a GB=!GB! + 1
					set /a TemporaryCalc=!TemporaryCalc! - 1024
				)
				set /a TemporaryCalc=!TemporaryCalc! * 100 / 1024
				set /a Difference=!TemporaryCalc! - 10
				:: This IF-command is used to allow an output like "3.01 GB" which would be "3.1 GB" without this command.
				if "!Difference:~0,1!" == "-" set TemporaryCalc=0!TemporaryCalc!
				set GB=!GB!,!TemporaryCalc!
				set TemporaryCalc=
				set SizeType= GB 
			)
		)
		set FileSize=!Folder_GTR!!GB!!TemporaryCalc!!SizeType!(!FileSize! Bytes)            
		echo File size:     !FileSize!
	
		FOR /F "delims=" %%A IN ('dir /AD /B /S "%Filename%" 2^>nul') DO (
			set /a Folder_FolderAmount=!Folder_FolderAmount! + 1
			set /p ".=Content:       !Folder_FolderAmount! folders" <nul
		)
		if "!Folder_FolderAmount!" == "" set Folder_FolderAmount=0
		if "!Folder_FileAmount!" == "" set Folder_FileAmount=0
		set FolderContent=!Folder_FolderAmount! folders, !Folder_FileAmount! files
		echo Content:       !FolderContent!
		
	:: Date generation
		:: /T:C = Created
		:: /T:W = Write access (changed)
		:: /T:A = Last access (started)
		if not "!Directory!" == "My Computer" (
			FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:C "!Directory!"') DO if "%%~C" == "!FileNameOnly!" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set CreationDate=On %%A at %%B
			FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:W "!Directory!"') DO if "%%~C" == "!FileNameOnly!" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set WriteAccess=On %%A at %%B
			FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:A "!Directory!"') DO if "%%~C" == "!FileNameOnly!" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set LastAccess=On %%A at %%B
		)
	:: Attributes
		:: These attributes are based on Windows XP. Indication, compression and encryption are missing.
		FOR /F "delims=" %%A IN ('attrib "%Filename%"') DO set AttributeList=%%A
		set AttributeList=!AttributeList:~0,10!
		echo "!AttributeList!" | find "A" >nul 2>nul && set Attributes=Archivable, 
		echo "!AttributeList!" | find "S" >nul 2>nul && set Attributes=!Attributes!systemfile, 
		echo "!AttributeList!" | find "H" >nul 2>nul && set Attributes=!Attributes!hidden, 
		echo "!AttributeList!" | find "R" >nul 2>nul && set Attributes=!Attributes!read-only, 
		echo "!AttributeList!" | find "I" >nul 2>nul && set Attributes=!Attributes!indicated, 
		echo "!AttributeList!" | find "C" >nul 2>nul && set Attributes=!Attributes!compressed, 
		echo "!AttributeList!" | find "E" >nul 2>nul && set Attributes=!Attributes!encrypted, 
		set Attributes=!Attributes:~0,-2!
	
	:: Complete incomplete variables
		if "!Directory!" == ""        set Directory=ERROR
		if "!FileSize!" == "( Bytes)"  set FileSize=Unknown
		if "!CreationDate!" == ""  set CreationDate=Unknown
		if "!WriteAccess!" == ""    set WriteAccess=Unknown
		if "!LastAccess!" == ""      set LastAccess=Unknown
		if "!Attributes!" == ""      set Attributes=---
		if "!Attributes!" == "~0,-2" set Attributes=---

:: END of generating properties

:: Rest of output
:: Tip: To view the other output, mark an ECHO-command
echo ����������������������������������
echo Creation date: !CreationDate!
echo Last changed:  !WriteAccess!
echo Last access:   !LastAccess!
echo ����������������������������������
echo Attributes:    !Attributes!
echo.
echo.
pause
endlocal
goto :StartDisplay_Folder





REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_View_SentFromFolders
:Menu_View_SentFromFolders
:: FreeCols is an exception. It should usually be in :Check_WindowSettings, but it might be
:: confusing to have all settings at one place being responsible for many different things.
:: As the variable is only local (for this label), I decided to make an exception.
set Counter=0
set UserInput=
set /a FreeCols=!Cols! - 6
set /a TemporaryCalc=!Cols! - 12
cls
echo File  View  Go  Help
set /p ".=�����ͼ  �" <nul

FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
echo �
FOR /F "delims=" %%A IN ('dir /AD /B 2^>nul') DO (
	set /a Counter=!Counter! + 1
	set FilePath!Counter!=%%~fA
)

FOR /L %%A IN (1,1,!Counter!) DO if not "!FilePath%%A:~%FreeCols%,1!" == "" FOR /F "delims=" %%R IN ("!FilePath%%A!") DO set FilePath%%A=%%~sdpR%%~nxR
FOR /L %%A IN (1,1,!Counter!) DO FOR /L %%B IN (1,1,!FreeCols!) DO if "!FilePath%%A:~%%B,1!" == "" set FilePath%%A=!FilePath%%A! 
FOR /L %%A IN (1,1,!Counter!) DO echo � !FilePath%%A! �

set /p ".=����������" <nul
FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
echo �
echo.
set /p UserInput=� 
if /i "!UserInput!" == "V" goto :StartDisplay_Folder
if /i "!UserInput!" == "View" goto :StartDisplay_Folder
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
pause
goto :StartDisplay_Folder





REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_Go_SentFromFolders
:Menu_Go_SentFromFolders
cls
set UserInput=
echo File  View  Go  Help
echo �     �   �ͼ���������ͻ
echo ���������ĺ User       �����Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���   � Trash      �     � ��� ��home��� %username% �
echo �   [ ]   � Desktop    �     � ���ͼ���������!Sidebar_Borders!�
echo �   ���   � File system�     �
echo �         ������������͹     � �!CurPathSpace_Borders!�!Line_Borders!�
echo �   -^>    � 1 folder up�     � �!cd!�!CurPathSpace_Space!�
echo �       ������������ͼ     � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo �   �                       � �    !LineA_%CurrentPage%_1!�
echo �                            � �    !LineB_%CurrentPage%_1!�
echo � �����Ŀ                    � �    !LineB_%CurrentPage%_1!�
echo � �     �  Desktop           � �    !LineC_%CurrentPage%_1!�
echo � �������                    � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_1!    �
echo ������������������������������ �    !Line_Space!�
echo �����������File�system�������� �    !Line_Space!�
echo ������������������������������ �    !LineA_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineC_%CurrentPage%_2!�
echo �                            � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_2!    �
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
FOR /L %%G IN (3,1,!LineMaximum_Folder!) DO call :Algorithm_LineWriter_Folder %CurrentPage% %%G
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "G" goto :StartDisplay_Folder
if /i "!UserInput!" == "Go" goto :StartDisplay_Folder
if /i "!UserInput!" == "User" (
	cd /D %userprofile%
	goto :Initializer
)
if /i "!UserInput!" == "Trash" goto :Initializer_Trash
if /i "!UserInput!" == "Desktop" goto :Initializer_Desktop
if /i "!UserInput!" == "File system" goto :Initializer_FileSystem
if /i "!UserInput!" == "1 folder up" (
	cd..
	goto :Initializer
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
goto :Menu_Go_SentFromFolders





REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_Help_SentFromFolders
:Menu_Help_SentFromFolders
:: ERROR-Fix: Remove spaces in case the current directory has less than 6 letters
	set TempHelper=
	if "!cd:~3,1!" == "" set TempHelper=:~3
	if "!cd:~3,1!" == "~3,1" set TempHelper=:~3
:: End of Error-Fix

cls
set UserInput=
echo File  View  Go  Help
echo �     �     � �ͼ  �����������������ͻ
echo �������������ĺ Batch online         ���Ŀ���!Sidebar_Borders!�
echo �   ���       � Commands             �ome��� %username% �
echo �   [ ]    %username:~0,3%� Helpcenter           ��������!Sidebar_Borders!�
echo �   ���       � Window settings      �
echo �             ����������������������͹!CurPathSpace_Borders:~6!�!Line_Borders%TempHelper%!�
echo �   -^>        � About Batch Explorer �!cd:~6!�!CurPathSpace_Space%TempHelper%!�
echo �        Tra����������������������ͼ!CurPathSpace_Borders:~6!�!CurPathSpace_Space%TempHelper%!�
echo �   �                       � �    !LineA_%CurrentPage%_1!�
echo �                            � �    !LineB_%CurrentPage%_1!�
echo � �����Ŀ                    � �    !LineB_%CurrentPage%_1!�
echo � �     �  Desktop           � �    !LineC_%CurrentPage%_1!�
echo � �������                    � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_1!    �
echo ������������������������������ �    !Line_Space!�
echo �����������File�system�������� �    !Line_Space!�
echo ������������������������������ �    !LineA_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineB_%CurrentPage%_2!�
echo �                            � �    !LineC_%CurrentPage%_2!�
echo �                            � �    !Line_Space!�
echo �                            � �!FolderDisplayLine_%CurrentPage%_2!    �
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
FOR /L %%G IN (3,1,!LineMaximum_Folder!) DO call :Algorithm_LineWriter_Folder %CurrentPage% %%G
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "H" goto :StartDisplay_Folder
if /i "!UserInput!" == "Help" goto :StartDisplay_Folder
if /i "!UserInput!" == "Batch online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Commands" (
	call :CommandList
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Helpcenter" (
	call :Help
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Window settings" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "Window" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "Settings" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "About" (
	call :About
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "About Batch Explorer" (
	call :About
	goto :StartDisplay_Folder
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
goto :Menu_Help_SentFromFolders







REM ==================================================================================================================================
REM ==================================================================================================================================





 :StartDisplay_File
:StartDisplay_File
cls
set UserInput=
echo File  Edit  View  Go  Help
echo �     �     �     �   �
echo ����������������������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���                      � ��� ��home��� %username% �
echo �   [ ]    %username%!Sidebar_Space!� ���ͼ���������!Sidebar_Borders!�
echo �   ���                      �
echo �                            � �!CurPathSpace_Borders!�!Line_Borders!�
echo �   -^>                       � �!cd!�!CurPathSpace_Space!�
echo �        Trash             � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo �   �                       � �   Filename!TableHeaderSpace_1!Extension!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �!LineF_%CurrentPage%_1!�
echo � �     �  Desktop           � �!LineF_%CurrentPage%_2!�
echo � �������                    � �!LineF_%CurrentPage%_3!�
echo �                            � �!LineF_%CurrentPage%_4!�
echo ������������������������������ �!LineF_%CurrentPage%_5!�
echo �����������File�system�������� �!LineF_%CurrentPage%_6!�
echo ������������������������������ �!LineF_%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �!LineF_%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "F" goto :Menu_File_SentFromFiles
if /i "!UserInput!" == "File" goto :Menu_File_SentFromFiles
if /i "!UserInput!" == "E" goto :Menu_Edit_SentFromFiles
if /i "!UserInput!" == "Edit" goto :Menu_Edit_SentFromFiles
if /i "!UserInput!" == "V" goto :Menu_View_SentFromFiles
if /i "!UserInput!" == "View" goto :Menu_View_SentFromFiles
if /i "!UserInput!" == "G" goto :Menu_Go_SentFromFiles
if /i "!UserInput!" == "Go" goto :Menu_Go_SentFromFiles
if /i "!UserInput!" == "H" goto :Menu_Help_SentFromFiles
if /i "!UserInput!" == "Help" goto :Menu_Help_SentFromFiles
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
pause
goto :StartDisplay_File




REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_File_SentFromFiles
:Menu_File_SentFromFiles
if "!UniversalCut!" == "" (set Cut=      ) ELSE (set Cut=/Paste)
cls
set UserInput=
echo File  Edit  View  Go  Help
echo �  �����������ͻ  �   �
echo � Open         �������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo � Open with...��             � ��� ��home��� %username% �
echo � Find         �             � ���ͼ���������!Sidebar_Borders!�
echo ��������������ĺ             �
echo � Copy         �             � �!CurPathSpace_Borders!�!Line_Borders!�
echo � Move         �             � �!cd!�!CurPathSpace_Space!�
echo � Rename       �             � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo � Cut!Cut!    �             � �   Filename!TableHeaderSpace_1!Extension!TableHeaderSpace_2!�
echo � Delete       �             � �    !Line_Space!�
echo ��������������ĺ             � �!LineF_%CurrentPage%_1!�
echo � New         ��op           � �!LineF_%CurrentPage%_2!�
echo ��������������ĺ             � �!LineF_%CurrentPage%_3!�
echo � Properties   �             � �!LineF_%CurrentPage%_4!�
echo ��������������ĺ�������������� �!LineF_%CurrentPage%_5!�
echo � Close        �system�������� �!LineF_%CurrentPage%_6!�
echo ��������������ͼ�������������� �!LineF_%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �!LineF_%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "F" goto :StartDisplay_File
if /i "!UserInput!" == "File" goto :StartDisplay_File
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Open" (
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	set /p UserInput=Open file: 
	FOR /F "delims=" %%A IN ("!UserInput!") DO set UserInput=%%~sA
	start /min cmd /c start !UserInput!
	goto :StartDisplay_File
)
if /i "!UserInput!" == "OpenWith" goto :OpenWith
if /i "!UserInput!" == "Open with" goto :OpenWith
if /i "!UserInput!" == "Open with..." goto :OpenWith
if /i "!UserInput!" == "Find" goto :Find
if /i "!UserInput!" == "Copy" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	set /p Copy=File to copy: 
	set /p To=Copy to: 
	set Copy=!Copy:"=!
	set To=!To:"=!
	if exist "!Copy!" (copy /-Y "!Copy!" "!To!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Move" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	set /p Move=File to move: 
	set /p To=Move to: 
	set Move=!Move:"=!
	set To=!To:"=!
	if exist "!Move!" (move /-Y "!Move!" "!To!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)
if /i "!UserInput!" == "Rename" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	:: "Move" is used in this case to allow to overwrite an existing file.
	set /p Move=File to rename: 
	set /p To=Rename to: 
	set Move=!Move:"=!
	set To=!To:"=!
	if exist "!Move!" (move /-Y "!Move!" "!To!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)
if /i "!UserInput!" == "Cut" (
	if not "!UniversalCut!" == "" (
		echo You have already cut a file. This file will be lost when cutting another one.
		set /p UserInput=Do you wish to continue? [Y / N] - 
		if not "!UserInput!" == "y" if not "!UserInput!" == "Y" goto :StartDisplay_File
		del /F "!temp!\!UniversalCut!" >nul 2>nul
		set UniversalCut=
		echo.
		echo.
	)
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	set /p UniversalCut=File to cut: 
	set UniversalCut=!UniversalCut:"=!
	if exist "!UniversalCut!" (move /Y "!UniversalCut!" "!temp!\!UniversalCut!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	goto :Initializer
)
if /i "!UserInput!" == "Paste" (
	if not "!UniversalCut!" == "" (copy /-Y "!temp!\!UniversalCut!" "!UniversalCut!") ELSE (
		echo You have no file cut, yet.
		pause
	)
	goto :Initializer
)
if /i "!UserInput!" == "Delete" (
	setlocal enabledelayedexpansion
	set /a TemporaryCalc=!Cols! - 90
	if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
	echo.
	set /p Delete=File to delete: 
	set Delete=!Delete:"=!
	if exist "!Delete!" (del /A /P "!Delete!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
	goto :Initializer
)

if /i "!UserInput!" == "New" goto :New_File
if /i "!UserInput!" == "Properties" goto :Properties_File
if /i "!UserInput!" == "Close" (
	set /p UserInput=Are you sure you want to close the batch explorer? [Y / N] - 
	if /i "!UserInput!" == "Y" exit
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
goto :Menu_File_SentFromFiles






 :OpenWith
:OpenWith
:: Reset variables to prevent unwanted effect
set OpenWith=
set FileOpen=

echo.
set /p OpenWith=Open with (exe-file): 
set /p FileOpen=File to open:         

:: ERROR-FIX: Check if the file exists. If not, the program returns to main menu
set FileOpen=!FileOpen:"=!
if not exist "!FileOpen!" (
	echo The mentioned file does not exist. To view the full file names, use the
	echo "View"-function from the menu.
	pause
	goto :StartDisplay_File
)

:: Check for most common programs
	echo !OpenWith! | find /i "Office Word" >nul 2>nul && set OpenWith=WinWord
	echo !OpenWith! | find /i "Office Excel" >nul 2>nul && set OpenWith=Excel
	echo !OpenWith! | find /i "Office PowerPoint" >nul 2>nul && set OpenWith=PowerPnt
	echo !OpenWith! | find /i "Office OneNote" >nul 2>nul && set OpenWith=OneNote
	echo !OpenWith! | find /i "Windows Media Player" >nul 2>nul && set OpenWith=WMPlayer
	echo !OpenWith! | find /i "Windows Movie Maker" >nul 2>nul && set OpenWith=MovieMk
	if /i "!OpenWith!" == "Paint" set OpenWith=MsPaint
:: End

:: Start the file via an extra CMD-window (minimized, closes when start was successful)
:: This way, the Batch Explorer does not stop if the command was not successful.
start /min cmd /c start %OpenWith% "%FileOpen%"

goto :StartDisplay_File







 :Find
:Find
:: Reset variables to prevent unwanted effect
set UserChoice=
set Filename=
set ContentOfFile=
set Search=
set ExtraOptCaseSensitive=
set ExtraOptHiddenFiles=
cls
echo ��������������������������ͻ
echo �What are you looking for? �
echo �1: Filename               �
echo �2: Content of a file      �
echo ��������������������������ͼ
set /p UserChoice=Number: 
echo.
if "%UserChoice%" == "1" set /p Filename=All or part of the file name: 
if "%UserChoice%" == "2" set /p ContentOfFile=Single term inside the file: 
set /p Search=Search in: 

:: ERROR-Fix: If "Search" is not defined, it will be set to the current directory.
::			  If the last character is "\", it will be removed.
::			  If the user forgot the ":" behind the drive letter, it will be added.
	if "%Search%" == "" FOR /F "delims=" %%A IN ('cd') DO set Search=%%A
	if "%Search:~-1,1%" == "\" set Search=%Search:~0,-1%
	if not "%Search:~1,1%" == ":" set Search=%Search:~0,1%:%Search:~1%

echo.

:: Ask if to look for hidden files, too (in case of searching for filenames)
	if "%UserChoice%" == "1" set /p ExtraOptHiddenFiles=Include hidden files? (Y / N) - 
	if /i "%ExtraOptHiddenFiles%" == "Y" (set ExtraOptHiddenFiles=/A) ELSE (set ExtraOptHiddenFiles=)

:: Ask if to ignore case-sensitive (in case of searching file contents)
	if "%UserChoice%" == "2" set /p ExtraOptCaseSensitive=Ignore case-sensitive? (Y / N) - 
	if /i "%ExtraOptCaseSensitive%" == "Y" (set ExtraOptCaseSensitive=/I) ELSE (set ExtraOptCaseSensitive=)
	
echo.
echo.
if "%UserChoice%" == "1" dir !ExtraOptHiddenFiles! /B /S "%Search%\*!Filename!*"
if "%UserChoice%" == "2" findstr !ExtraOptCaseSensitive! /M /S /C:"!ContentOfFile!" "%Search%\*.*"

pause >nul
goto :StartDisplay_!Display!





 :New_File
:New_File
:: Reset variables to prevent unwanted effect
set Filename=
set Error_New=
set Overwrite_File=

echo.
set /p Filename=Enter the filename here: 

:: ERROR-Fix: Custom error message in case of impossible character usage like /, :, ?, " etc.
::			  It also checks if the file already exists to prevent unwanted overwriting.
	set Filename=%Filename:"=%
	echo %Filename% | find "\" >nul 2>nul && set Error_New=1
	echo %Filename% | find "/" >nul 2>nul && set Error_New=1
	echo %Filename% | find ":" >nul 2>nul && set Error_New=1
	echo %Filename% | find "*" >nul 2>nul && set Error_New=1
	echo %Filename% | find "?" >nul 2>nul && set Error_New=1
	echo %Filename% | find "<" >nul 2>nul && set Error_New=1
	echo %Filename% | find ">" >nul 2>nul && set Error_New=1
	echo %Filename% | find "|" >nul 2>nul && set Error_New=1
	if "!Error_New!" == "1" (
		echo A filename must not contain the following characters:
		:: You can leave <, > and | in the ECHO-command below as they are because of the single "
		echo \ / : * ? " < > |
		echo.
		pause
		goto :New_File
	)
	if exist "%Filename%" (
		echo The file does already exist. Do you want to overwrite it? [Y / N]
		set /p Overwrite_File=
		if not "!Overwrite_File!" == "Y" if not "!Overwrite_File!" == "y" (
			echo.
			echo The file has not been overwritten.
			pause
			goto :StartDisplay_File
		)
	)
:: END of Error-Fix
	
echo off>"%Filename%" 2>nul || (
	echo There was an unknown error caused. Please try it again.
	pause
	echo.
	echo.
	goto :New_File
)

goto :Initializer





 :Properties_File
:Properties_File
:: Properties: Use the DIR-command, the ATTRIB-command etc. to generate property list.
:: Reset variables to prevent unwanted effect
set Type=
set Filename=
set FileSize=
set FileType=
set SizeType=
set OpenWith=
set Directory=
set Attributes=
set LastAccess=
set WriteAccess=
set CreationDate=
set AttributeList=
set TemporaryCalc=

echo.
set /a TemporaryCalc=!Cols! - 90
if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
set TemporaryCalc=
echo.
echo Whose properties do you want to view?
set /p Filename=-^> 
set Filename=%Filename:"=%
:: ERROR-Fix: Check if file does exist
	if not exist "%Filename%" (
		echo.
		echo The file does not exist. Please make sure to type its name correctly.
		pause
		goto :StartDisplay_File
	)
:: END of Error-Fix

:: Generating properties
	:: File Extension (e.g. ".txt")
		FOR /F "delims=" %%A IN ("%Filename%") DO set FileExtension=%%~xA
	:: File type (e.g. "txtfile")
		FOR /F "tokens=2 delims==" %%A IN ('assoc !FileExtension! 2^>nul') DO set Type=%%A
		FOR /F "skip=4 tokens=3,*" %%A IN ('reg query "HKCR\!Type!" /ve') DO set FileType=%%B
		if not "!Type!" == "" FOR /F "delims=" %%A IN ("reg.exe") DO if not exist "%%~$PATH:A" FOR /F "skip=4 tokens=3,*" %%A IN ('"reg query "HKCR\!Type!" /ve 2>nul"') DO set FileType=%%B
	:: Open with (e.g. "notepad")
		:: IF-command in case of executables to change {%1" %*} to {"%1" %*} (adding a quotation mark to make it look better)
		if not "!FileType!" == "" FOR /F "tokens=2 delims==" %%A IN ('ftype !Type! 2^>nul') DO (
			set OpenWith=%%~nA
			if "!OpenWith:~0,2!,!OpenWith:~3!" == "%%1, %%*" set OpenWith="!OpenWith!
		)
	:: File size and location
		FOR /F "delims=" %%A IN ("%Filename%") DO (
			set Directory=%%~dpA
			set FileSize=%%~zA
		)
		set SizeType= MB 
		set /a TemporaryCalc=!FileSize! / 1048576
		if "!TemporaryCalc!" == "0" (
			set SizeType= KB 
			set /a TemporaryCalc=!FileSize! / 1024
		)
		if "!TemporaryCalc!" == "0" (
			set SizeType=
			set TemporaryCalc=
		)
		set FileSize=!TemporaryCalc!!SizeType!(!FileSize! Bytes)
	:: Date generation
		:: /T:C = Created
		:: /T:W = Write access (changed)
		:: /T:A = Last access (started)
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:C') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set CreationDate=On %%A at %%B
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:W') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set WriteAccess=On %%A at %%B
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:A') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set LastAccess=On %%A at %%B
	:: Attributes
		:: These attributes are based on Windows XP. Indication, compression and encryption are missing.
		:: It is funny that you can build "CrashIE" by ordering the attribute's letters =)
		FOR /F "delims=" %%A IN ('attrib %Filename%') DO set AttributeList=%%A
		set AttributeList=!AttributeList:~0,10!
		echo !AttributeList! | find "A" >nul 2>nul && set Attributes=Archivable, 
		echo !AttributeList! | find "S" >nul 2>nul && set Attributes=!Attributes!systemfile, 
		echo !AttributeList! | find "H" >nul 2>nul && set Attributes=!Attributes!hidden, 
		echo !AttributeList! | find "R" >nul 2>nul && set Attributes=!Attributes!read-only, 
		echo !AttributeList! | find "I" >nul 2>nul && set Attributes=!Attributes!indicated, 
		echo !AttributeList! | find "C" >nul 2>nul && set Attributes=!Attributes!compressed, 
		echo !AttributeList! | find "E" >nul 2>nul && set Attributes=!Attributes!encrypted, 
		set Attributes=!Attributes:~0,-2!
	
	:: Complete incomplete variables
		if "!FileType!" == "" if "!FileExtensions!" == "" (set FileType=File) ELSE (set FileType=!FileExtension!-File)
		if "!OpenWith!" == ""          set OpenWith=Unknown
		if "!Directory!" == ""        set Directory=ERROR
		if "!FileSize!" == "( Bytes)"  set FileSize=Unknown
		if "!CreationDate!" == ""  set CreationDate=Unknown
		if "!WriteAccess!" == ""    set WriteAccess=Unknown
		if "!LastAccess!" == ""      set LastAccess=Unknown
		if "!Attributes!" == ""      set Attributes=---
		if "!Attributes!" == "~0,-2" set Attributes=---
		
:: END of generating properties

:: Output
echo.
echo.
echo Filename:      !Filename!
echo File type:     !FileType!
echo Open with:     !OpenWith!
echo ����������������������������������
echo Location:      !Directory!
echo File size:     !FileSize!
echo ����������������������������������
echo Creation date: !CreationDate!
echo Last changed:  !WriteAccess!
echo Last access:   !LastAccess!
echo ����������������������������������
echo Attributes:    !Attributes!
echo.
echo.
pause
goto :StartDisplay_File


REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_Edit_SentFromFiles
:Menu_Edit_SentFromFiles
if exist "%ProgramFiles%\Notepad++" (set Editor=Notepad++) ELSE (set Editor=         )
cls
set UserInput=
echo File  Edit  View  Go  Help
echo �     �  �����������ͻ�
echo �����ĺ Notepad      �������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   �ܺ MS-Dos Editor�       � ��� ��home��� %username% �
echo �   [ � !Editor!    �       � ���ͼ���������!Sidebar_Borders!�
echo �   ����������������ͼ       �
echo �                            � �!CurPathSpace_Borders!�!Line_Borders!�
echo �   -^>                       � �!cd!�!CurPathSpace_Space!�
echo �        Trash             � �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo �   �                       � �   Filename!TableHeaderSpace_1!Extension!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �!LineF_%CurrentPage%_1!�
echo � �     �  Desktop           � �!LineF_%CurrentPage%_2!�
echo � �������                    � �!LineF_%CurrentPage%_3!�
echo �                            � �!LineF_%CurrentPage%_4!�
echo ������������������������������ �!LineF_%CurrentPage%_5!�
echo �����������File�system�������� �!LineF_%CurrentPage%_6!�
echo ������������������������������ �!LineF_%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �!LineF_%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "E" goto :StartDisplay_File
if /i "!UserInput!" == "Edit" goto :StartDisplay_File
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Notepad" (
	call :SubMenu_Edit_SentFromFiles Notepad
	goto :StartDisplay_File
)
if /i "!UserInput!" == "MS-DOS"        goto :SubMenu_Edit_SentFromFiles_MSDOS
if /i "!UserInput!" == "MS-DOS Editor" goto :SubMenu_Edit_SentFromFiles_MSDOS
if /i "!UserInput!" == "Notepad++" (
	call :SubMenu_Edit_SentFromFiles Notepad++
	goto :StartDisplay_File
)
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
goto :Menu_Edit_SentFromFiles


 :SubMenu_Edit_SentFromFiles
:SubMenu_Edit_SentFromFiles
set TemporaryCalc=
echo.
set /a TemporaryCalc=!Cols! - 90
if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
echo.
set UserInput=
set /p UserInput=Please enter the file to open: 
set UserInput=!UserInput:"=!
start /min cmd /c start %1 "!UserInput!"
exit /b



 :SubMenu_Edit_SentFromFiles_MSDOS
:SubMenu_Edit_SentFromFiles_MSDOS
set TemporaryCalc=
echo.
set /a TemporaryCalc=!Cols! - 90
if "!TemporaryCalc:~0,1!" == "-" dir /A-D /D
echo.
echo.
echo NOTE: To return to the Batch Explorer, go to "File > Close" in the editor.
echo.

:: ERROR-Fix: This SETLOCAL-command is needed to expand the local memory. This is necessary for EDIT.COM to open large text documents.
::            The FOR-commands remove all set variables that begin with an F, an L or an R (these are the most used ones by the Batch Explorer).
::            The ENDLOCAL-command reenables the removed variables to make the Explorer work correctly.
setlocal enabledelayedexpansion
	set UserInput=
	set /p UserInput=Please enter the file to open: 
	set UserInput=!UserInput:"=!
	if exist "!UserInput!" (
		FOR /F "delims==" %%A IN ('set ^| findstr "^F" 2^>nul') DO set %%A=
		FOR /F "delims==" %%A IN ('set ^| findstr "^L" 2^>nul') DO set %%A=
		FOR /F "delims==" %%A IN ('set ^| findstr "^R" 2^>nul') DO set %%A=
		edit.com "!UserInput!"
	) ELSE (
		echo The file does not exist. Please make sure to type its name correctly.
	)
endlocal
goto :StartDisplay_File




REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_View_SentFromFiles
:Menu_View_SentFromFiles
:: FreeCols is an exception. It should usually be in :Check_WindowSettings, but it might be
:: confusing to have all settings at one place being responsible for many different things.
:: As the variable is only local (for this label), I decided to make an exception.
set Counter=0
set UserInput=
set /a FreeCols=!Cols! - 6
set /a TemporaryCalc=!Cols! - 18
cls
echo File  Edit  View  Go  Help
set /p ".=�����������ͼ  �" <nul

FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
echo �
FOR /F "delims=" %%A IN ('dir /A-D /B 2^>nul') DO (
	set /a Counter=!Counter! + 1
	set FilePath!Counter!=%%~fA
)

FOR /L %%A IN (1,1,!Counter!) DO if not "!FilePath%%A:~%FreeCols%,1!" == "" FOR /F "delims=" %%R IN ("!FilePath%%A!") DO set FilePath%%A=%%~sdpR%%~nxR
FOR /L %%A IN (1,1,!Counter!) DO FOR /L %%B IN (1,1,!FreeCols!) DO if "!FilePath%%A:~%%B,1!" == "" set FilePath%%A=!FilePath%%A! 
FOR /L %%A IN (1,1,!Counter!) DO echo � !FilePath%%A! �

set /p ".=����������������" <nul
FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
echo �
echo.
set /p UserInput=� 
if /i "!UserInput!" == "V" goto :StartDisplay_File
if /i "!UserInput!" == "View" goto :StartDisplay_File
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
pause
goto :StartDisplay_File




REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_Go_SentFromFiles
:Menu_Go_SentFromFiles
cls
set UserInput=
echo File  Edit  View  Go  Help
echo �     �     �   �ͼ���������ͻ
echo ���������������ĺ User       � ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���         � Trash      � ��� ��home��� %username% �
echo �   [ ]    %username:~0,5%� Desktop    � ���ͼ���������!Sidebar_Borders!�
echo �   ���         � File system�
echo �               ������������͹ �!CurPathSpace_Borders!�!Line_Borders!�
echo �   -^>          � 1 folder up� �!cd!�!CurPathSpace_Space!�
echo �        Trash������������ͼ �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo �   �                       � �   Filename!TableHeaderSpace_1!Extension!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �!LineF_%CurrentPage%_1!�
echo � �     �  Desktop           � �!LineF_%CurrentPage%_2!�
echo � �������                    � �!LineF_%CurrentPage%_3!�
echo �                            � �!LineF_%CurrentPage%_4!�
echo ������������������������������ �!LineF_%CurrentPage%_5!�
echo �����������File�system�������� �!LineF_%CurrentPage%_6!�
echo ������������������������������ �!LineF_%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �!LineF_%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "G" goto :StartDisplay_File
if /i "!UserInput!" == "Go" goto :StartDisplay_File
if /i "!UserInput!" == "User" (
	cd /D %userprofile%
	goto :Initializer
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Trash" goto :Initializer_Trash
if /i "!UserInput!" == "Desktop" goto :Initializer_Desktop
if /i "!UserInput!" == "File system" goto :Initializer_FileSystem
if /i "!UserInput!" == "Renew" goto :Initializer
if /i "!UserInput!" == "1 folder up" (
	cd..
	goto :Initializer
)
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
pause
goto :Menu_Go_SentFromFiles





REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_Help_SentFromFiles
:Menu_Help_SentFromFiles
:: ERROR-Fix: Remove spaces in case the current directory has less than 12 letters
::            Add spaces in case the username has less than 9 letters
	set TempHelper=
	set TempUserHelper=
	FOR /L %%A IN (3,1,9) DO if "!cd:~%%A,1!" == "" set TempHelper=:~%%A
	FOR /L %%A IN (3,1,9) DO if "!cd:~%%A,1!" == "~%%A,1" set TempHelper=:~%%A
	FOR /L %%B IN (8,-1,3) DO if "!username:~%%B,1!" == "" set TempUserHelper=!TempUserHelper! 
	FOR /L %%B IN (8,-1,3) DO if "!username:~%%B,1!" == "~%%B,1" set TempUserHelper=!TempUserHelper! 
:: End of Error-Fix

cls
set UserInput=
echo File  Edit  View  Go  Help
echo �     �     �     � �ͼ  �����������������ͻ
echo �������������������ĺ Batch online         ��!Sidebar_Borders!�
echo �   ���             � Commands             � %username% �
echo �   [ ]    %username:~0,9%!TempUserHelper!� Helpcenter           ��!Sidebar_Borders!�
echo �   ���             � Window settings      �
echo �                   ����������������������͹!CurPathSpace_Borders:~12!�!Line_Borders%TempHelper%!�
echo �   -^>              � About Batch Explorer �!cd:~12!�!CurPathSpace_Space%TempHelper%!�
echo �        Trash    ����������������������ͼ!CurPathSpace_Borders:~12!�!CurPathSpace_Space%TempHelper%!�
echo �   �                       � �   Filename!TableHeaderSpace_1!Extension!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �!LineF_%CurrentPage%_1!�
echo � �     �  Desktop           � �!LineF_%CurrentPage%_2!�
echo � �������                    � �!LineF_%CurrentPage%_3!�
echo �                            � �!LineF_%CurrentPage%_4!�
echo ������������������������������ �!LineF_%CurrentPage%_5!�
echo �����������File�system�������� �!LineF_%CurrentPage%_6!�
echo ������������������������������ �!LineF_%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �!LineF_%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "H" goto :StartDisplay_File
if /i "!UserInput!" == "Help" goto :StartDisplay_File
if /i "!UserInput!" == "Batch online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Commands" (
	call :CommandList
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Helpcenter" (
	call :Help
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Window settings" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "Window" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "Settings" (
	call :Settings
	goto :Initializer
)
if /i "!UserInput!" == "About" (
	call :About
	goto :StartDisplay_File
)
if /i "!UserInput!" == "About Batch Explorer" (
	call :About
	goto :StartDisplay_File
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "Renew" goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer
)
pause
goto :Menu_Help_SentFromFiles








REM ==================================================================================================================================
REM ==================================================================================================================================





 :Initializer_Trash
:Initializer_Trash
	set ErrorFix=0
	call :Check_WindowSettings
	call :Check_CurrentDirectory
	call :Algorithm_CurrentDirectory
	call :Algorithm_TrashSet
	set CurrentPage=1
goto :StartDisplay_Trash






 :Check_SwitchPage_Trash
:Check_SwitchPage_Trash
	if /i "!Userinput!" == "Previous" set /a CurrentPage=%CurrentPage% - 1
	if /i "!Userinput!" == "Previous" if "!RecycleBinContent%CurrentPage%_1!" == "" set /a CurrentPage=%CurrentPage% + 1
	if /i "!Userinput!" == "Next" set /a CurrentPage=%CurrentPage% + 1
	if /i "!Userinput!" == "Next" if "!RecycleBinContent%CurrentPage%_1!" == "" set /a CurrentPage=%CurrentPage% - 1
goto :StartDisplay_Trash




 :Algorithm_TrashSet
:Algorithm_TrashSet
	:: Resetting used variables
		FOR /L %%A IN (1,1,!Counter!) DO (
			set RecycleBinContent%%A=
			set RecycleBinType%%A=
			set RecycleBinOriginal%%A=
		)
		FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
			set RecycleBinContent%%P_%%L=
			set RecycleBinType%%P_%%L=
			set RecycleBinOriginal%%P_%%L=
		)
	:: Resetting variables from files and folders
	:: --- Used in "TrashSet" as well, because the variable "Page" will be overwritten.
		FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
			FOR /L %%C IN (1,1,!FoldersPerLine!) DO set FolderDisplay_%%P_%%L_%%C=
			set LineA_%%P_%%L=
			set LineB_%%P_%%L=
			set LineC_%%P_%%L=
			set FolderDisplayLine_%%P_%%L=
		)
		FOR /L %%P IN (!FilePageStart!,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
			set File%%P_%%L=
			set File%%P_%%L_ExeAlert=
			set FileExtension%%P_%%L=
			set LineF_%%P_%%L=
		)


	set Counter=0
	set Page=1
	set Line=1

	cd /D "!SystemDrive!\RECYCLER\S*"
	FOR /F "tokens=3 delims=\" %%A IN ('cd') DO set SecRecyclePath=%%A

	:: %%O = Output // %%P = Partition // %%F = Files and folders // %%I = Info
	:: For each volume (A - Z), the content of the RECYCLER-directory is viewed. Sort this output and filter every line containing "echo", "FOR", "desktop" and "S-". Save this output into variables.
		FOR /F "delims=" %%O IN ('^(FOR %%P IN ^(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z^) DO FOR /F "delims=" %%F IN ^('dir /A /B "%%P:\RECYCLER\!SecRecyclePath!\*"'^) DO echo %%~nxF^) 2^>nul ^| sort ^| findstr /V "echo FOR desktop S- INFO2" 2^>nul') DO (
			set /a Counter=!Counter! + 1
			set RecycleBinContent!Counter!=%%O
		)
	
	:: Keep the counter for the "View"-menu
	set TrashMenu_View_FileAmount=!Counter!
	
	:: Analyzing "INFO2" file inside each recycle bin path
	:: --- INFO2 contains the real path of each recyclable file
		set Counter=0
		FOR %%P IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO FOR /F "delims=" %%I IN ('"if exist "%%P:\RECYCLER\!SecRecyclePath!\INFO2" type "%%P:\RECYCLER\!SecRecyclePath!\INFO2" 2>nul | more | find "%%P:\" 2>nul"') DO (
			set /a Counter=!Counter! + 1
			set RecycleBinOriginal!Counter!=%%I
		)


	:: For each found subject check if it is a file or a folder
	:: RecycleBinType
	FOR /L %%A IN (1,1,!Counter!) DO (
		type "!RecycleBinContent%%A:~1,1!:\RECYCLER\!SecRecyclePath!\!RecycleBinContent%%A!" >nul 2>nul && set RecycleBinType%%A=File:  
		if "!RecycleBinType%%A!" == "" set RecycleBinType%%A=Folder:
	)

	
	:: Set variables for each necessary page and each line
		FOR /L %%A IN (1,1,!Counter!) DO (
			if not "!RecycleBinContent%%A!" == "" set RecycleBinContent!Page!_!Line!=!RecycleBinContent%%A!
			if not "!RecycleBinContent%%A!" == "" set RecycleBinType!Page!_!Line!=!RecycleBinType%%A!
			if not "!RecycleBinContent%%A!" == "" FOR /F "delims=" %%B IN ("!RecycleBinOriginal%%A!") DO set RecycleBinOriginal!Page!_!Line!=%%~nxB
			if "!Line!" == "!LineMaximum_File!" (
				set Line=0
				set /a Page=!Page! + 1
			)
			set /a Line=!Line! + 1
		)

	:: Finishing the variables for the "View"-menu by adding spaces
		:: First "!Cols! - 14" because of the type of each subject (file or folder, requiring 8 characters space)
			set /a FreeCols=!Cols! - 14
			FOR /L %%A IN (1,1,!Counter!) DO FOR /L %%B IN (1,1,!FreeCols!) DO if "!RecycleBinContent%%A:~%%B,1!" == "" set RecycleBinContent%%A=!RecycleBinContent%%A! 
		
		:: Second "!Cols! - 6" because of the left and right border only
			set /a FreeCols=!Cols! - 6
			FOR /L %%A IN (1,1,!Counter!) DO if not "!RecycleBinOriginal%%A:~%FreeCols%,1!" == "" FOR /F "delims=" %%R IN ("!RecycleBinOriginal%%A!") DO set RecycleBinOriginal%%A=%%~sdpR%%~nxR
			FOR /L %%A IN (1,1,!Counter!) DO FOR /L %%B IN (1,1,!FreeCols!) DO if "!RecycleBinOriginal%%A:~%%B,1!" == "" set RecycleBinOriginal%%A=!RecycleBinOriginal%%A! 



	:: Expand each subject's name up to 13 characters by adding spaces
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO FOR /L %%N IN (0,1,12) DO if "!RecycleBinContent%%P_%%L:~%%N,1!" == "" set RecycleBinContent%%P_%%L=!RecycleBinContent%%P_%%L! 
	
	:: Finish each subject's true name by removing parts of the name or adding spaces
	:: -56 because of sidebar (-35), file type (-8), file name (-13), 4 spaces (-4) and right border (-3)
	set /a TemporaryCalc=!FilenameSpacePerLine! + 3
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		if not "!RecycleBinOriginal%%P_%%L:~%TemporaryCalc%,1!" == "" if not "!RecycleBinOriginal%%P_%%L:~%TemporaryCalc%,1!" == "~%TemporaryCalc%,1" FOR /F "delims=" %%B IN ("!RecycleBinOriginal%%P_%%L!") DO set RecycleBinOriginal%%P_%%L=%%~snxB
		if not "!RecycleBinOriginal%%P_%%L:~%TemporaryCalc%,1!" == "" if not "!RecycleBinOriginal%%P_%%L:~%TemporaryCalc%,1!" == "~%TemporaryCalc%,1" FOR /F "delims=" %%B IN ("!RecycleBinOriginal%%P_%%L!") DO set RecycleBinOriginal%%P_%%L=!RecycleBinOriginal%%P_%%L:~0,6!*%%~xB
		FOR /L %%R IN (1,1,!TemporaryCalc!) DO if "!RecycleBinOriginal%%P_%%L:~%%R,1!" == "" set RecycleBinOriginal%%P_%%L=!RecycleBinOriginal%%P_%%L! 
	)
	
	:: Make sure the first 7 variables are set
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO if "!RecycleBinContent%%P_%%L!" == "" (
		set RecycleBinContent%%P_%%L=             
		FOR /L %%R IN (0,1,!TemporaryCalc!) DO set RecycleBinOriginal%%P_%%L=!RecycleBinOriginal%%P_%%L! 
		set RecycleBinType%%P_%%L=       
	)
	
	
	:: ERROR-Fix: Fixing an error caused by an unknown reason
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO set RecycleBinOriginal%%P_%%L=!RecycleBinOriginal%%P_%%L! 
	if "!Cols:~-1,1!" == "6" set ErrorFix=1
	if "!Cols:~-1,1!" == "7" set ErrorFix=1
	if "!ErrorFix!" == "1" (
		set CurPathSpace_Space=!CurPathSpace_Space:~0,-1!
		set TableHeaderSpace_1=!TableHeaderSpace_1:~0,-1!
		set Line_Space=!Line_Space:~0,-1!
		set Line_Borders=!Line_Borders:~0,-1!
		FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO set RecycleBinOriginal%%P_%%L=!RecycleBinOriginal%%P_%%L:~0,-1!
	)
exit /b









 :StartDisplay_Trash
:StartDisplay_Trash
cls
set UserInput=
echo File  View  Go  Help
echo �     �     �   �
echo ����������������������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���                      � ��� ��home��� %username% �
echo �   [ ]    %username%!Sidebar_Space!� ���ͼ���������!Sidebar_Borders!�
echo �   ���                      �
echo �                            � �!CurPathSpace_Borders!�!Line_Borders!�
echo ����-^>������������������������ �!cd!�!CurPathSpace_Space!�
echo ���������Trash�������������� �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo ����������������������������� �   Type    Name          True name!TableHeaderSpace_1:~14!!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �   !RecycleBinType%CurrentPage%_1! !RecycleBinContent%CurrentPage%_1! !RecycleBinOriginal%CurrentPage%_1!�
echo � �     �  Desktop           � �   !RecycleBinType%CurrentPage%_2! !RecycleBinContent%CurrentPage%_2! !RecycleBinOriginal%CurrentPage%_2!�
echo � �������                    � �   !RecycleBinType%CurrentPage%_3! !RecycleBinContent%CurrentPage%_3! !RecycleBinOriginal%CurrentPage%_3!�
echo �                            � �   !RecycleBinType%CurrentPage%_4! !RecycleBinContent%CurrentPage%_4! !RecycleBinOriginal%CurrentPage%_4!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_5! !RecycleBinContent%CurrentPage%_5! !RecycleBinOriginal%CurrentPage%_5!�
echo �   ���    File system       � �   !RecycleBinType%CurrentPage%_6! !RecycleBinContent%CurrentPage%_6! !RecycleBinOriginal%CurrentPage%_6!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_7! !RecycleBinContent%CurrentPage%_7! !RecycleBinOriginal%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �   !RecycleBinType%CurrentPage%_%%L! !RecycleBinContent%CurrentPage%_%%L! !RecycleBinOriginal%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "Next" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "F"        goto :Menu_File_SentFromTrash
if /i "!UserInput!" == "File"     goto :Menu_File_SentFromTrash
if /i "!UserInput!" == "V"        goto :Menu_View_SentFromTrash
if /i "!UserInput!" == "View"     goto :Menu_View_SentFromTrash
if /i "!UserInput!" == "G"        goto :Menu_Go_SentFromTrash
if /i "!UserInput!" == "Go"       goto :Menu_Go_SentFromTrash
if /i "!UserInput!" == "H"        goto :Menu_Help_SentFromTrash
if /i "!UserInput!" == "Help"     goto :Menu_Help_SentFromTrash
if /i "!UserInput!" == "Renew"    goto :Initializer_Trash
if not "!UserInput!" == "" (
	%UserInput%
	pause
	if "!UserInput:~0,2!" == "cd" goto :Initializer
	if not "!UserInput:~0,2!" == "cd" goto :Initializer_Trash
)
pause
goto :StartDisplay_Trash




REM ----------------------------------------------------------------------------------------------------------------------------------




 :Menu_File_SentFromTrash
:Menu_File_SentFromTrash
cls
set UserInput=
echo File  View  Go  Help
echo �  ����������ͻ �
echo � Empty trash ��������������Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �������������ĺ              � ��� ��home��� %username% �
echo � Restore     �%username:~4%!Sidebar_Space!� ���ͼ���������!Sidebar_Borders!�
echo � Delete      �              �
echo �������������ĺ              � �!CurPathSpace_Borders!�!Line_Borders!�
echo � Properties  ���������������� �!cd!�!CurPathSpace_Space!�
echo �������������ĺh�������������� �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo � Close       ���������������� �   Type    Name          True name!TableHeaderSpace_1:~14!!TableHeaderSpace_2!�
echo �������������ͼ              � �    !Line_Space!�
echo � �����Ŀ                    � �   !RecycleBinType%CurrentPage%_1! !RecycleBinContent%CurrentPage%_1! !RecycleBinOriginal%CurrentPage%_1!�
echo � �     �  Desktop           � �   !RecycleBinType%CurrentPage%_2! !RecycleBinContent%CurrentPage%_2! !RecycleBinOriginal%CurrentPage%_2!�
echo � �������                    � �   !RecycleBinType%CurrentPage%_3! !RecycleBinContent%CurrentPage%_3! !RecycleBinOriginal%CurrentPage%_3!�
echo �                            � �   !RecycleBinType%CurrentPage%_4! !RecycleBinContent%CurrentPage%_4! !RecycleBinOriginal%CurrentPage%_4!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_5! !RecycleBinContent%CurrentPage%_5! !RecycleBinOriginal%CurrentPage%_5!�
echo �   ���    File system       � �   !RecycleBinType%CurrentPage%_6! !RecycleBinContent%CurrentPage%_6! !RecycleBinOriginal%CurrentPage%_6!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_7! !RecycleBinContent%CurrentPage%_7! !RecycleBinOriginal%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �   !RecycleBinType%CurrentPage%_%%L! !RecycleBinContent%CurrentPage%_%%L! !RecycleBinOriginal%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "F" goto :StartDisplay_Trash
if /i "!UserInput!" == "File" goto :StartDisplay_Trash
if /i "!UserInput!" == "Empty trash" (
	set /p UserInput=Are you sure you want to delete all files in the recycler? [Y / N] - 
	if /i "!UserInput!" == "Y" FOR %%P IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO if exist "%%P:\RECYCLER\!SecRecyclePath!" (
		:: The DEL-command does only delete files inside the recycle bin. "desktop.ini" and "INFO2" are left in the bin.
		:: The RD-command would delete the RecycleBin-folder as well. To pass this by, the DIR-command is required.
		FOR /F "delims=" %%A IN ('dir /A-D /B "%%P:\RECYCLER\!SecRecyclePath!\*"') DO if not "%%A" == "desktop.ini" if not "%%A" == "INFO2" del /F "%%P:\RECYCLER\!SecRecyclePath!\%%A" >nul 2>nul
		FOR /F "delims=" %%A IN ('dir /AD /B "%%P:\RECYCLER\!SecRecyclePath!\*"') DO rd /S /Q "%%P:\RECYCLER\!SecRecyclePath!\%%A" >nul 2>nul
	)
)
if /i "!UserInput!" == "Restore" goto :RestoreFile
if /i "!UserInput!" == "Delete" (
	setlocal enabledelayedexpansion
	echo.
	set /p Delete=File to delete: 
	set Delete=!Delete:"=!
	set DriveLetter=!Delete:~1,1!
	if exist "!DriveLetter!:\RECYCLER\!SecRecyclePath!\!Delete!" (del /A /P "!DriveLetter!:\RECYCLER\!SecRecyclePath!\!Delete!") ELSE (
		echo The file does not exist. Make sure to type the name correctly.
		pause
	)
	endlocal
)
if /i "!UserInput!" == "Properties" goto :Properties_Trash
if /i "!UserInput!" == "Close" (
	set /p UserInput=Are you sure you want to close the batch explorer? [Y / N] - 
	if /i "!UserInput!" == "Y" exit
)
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer_Trash
)
goto :Menu_File_SentFromTrash







 :RestoreFile
:RestoreFile
set ContinueRestore=
set CopyInfo=
set FileToRestore=
echo.

:: Warning for the user
	echo Warning: Restoring a file from the recycle bin via CMD can damage the file
	echo INFO2. This file is used to view the true name (in the batch explorer AND
	echo the Windows Explorer) of each file.
	echo If you restore a file from the bin via CMD, the recycle bin might not work
	echo entirely correctly anymore. It is recommended to restore the file via the
	echo real recycle bin.
	echo.
	echo If this does not work, you may continue. If so, you may backup INFO2.
	echo.
	set /p ContinueRestore=Would you like to continue? [Y / N] - 
	if not "!ContinueRestore!" == "Y" if not "!ContinueRestore!" == "y" goto :StartDisplay_Trash
	set /p CopyInfo=Would you like to backup INFO2 into !SystemDrive!:\? [Y / N] - 
	if /i "!CopyInfo!" == "Y" copy /-Y "!SystemDrive!\RECYCLER\!SecRecyclePath!\INFO2" "!SystemDrive!:\INFO2" >nul && echo INFO2 was copied successfully.
:: End of the warning


set /p FileToRestore=Please enter the file to restore: 
set DriveLetter=!FileToRestore:~1,1!

:: The input of the user must be familiar with "Dc14.exe"
:: If it is, the second letter (in this case "c") equals the drive letter.
:: If it is not, the program will not find the file. In case the recycle bin is not manipulated and in case the user typed it correctly,
:: it is almost impossible that there is a (visible) file other than "Dxn.Ext" (x = drive // n = number // Ext = Extension) in the recycle bin.
:: In conclusion:
:: "!FileToRestore:~1,1!" = Drive letter

if not exist "!DriveLetter!:\RECYCLER\!SecRecyclePath!\!FileToRestore!" echo The file does not exist. Make sure to use its recycle name.
if exist "!DriveLetter!:\RECYCLER\!SecRecyclePath!\!FileToRestore!" (
	:: The IF-command below does not allow spaces at the end. To remove them, the variable is changed by ": =".
	:: The MOVE-command does allow spaces at the end. They do not affect the finished file name after moving. E.g. "Stone.txt    " equals "Stone.txt"
	FOR /L %%A IN (1,1,!TrashMenu_View_FileAmount!) DO if /i "!FileToRestore!" == "!RecycleBinContent%%A: =!" move /-Y "!DriveLetter!:\RECYCLER\!SecRecyclePath!\!FileToRestore!" "!RecycleBinOriginal%%A!"
) 2>nul || (
	echo There was an error occured on moving the file. Possible reasons:
	echo - The program does not have enough rights to do the job.
	echo - The original directory does not exist anymore.
	echo - One of the file names contains a mistake.
	echo.
)
pause
goto :Initializer_Trash







 :Properties_Trash
:Properties_Trash
:: Parts of this label already exist in the label ":Properties". As "Trash" requires extra information, though, and it would be difficult to code
:: an extra option for ":Properties" allowing Trash-incoming demands, it might be tolerable to increase the file size by about 4 KB.
:: Properties: Use the DIR-command, the ATTRIB-command etc. to generate property list.
:: Reset variables to prevent unwanted effect
set AttributeList=
set Attributes=
set CreationDate=
set Difference=
set Digit1=
set Digit2=
set Digit3=
set Digit4=
set Digit5=
set Digit6=
set Digit7=
set Digit8=
set Digit9=
set Digit10=
set Digit11=
set Directory=
set Filename=
set FileSize=
set FileSizePuffer=
set FileType=
set Folder_FileAmount=
set Folder_FolderAmount=
set Folder_GTR=
set FolderContent=
set GB=
set GB_Addition=
set LastAccess=
set OpenWith=
set PreviousFileSize=
set SizeType=
set TemporaryCalc=
set Type=
set WriteAccess=

echo.
echo.
echo Whose properties do you want to view?
set /p Filename=-^> 
set Filename=%Filename:"=%
:: ERROR-Fix: Check if file does exist
	if not exist "%Filename:~1,1%:\RECYCLER\!SecRecyclePath!\%Filename%" (
		echo.
		echo The file does not exist. Please make sure to type its name correctly.
		pause
		goto :StartDisplay_Trash
	)
:: END of Error-Fix

pushd "%Filename:~1,1%:\RECYCLER\!SecRecyclePath!\"

:: ERROR-Fix: Check if file is a folder
	type "%Filename:~1,1%:\RECYCLER\!SecRecyclePath!\%Filename%" >nul 2>nul || goto :Properties_Trash_Folder
:: END of Error-Fix


:: Generating properties
	:: File Extension (e.g. ".txt")
		FOR /F "delims=" %%A IN ("%Filename%") DO set FileExtension=%%~xA
	:: File type (e.g. "txtfile")
		FOR /F "tokens=2 delims==" %%A IN ('assoc !FileExtension! 2^>nul') DO set Type=%%A
		FOR /F "skip=4 tokens=3,*" %%A IN ('reg query "HKCR\!Type!" /ve') DO set FileType=%%B
		if not "!Type!" == "" FOR /F "delims=" %%A IN ("reg.exe") DO if not exist "%%~$PATH:A" FOR /F "skip=4 tokens=3,*" %%A IN ('"reg query "HKCR\!Type!" /ve 2>nul"') DO set FileType=%%B
	:: Open with (e.g. "notepad")
		if not "!FileType!" == "" FOR /F "tokens=2 delims==" %%A IN ('ftype !Type! 2^>nul') DO (
			set OpenWith=%%~nA
			if "!OpenWith:~0,2!,!OpenWith:~3!" == "%%1, %%*" set OpenWith="!OpenWith!
		)
	:: File size and location
		FOR /F "delims=" %%A IN ("%Filename:~1,1%:\RECYCLER\!SecRecyclePath!\%Filename%") DO (
			set Directory=%%~dpA
			set FileSize=%%~zA
		)
		set SizeType= MB 
		set /a TemporaryCalc=!FileSize! / 1048576
		if "!TemporaryCalc!" == "0" (
			set SizeType= KB 
			set /a TemporaryCalc=!FileSize! / 1024
		)
		if "!TemporaryCalc!" == "0" (
			set SizeType=
			set TemporaryCalc=
		)
		set FileSize=!TemporaryCalc!!SizeType!(!FileSize! Bytes)
	:: Date generation
		:: /T:C = Created
		:: /T:W = Write access (changed)
		:: /T:A = Last access (started)
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:C') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set CreationDate=On %%A at %%B
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:W') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set WriteAccess=On %%A at %%B
		FOR /F "skip=5 tokens=1,2" %%A IN ('dir /A-D "%Filename%" /T:A') DO if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set LastAccess=On %%A at %%B
	:: Attributes
		:: These attributes are based on Windows XP. Indication, compression and encryption are missing.
		FOR /F "delims=" %%A IN ('attrib %Filename%') DO set AttributeList=%%A
		set AttributeList=!AttributeList:~0,10!
		echo "!AttributeList!" | find "A" >nul 2>nul && set Attributes=Archivable, 
		echo "!AttributeList!" | find "S" >nul 2>nul && set Attributes=!Attributes!systemfile, 
		echo "!AttributeList!" | find "H" >nul 2>nul && set Attributes=!Attributes!hidden, 
		echo "!AttributeList!" | find "R" >nul 2>nul && set Attributes=!Attributes!read-only, 
		echo "!AttributeList!" | find "I" >nul 2>nul && set Attributes=!Attributes!indicated, 
		echo "!AttributeList!" | find "C" >nul 2>nul && set Attributes=!Attributes!compressed, 
		echo "!AttributeList!" | find "E" >nul 2>nul && set Attributes=!Attributes!encrypted.
		set Attributes=!Attributes:~0,-2!
	
	:: Complete incomplete variables
		if "!FileType!" == "" if "!FileExtensions!" == "" (set FileType=File) ELSE (set FileType=!FileExtension!-File)
		if "!OpenWith!" == ""          set OpenWith=Unknown
		if "!Directory!" == ""        set Directory=ERROR
		if "!FileSize!" == "( Bytes)"  set FileSize=Unknown
		if "!CreationDate!" == ""  set CreationDate=Unknown
		if "!WriteAccess!" == ""    set WriteAccess=Unknown
		if "!LastAccess!" == ""      set LastAccess=Unknown
		if "!Attributes!" == ""      set Attributes=---
		if "!Attributes!" == "~0,-2"      set Attributes=---
	:: True file name
		:: Check which number the file got and reading its original file depending on the number
		:: Remove the spaces at the end of the original path
		set TemporaryCalc=
		FOR /L %%A IN (1,1,!TrashMenu_View_FileAmount!) DO if /i "!Filename!" == "!RecycleBinContent%%A: =!" (
			FOR /L %%B IN (150,-1,0) DO (
				if not "!TemporaryCalc!" == "1" if "!RecycleBinOriginal%%A:~%%B,1!" == " " set RecycleBinOriginal%%A=!RecycleBinOriginal%%A:~0,-1!
				if not "!RecycleBinOriginal%%A:~%%B,1!" == " " if not "!RecycleBinOriginal%%A:~%%B,1!" == "~%%B,1" if not "!RecycleBinOriginal%%A:~%%B,1!" == "" set TemporaryCalc=1
			)
			set TrueFileName=!RecycleBinOriginal%%A!
		)
		
		
:: END of generating properties

:: Output
echo.
echo.
echo Filename:      !Filename!
echo Original path: !TrueFileName!
echo File type:     !FileType!
echo Open with:     !OpenWith!
echo ����������������������������������
echo Location:      !Directory!
echo File size:     !FileSize!
echo ����������������������������������
echo Creation date: !CreationDate!
echo Last changed:  !WriteAccess!
echo Last access:   !LastAccess!
echo ����������������������������������
echo Attributes:    !Attributes!
echo.
echo.
pause
popd
goto :StartDisplay_Trash

 :Properties_Trash_Folder
:Properties_Trash_Folder
:: Generating properties
	:: True file name
		:: Check which number the file got and reading its original file depending on the number
		:: Remove the spaces at the end of the original path
		FOR /L %%A IN (1,1,!TrashMenu_View_FileAmount!) DO if /i "!Filename!" == "!RecycleBinContent%%A: =!" (
			FOR /L %%B IN (150,-1,0) DO (
				if not "!TemporaryCalc!" == "1" if "!RecycleBinOriginal%%A:~%%B,1!" == " " set RecycleBinOriginal%%A=!RecycleBinOriginal%%A:~0,-1!
				if not "!RecycleBinOriginal%%A:~%%B,1!" == " " if not "!RecycleBinOriginal%%A:~%%B,1!" == "~%%B,1" if not "!RecycleBinOriginal%%A:~%%B,1!" == "" set TemporaryCalc=1
			)
			set TrueFileName=!RecycleBinOriginal%%A!
		)
	
	echo.
	echo.
	echo Foldername:    !Filename!
	echo Original path: !TrueFileName!
	echo File type:     Folder
	echo ����������������������������������

	:: File size, location and content
		FOR /F "delims=" %%A IN ("%TrueFileName:~0,1%:\RECYCLER\!SecRecyclePath!\%Filename%") DO set Directory=%%~dpA
		echo Location:      !Directory!
		
		set GB=
		FOR /F "delims=" %%A IN ('dir /A-D /B /S "%Filename%" 2^>nul') DO (
			set /a TemporaryCalc=%%~zA 2>nul || set Folder_GTR=Greater than 
			set /p ".=File size:     !Folder_GTR!!GB!!GB_Addition!!FileSize! bytes   " <nul
			set /a FileSize=!FileSize! + %%~zA 2>nul
			set /a Difference=2147483647 - !FileSize!
			if "!Difference:~0,1!" == "-" (
				if "!GB!" == "28" set PreviousFileSize=32212254705
				if "!GB!" == "26" set PreviousFileSize=30064771058
				if "!GB!" == "24" set PreviousFileSize=27917287411
				if "!GB!" == "22" set PreviousFileSize=25769803764
				if "!GB!" == "20" set PreviousFileSize=23622320117
				if "!GB!" == "18" set PreviousFileSize=21474836470
				if "!GB!" == "16" set PreviousFileSize=19327352823
				if "!GB!" == "14" set PreviousFileSize=17179869176
				if "!GB!" == "12" set PreviousFileSize=15032385529
				if "!GB!" == "10" set PreviousFileSize=12884901882
				if "!GB!" == "8" set PreviousFileSize=10737418235
				if "!GB!" == "6" set PreviousFileSize=8589934588
				if "!GB!" == "4" set PreviousFileSize=6442450941
				if "!GB!" == "2" set PreviousFileSize=4294967294
				if "!GB!" == "" set PreviousFileSize=2147483647
				set /a FileSize=!Difference:~1!
				set /a GB=!GB! + 2
				set GB_Addition= GB + 
			)
			set /a Folder_FileAmount=!Folder_FileAmount! + 1
		)
		
		
		:: Manual calculation (addition) of two numbers. the "SET /A"-command does only work up to 2147483647. Any further produces errors.
		:: The addition works backwards. Add the last two numbers, then the previous last ones and so on. Attend sums greater than 10.
		:: %Digit1% is the last digit, %Digit11% is the very first digit.
		if not "!PreviousFileSize!" == "" FOR /L %%A IN (1,1,11) DO (
			set /a TemporaryCalc=%%A - 1
			FOR %%B IN (!TemporaryCalc!) DO (
				if not "!PreviousFileSize:~%%B,1!" == "" (
					if not "!FileSize:~%%B,1!" == "" (set /a Digit%%A=!Digit%%A! + !PreviousFileSize:~-%%A,1! + !FileSize:~-%%A,1!) ELSE (set /a Digit%%A=!Digit%%A! + !PreviousFileSize:~-%%A,1!)
				) ELSE (set Digit%%A=!Digit%%A!)
			)
			set /a Differenz=9 - !Digit%%A! 2>nul
			if "!Differenz:~0,1!" == "-" (
				set /a Digit%%A=!Digit%%A! - 10
				set /a TemporaryCalc=%%A + 1
				set Digit!TemporaryCalc!=1
			)
		)
		if "!FileSize!" == "" set FileSize=0
		set FileSizePuffer=!FileSize!
		if not "!PreviousFileSize!" == "" set FileSize=
		if not "!PreviousFileSize!" == "" FOR /L %%A IN (11,-1,1) DO set FileSize=!FileSize!!Digit%%A!
		if "!FileSize!" == "" set FileSize=0
		
		set SizeType= MB 
		set /a TemporaryCalc=!FileSizePuffer! / 1048576
		if "!TemporaryCalc!" == "0" (
			set SizeType= KB 
			set /a TemporaryCalc=!FileSizePuffer! / 1024
		)
		if "!TemporaryCalc!" == "0" (
			set SizeType=
			set TemporaryCalc=
		)
		if "!SizeType!" == " MB " (
			set /a Difference=1023 - !TemporaryCalc!
			if "!Difference:~0,1!" == "-" (
				set /a GB=!GB! + 1
				set /a TemporaryCalc=!TemporaryCalc! - 1024
			)
			set /a TemporaryCalc=!TemporaryCalc! * 100 / 1024
			set /a Difference=!TemporaryCalc! - 10
			:: This IF-command is used to allow an output like "3.01 GB" which would be "3.1 GB" without this command.
			if "!Difference:~0,1!" == "-" set TemporaryCalc=0!TemporaryCalc!
			set GB=!GB!,!TemporaryCalc!
			set TemporaryCalc=
			set SizeType=
			)
		)
		if not "!GB!" == "" set GB=!GB! GB 
		set FileSize=!Folder_GTR!!GB!!TemporaryCalc!!SizeType!(!FileSize! Bytes)            
		echo File size:     !FileSize!
	
		FOR /F "delims=" %%A IN ('dir /AD /B /S "%Filename%" 2^>nul') DO (
			set /a Folder_FolderAmount=!Folder_FolderAmount! + 1
			set /p ".=Content:       !Folder_FolderAmount! folders" <nul
		)
		if "!Folder_FolderAmount!" == "" set Folder_FolderAmount=0
		if "!Folder_FileAmount!" == "" set Folder_FileAmount=0
		set FolderContent=!Folder_FolderAmount! folders, !Folder_FileAmount! files
		echo Content:       !FolderContent!

	:: Date generation
		:: /T:C = Created
		:: /T:W = Write access (changed)
		:: /T:A = Last access (started)
		FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:C "!Directory!"') DO if "%%~C" == "%Filename%" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set CreationDate=On %%A at %%B
		FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:W "!Directory!"') DO if "%%~C" == "%Filename%" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set WriteAccess=On %%A at %%B
		FOR /F "skip=5 tokens=1,2,4" %%A IN ('dir /AD /T:A "!Directory!"') DO if "%%~C" == "%Filename%" if not "%%A" == "0" if not "%%A" == "1" if not "%%B" == "0" if not "%%B" == "1" set LastAccess=On %%A at %%B

	:: Attributes
		:: These attributes are based on Windows XP. Indication, compression and encryption are missing.
		FOR /F "delims=" %%A IN ('attrib %Filename%') DO set AttributeList=%%A
		set AttributeList=!AttributeList:~0,10!
		echo "!AttributeList!" | find "A" >nul 2>nul && set Attributes=Archivable, 
		echo "!AttributeList!" | find "S" >nul 2>nul && set Attributes=!Attributes!systemfile, 
		echo "!AttributeList!" | find "H" >nul 2>nul && set Attributes=!Attributes!hidden, 
		echo "!AttributeList!" | find "R" >nul 2>nul && set Attributes=!Attributes!read-only, 
		echo "!AttributeList!" | find "I" >nul 2>nul && set Attributes=!Attributes!indicated, 
		echo "!AttributeList!" | find "C" >nul 2>nul && set Attributes=!Attributes!compressed, 
		echo "!AttributeList!" | find "E" >nul 2>nul && set Attributes=!Attributes!encrypted, 
		set Attributes=!Attributes:~0,-2!
	
	:: Complete incomplete variables
		if "!Directory!" == ""        set Directory=ERROR
		if "!FileSize!" == "( Bytes)"  set FileSize=Unknown
		if "!CreationDate!" == ""  set CreationDate=Unknown
		if "!WriteAccess!" == ""    set WriteAccess=Unknown
		if "!LastAccess!" == ""      set LastAccess=Unknown
		if "!Attributes!" == ""      set Attributes=---
		if "!Attributes!" == "~0,-2"      set Attributes=---

:: END of generating properties

:: Rest of output
echo ����������������������������������
echo Creation date: !CreationDate!
echo Last changed:  !WriteAccess!
echo Last access:   !LastAccess!
echo ����������������������������������
echo Attributes:    !Attributes!
echo.
echo.
pause
popd
goto :StartDisplay_Trash





REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_View_SentFromTrash
:Menu_View_SentFromTrash
:: Reset UserInput to prevent unwanted command execution
set UserInput=

:: Variable used to print the upper and lower border
set /a TemporaryCalc=!Cols! - 12

:: Clear the screen only now to have no blank screen for a while
cls

:: Printing the top
	:: Line 1 (menus)
	echo File  View  Go  Help
	:: Line 2 (borders)
	set /p ".=�����ͼ  �" <nul
	FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
	echo �
	:: Line 3 (instructions)
	set /p ".=� Subjects inside the recycle bin (Type: Name):" <nul
	FOR /L %%A IN (44,1,!FreeCols!) DO set /p ".= " <nul
	echo �
	:: Line 4 (underlining instructions)
	set /p ".=� ���������������������������������������������" <nul
	FOR /L %%A IN (44,1,!FreeCols!) DO set /p ".= " <nul
	echo �



:: Printing the files and folders
	FOR /L %%A IN (1,1,!TrashMenu_View_FileAmount!) DO echo � !RecycleBinType%%A! !RecycleBinContent%%A! �


:: Empty line (~echo.)
	set /p ".=�" <nul
	FOR /L %%A IN (4,1,!Cols!) DO set /p ".= " <nul
	echo �


:: Instruction line + underlining
	set /p ".=� Origins (in this order):" <nul
	FOR /L %%A IN (23,1,!FreeCols!) DO set /p ".= " <nul
	echo �
	set /p ".=� ������������������������" <nul
	FOR /L %%A IN (23,1,!FreeCols!) DO set /p ".= " <nul
	echo �

:: Printing the original paths of the files and folders
	FOR /L %%A IN (1,1,!TrashMenu_View_FileAmount!) DO echo � !RecycleBinOriginal%%A! �


:: Printing the lower border
	set /p ".=����������" <nul
	FOR /L %%A IN (1,1,!TemporaryCalc!) DO set /p ".=�" <nul
	echo �


echo.
set /p UserInput=� 
if /i "!UserInput!" == "View" goto :StartDisplay_Trash
if /i "!UserInput!" == "V" goto :StartDisplay_Trash
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer_Trash
)
pause
goto :StartDisplay_Trash




REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_Go_SentFromTrash
:Menu_Go_SentFromTrash
cls
set UserInput=
echo File  View  Go  Help
echo �     �   �ͼ���������ͻ
echo ���������ĺ User       �����Ŀ ���ͻ����Ŀ���!Sidebar_Borders!�
echo �   ���   � Trash      �     � ��� ��home��� %username% �
echo �   [ ]   � Desktop    �     � ���ͼ���������!Sidebar_Borders!�
echo �   ���   � File system�     �
echo �         ������������͹     � �!CurPathSpace_Borders!�!Line_Borders!�
echo ����-^>����� 1 folder up������� �!cd!�!CurPathSpace_Space!�
echo ��������������������ͼ������ �!CurPathSpace_Borders!�!CurPathSpace_Space!�
echo ����������������������������� �   Type    Name          True name!TableHeaderSpace_1:~14!!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �   !RecycleBinType%CurrentPage%_1! !RecycleBinContent%CurrentPage%_1! !RecycleBinOriginal%CurrentPage%_1!�
echo � �     �  Desktop           � �   !RecycleBinType%CurrentPage%_2! !RecycleBinContent%CurrentPage%_2! !RecycleBinOriginal%CurrentPage%_2!�
echo � �������                    � �   !RecycleBinType%CurrentPage%_3! !RecycleBinContent%CurrentPage%_3! !RecycleBinOriginal%CurrentPage%_3!�
echo �                            � �   !RecycleBinType%CurrentPage%_4! !RecycleBinContent%CurrentPage%_4! !RecycleBinOriginal%CurrentPage%_4!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_5! !RecycleBinContent%CurrentPage%_5! !RecycleBinOriginal%CurrentPage%_5!�
echo �   ���    File system       � �   !RecycleBinType%CurrentPage%_6! !RecycleBinContent%CurrentPage%_6! !RecycleBinOriginal%CurrentPage%_6!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_7! !RecycleBinContent%CurrentPage%_7! !RecycleBinOriginal%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �   !RecycleBinType%CurrentPage%_%%L! !RecycleBinContent%CurrentPage%_%%L! !RecycleBinOriginal%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "G" goto :StartDisplay_Trash
if /i "!UserInput!" == "Go" goto :StartDisplay_Trash
if /i "!UserInput!" == "User" (
	cd /D %userprofile%
	goto :Initializer
)
if /i "!UserInput!" == "Trash" goto :StartDisplay_Trash
if /i "!UserInput!" == "Desktop" goto :Initializer_Desktop
if /i "!UserInput!" == "File system" goto :Initializer_FileSystem
if /i "!UserInput!" == "Next" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "Renew" goto :Initializer_Trash
if /i "!UserInput!" == "1 folder up" (
	cd..
	goto :Initializer
)
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer_Trash
)
pause
goto :Menu_Go_SentFromTrash




REM ----------------------------------------------------------------------------------------------------------------------------------





 :Menu_Help_SentFromTrash
:Menu_Help_SentFromTrash
cls
set UserInput=
echo File  View  Go  Help
echo �     �     � �ͼ  �����������������ͻ
echo �������������ĺ Batch online         ���Ŀ���!Sidebar_Borders!�
echo �   ���       � Commands             �ome��� %username% �
echo �   [ ]    %username:~0,3%� Helpcenter           ��������!Sidebar_Borders!�
echo �   ���       � Window settings      �
echo �             ����������������������͹!CurPathSpace_Borders:~6!�!Line_Borders!�
echo ����-^>��������� About Batch Explorer �!cd:~6!�!CurPathSpace_Space!�
echo ���������Tra����������������������ͼ!CurPathSpace_Borders:~6!�!CurPathSpace_Space!�
echo ����������������������������� �   Type    Name          True name!TableHeaderSpace_1:~14!!TableHeaderSpace_2!�
echo �                            � �    !Line_Space!�
echo � �����Ŀ                    � �   !RecycleBinType%CurrentPage%_1! !RecycleBinContent%CurrentPage%_1! !RecycleBinOriginal%CurrentPage%_1!�
echo � �     �  Desktop           � �   !RecycleBinType%CurrentPage%_2! !RecycleBinContent%CurrentPage%_2! !RecycleBinOriginal%CurrentPage%_2!�
echo � �������                    � �   !RecycleBinType%CurrentPage%_3! !RecycleBinContent%CurrentPage%_3! !RecycleBinOriginal%CurrentPage%_3!�
echo �                            � �   !RecycleBinType%CurrentPage%_4! !RecycleBinContent%CurrentPage%_4! !RecycleBinOriginal%CurrentPage%_4!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_5! !RecycleBinContent%CurrentPage%_5! !RecycleBinOriginal%CurrentPage%_5!�
echo �   ���    File system       � �   !RecycleBinType%CurrentPage%_6! !RecycleBinContent%CurrentPage%_6! !RecycleBinOriginal%CurrentPage%_6!�
echo �   ���                      � �   !RecycleBinType%CurrentPage%_7! !RecycleBinContent%CurrentPage%_7! !RecycleBinOriginal%CurrentPage%_7!�
FOR /L %%L IN (8,1,!LineMaximum_File!) DO echo �                            � �   !RecycleBinType%CurrentPage%_%%L! !RecycleBinContent%CurrentPage%_%%L! !RecycleBinOriginal%CurrentPage%_%%L!�
echo �                            � �    !Line_Space!�
echo �                            � �    !Line_Space!�
echo �                            � � Previous ^<-    !Line_Space:~12,-9! -^> Next �
echo ������������������������������ �!CurPathSpace_Borders!�!Line_Borders!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "H" goto :StartDisplay_Trash
if /i "!UserInput!" == "Help" goto :StartDisplay_Trash
if /i "!UserInput!" == "Batch online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "Online" (
	start www.batchlog.pytalhost.com
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "Commands" (
	call :CommandList
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "Helpcenter" (
	call :Help
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "Window settings" (
	call :Settings
	goto :Initializer_Trash
)
if /i "!UserInput!" == "Window" (
	call :Settings
	goto :Initializer_Trash
)
if /i "!UserInput!" == "Settings" (
	call :Settings
	goto :Initializer_Trash
)
if /i "!UserInput!" == "About" (
	call :About
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "About Batch Explorer" (
	call :About
	goto :StartDisplay_Trash
)
if /i "!UserInput!" == "Next" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage_Trash
if /i "!UserInput!" == "Renew" goto :Initializer_Trash
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer_Trash
)
pause
goto :Menu_Go_SentFromTrash
	
	
	
	
	
	


REM ==================================================================================================================================
REM ==================================================================================================================================





 :Initializer_Desktop
:Initializer_Desktop
	set ErrorFix=0
	call :Check_WindowSettings
	call :Check_CountDesktop
	call :Check_CountFiles
	call :Check_CurrentDirectory
	call :Algorithm_CurrentDirectory
	call :Algorithm_FolderSet
	call :Algorithm_FileSet
	set CurrentPage=1
	set Display=Folder
goto :StartDisplay_Folder





 :Check_CountDesktop
:Check_CountDesktop
	:: DesktopD!DesktopCount! is a directory
	:: DesktopF!DesktopCount! is a file
	:: The variables above are used to check if a subject is a file or a folder
	FOR /L %%R IN (1,1,!DesktopCount!) DO set Desktop%%R=
	set DesktopCount=0
	FOR /F "delims=" %%A IN ('dir /AD /B "%userprofile%\Desktop\*" "%allusersprofile%\Desktop\*" 2^>nul ^| sort') DO (
		set /a DesktopCount=!DesktopCount! + 1
		set DesktopD!DesktopCount!=%%A
	)
	set Desktop_FileFolderDivider=!DesktopCount!
	FOR /F "delims=" %%A IN ('dir /A-D /B "%userprofile%\Desktop\*" "%allusersprofile%\Desktop\*" 2^>nul ^| sort') DO (
		set /a DesktopCount=!DesktopCount! + 1
		set DesktopF!DesktopCount!=%%A
	)
	set DesktopCount=0
	FOR /F "delims=" %%A IN ('dir /A /B "%userprofile%\Desktop\*" "%allusersprofile%\Desktop\*" 2^>nul ^| sort') DO (
		set /a DesktopCount=!DesktopCount! + 1
		set Desktop!DesktopCount!=%%A
	)
exit /b





 :Algorithm_DesktopSet
:Algorithm_DesktopSet
	:: FolderDisplay-variable defintion: FolderDisplay_!Page!_!Line!_!Column!=Name of the folder
		:: FolderDisplay   = String to identify variable
		:: !Page!          = The folder is displayed on page "Page"
		:: !Line!          = The folder is displayed in line "Line" of the display
		:: !Column! / %%C  = The folder is displayed in column "Column" of the display
	:: TemporaryCalc is used to change the line of the display
	
	
	:: Resetting possible variables from the "Trash"-menu
	FOR /L %%A IN (1,1,!Counter!) DO (
		set RecycleBinContent%%A=
		set RecycleBinType%%A=
	)
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		set RecycleBinContent%%P_%%L=
		set RecycleBinType%%P_%%L=
	)
	
	:: Resetting variables from files and folders
	set TemporaryCalc=!FoldersPerLine!
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Folder!) DO (
		FOR /L %%C IN (1,1,!FoldersPerLine!) DO set FolderDisplay_%%P_%%L_%%C=
		set LineA_%%P_%%L=
		set LineB_%%P_%%L=
		set LineC_%%P_%%L=
		set FolderDisplayLine_%%P_%%L=
	)
	FOR /L %%P IN (!FilePageStart!,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_File!) DO (
		set File%%P_%%L=
		set File%%P_%%L_ExeAlert=
		set FileExtension%%P_%%L=
		set LineF_%%P_%%L=
	)
	
	:: Resetting used variables
	FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Desktop!) DO (
		FOR /L %%C IN (1,1,!DesktopPerLine!) DO set DesktopDisplay_%%P_%%L_%%C=
		set DesktopIconLineA_%%P_%%L=
		set DesktopIconLineB_%%P_%%L=
		set DesktopIconLineC_%%P_%%L=
		set DesktopDisplay_%%P_%%L=
		set DesktopDisplayLine1_%%P_%%L=
		set DesktopDisplayLine2_%%P_%%L=
	)
	
	set Line=1
	set Page=1
	set Col=1
	FOR /L %%F IN (1,1,!DesktopCount!) DO (
		if not "!Desktop%%F!" == "" set DesktopDisplay_!Page!_!Line!_!Col!=!Desktop%%F!
		set /a Col=!Col! + 1
		if "!Line!" == "!LineMaximum_Desktop!" if "!Col!" GTR "!DesktopPerLine!" (
			set Col=1
			set Line=0
			set /a Page=!Page! + 1
		)
		if "%%F" == "!TemporaryCalc!" (
			set Col=1
			set /a Line=!Line! + 1
			set /a TemporaryCalc=!TemporaryCalc! + !DesktopPerLine!
		)
	)
	
	
	
	
	set TemporaryCalc=0
	
	:: %%P = Page // %%L = Line // %%C = Column // %%A = Add space
	:: Removing spaces from the start and the end of each folder's name
	:: Adding ".." to the display name in case the name is too long for the icon (max. 9 letters)
		:: If the name is shorter than 9 letters, it adds spaces to the name until the name is exactly 9 letters long
	:: Mark the text to see invisible spaces
	:: Important notice:
		:: Every variable that uses "_%%P_%%L_%%C" contains one single name
		:: Every variable that does not contain "_%%C" contains an entire line with multiple names
	
	FOR /L %%P IN (1,1,!Page!) DO (
		FOR /L %%L IN (1,1,!LineMaximum_Desktop!) DO (
			FOR /L %%C IN (1,1,!DesktopPerLine!) DO (
				set TemporaryCalc=0
				if not "!DesktopDisplay_%%P_%%L_%%C!" == "" (
					if not "!DesktopDisplay_%%P_%%L_%%C:~9,1!" == "" if not "!DesktopDisplay_%%P_%%L_%%C:~9,1!" == "~9,1" set DesktopDisplay_%%P_%%L_%%C=!DesktopDisplay_%%P_%%L_%%C: =!
					if not "!DesktopDisplay_%%P_%%L_%%C:~9,1!" == "" if not "!DesktopDisplay_%%P_%%L_%%C:~9,1!" == "~9,1" set DesktopDisplay_%%P_%%L_%%C=!DesktopDisplay_%%P_%%L_%%C:~0,7!..
					FOR /L %%A IN (1,1,8) DO (
						if "!DesktopDisplay_%%P_%%L_%%C:~%%A,1!" == "" set /a TemporaryCalc=!TemporaryCalc! + 1
						if "!DesktopDisplay_%%P_%%L_%%C:~%%A,1!" == "~%%A,1" set /a TemporaryCalc=!TemporaryCalc! + 1
					)
					set /a TemporaryCalc=!TemporaryCalc! / 2
					FOR /L %%A IN (1,1,!TemporaryCalc!) DO (
						set DesktopDisplay_%%P_%%L_%%C= !DesktopDisplay_%%P_%%L_%%C!
						set DesktopDisplay_%%P_%%L_%%C=!DesktopDisplay_%%P_%%L_%%C! 
					)
					if "!DesktopDisplay_%%P_%%L_%%C:~8,1!" == "" set DesktopDisplay_%%P_%%L_%%C=!DesktopDisplay_%%P_%%L_%%C! 
					if "!DesktopDisplay_%%P_%%L_%%C:~8,1!" == "~8,1" set DesktopDisplay_%%P_%%L_%%C=!DesktopDisplay_%%P_%%L_%%C! 
					if "!Desktop_Type!" == "Folder (
						set DesktopIconLineA_%%P_%%L=!LineA_%%P_%%L!  ���     
						set DesktopIconLineB_%%P_%%L=!LineB_%%P_%%L!  ���     
						set DesktopIconLineC_%%P_%%L=!LineC_%%P_%%L!  ���     
					) ELSE (
						set DesktopIconLineA_%%P_%%L=!LineA_%%P_%%L!�����Ŀ   
						set DesktopIconLineB_%%P_%%L=!LineB_%%P_%%L!�     �   
						set DesktopIconLineC_%%P_%%L=!LineC_%%P_%%L!�������   
					)
				) ELSE (
					set DesktopDisplay_%%P_%%L_%%C=         
					set DesktopIconLineA_%%P_%%L=!LineA_%%P_%%L!          
					set DesktopIconLineB_%%P_%%L=!LineB_%%P_%%L!          
					set DesktopIconLineC_%%P_%%L=!LineC_%%P_%%L!          
				)
				set DesktopDisplayLine_%%P_%%L=!DesktopDisplayLine_%%P_%%L! !DesktopDisplay_%%P_%%L_%%C!
			)
		)
	)
	
	:: Enable 2nd line of each page to prevent error in case !LineMaximum_Desktop! = 1
	:: %%R = Replace A, B, C to make the code shorter
	FOR %%R IN (A B C) DO FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Desktop!) DO (
		if "!DesktopIconLine%%E_%%P_%%L!" == "" set DesktopIconLine%%E_%%P_%%L=!Line_Space!
		if "!DesktopDisplayLine_%%P_%%L!" == "" set DesktopDisplayLine_%%P_%%L=!Line_Space!
	)
	
	:: ERROR-Fix: Fixing an error caused by an unknown reason
	if "!Cols:~-1,1!" == "6" set ErrorFix=1
	if "!Cols:~-1,1!" == "7" set ErrorFix=1
	if "!ErrorFix!" == "1" (
		FOR /L %%P IN (1,1,!Page!) DO FOR /L %%L IN (1,1,!LineMaximum_Desktop!) DO (
			set LineA_%%P_%%L=!LineA_%%P_%%L:~0,-1!
			set LineB_%%P_%%L=!LineB_%%P_%%L:~0,-1!
			set LineC_%%P_%%L=!LineC_%%P_%%L:~0,-1!
			set DesktopDisplayLine_%%P_%%L=!DesktopDisplayLine_%%P_%%L:~0,-1!
		)
		set Line_Space=!Line_Space:~0,-1!
		set Line_Borders=!Line_Borders:~0,-1!
		set CurPathSpace_Space=!CurPathSpace_Space:~0,-1!
	)
exit /b









 :StartDisplay_Desktop
:StartDisplay_Desktop
call :Algorithm_Desktop
set CurrentPage=1
cls
set UserInput=
echo File  Edit  View  Go  Help
echo �     �     �     �   �
echo �!DesktopBorder!�
FOR /L %%G IN (1,1,!LineMaximum_Desktop!) DO call :Algorithm_LineWriter_Desktop !CurrentPage! %%G
echo �!Desktop_LineSpace_Space!�
echo � Previous ^<- !Desktop_LineSpace_Space:~13,9! -^> Next �
echo �!DesktopBorder!�
echo.
set /p UserInput=� 
if /i "!UserInput!" == "Next"     goto :Check_SwitchPage
if /i "!UserInput!" == "Previous" goto :Check_SwitchPage
if /i "!UserInput!" == "F"        goto :Menu_File_SentFromTrash
if /i "!UserInput!" == "File"     goto :Menu_File_SentFromTrash
if /i "!UserInput!" == "E"        goto :Menu_Edit_SentFromTrash
if /i "!UserInput!" == "Edit"     goto :Menu_Edit_SentFromTrash
if /i "!UserInput!" == "V"        goto :Menu_View_SentFromTrash
if /i "!UserInput!" == "View"     goto :Menu_View_SentFromTrash
if /i "!UserInput!" == "G"        goto :Menu_Go_SentFromTrash
if /i "!UserInput!" == "Go"       goto :Menu_Go_SentFromTrash
if /i "!UserInput!" == "H"        goto :Menu_Help_SentFromTrash
if /i "!UserInput!" == "Help"     goto :Menu_Help_SentFromTrash
if /i "!UserInput!" == "Renew"    goto :Initializer
if not "!UserInput!" == "" (
	%UserInput%
	pause
	goto :Initializer_Desktop
)
pause
goto :StartDisplay_Trash





REM ==================================================================================================================================
REM ==================================================================================================================================






 :StartDisplay_Overload
:StartDisplay_Overload
cls
echo System overload.
echo ����������������
echo.
dir /A /D
echo.
echo.
echo To switch to the upper directory, please enter "cd.." without ""
echo.
set /p UserInput=� 
if not "!UserInput!" == "" (
	%UserInput%
	pause
	if /i "!UserInput:~0,2!" == "cd" goto :Initializer
)
goto :StartDisplay_Overload






REM ==================================================================================================================================
REM ==================================================================================================================================




 :CommandList
:CommandList
:: These commands are only used for the Batch Explorer. The explanations do not fit to
:: general commands in batch.
cls
echo Commands for the Batch Explorer
echo �������������������������������
echo   F // File       - Open the menu "File" or return from the menu "File"
echo   E // Edit       - Open the menu "Edit" or return from the menu "Edit"
echo   V // View       - Go to the "View"-overview
echo   G // Go         - Open the menu "Go"   or return from the menu "Go"
echo   H // Help       - Open the menu "Help" or return from the menu "Help"
echo   Renew           - Renew the list of files and folders
echo   Next            - Turn one page in the list forwards
echo   Previous        - Turn one page in the list backwards
echo.
echo In the menu "File"
echo ������������������
echo   Explore       - Change the directory
echo   Find          - Find a particular file name
echo   Open          - Open a file with its default program
echo   Open with...  - Open a file with a particular program
echo   Copy          - Copy a file to another directory (name can be changed)
echo   Move          - Move a file to another directory (name can be changed)
echo   Rename        - Rename a file without changing directory
echo   Cut           - Cut a file. It is temporarily saved in "%%temp%%"
echo   Paste         - Paste a file into the current directory (multiply pastable)
echo   Delete        - Delete a file
set /p ".=--- Press any key to continue ---" <nul
pause >nul
FOR /L %%A IN (1,1,33) DO set /p ".=" <nul
echo   New           - Create a new file. You need to enter an extension as well.
echo   Properties    - View the file's properties.
echo   Close         - Close the Batch Explorer (cut files will be lost)
echo   Empty trash   - Remove every file and folder from the recycle bin
echo   Restore       - Restore a single file or folder from the recycle bin
echo.
echo In the menu "Edit"
echo ������������������
echo   Notepad             - Edit a file via notepad
echo   MS-Dos // MS-Dos Editor - Edit a file via EDIT.COM
echo  (Notepad++)          - Edit a file via Notepad++ (only available if installed)
echo.
echo In the menu "Go"
echo ����������������
echo   User          - Change directory to %%userprofile%%
echo   Trash         - Open the recycle bin
echo   Desktop       - View the desktop
echo   File system   - Open "My Computer"
echo   1 folder up   - Go to the upper directory
echo.
set /p ".=--- Press any key to continue ---" <nul
pause >nul
FOR /L %%A IN (1,1,33) DO set /p ".=" <nul
echo In the menu "Help"               
echo ������������������
echo   Online // Batch online      - Open www.batchlog.pytalhost.com
echo   Commands                    - View this list of commands
echo   Helpcenter                  - View the FAQ, covered errors and support
echo   Settings // Window settings - Change the window's size
echo   About // About Batch Explorer - Info about the Batch Explorer
echo.
echo.
echo Note: To use batch commands like "HELP", "EDIT", "COPY", "MOVE" etc. while
echo       having one of the menus open, you may use "CALL help" or "CALL move" etc.
echo.
echo Note: The EXPLORE-command and the "1 folder up"-command can be solved by the
echo       CD-command in batch. Just type "CD [Enter directory name here]" to move
echo       to another directory. Type "CD.." to go 1 folder up.
echo.
echo.
echo.
echo Press any key to exit the command list . . .
pause >nul
exit /b









 :Help
:Help
cls
setlocal
echo �����������������������������������������������������������������������������ͻ
echo �                        Batch  Explorer  Help  Center                        �
echo �����������������������������������������������������������������������������͹
echo � Frequently asked questions                                                  �
echo � ��������������������������                                                  �
echo �    1. What is the Batch Explorer made for?                                  �
echo �        - It is meant to be an alternative to the Windows Explorer. In some  �
echo �          cases, the Windows Explorer offers only restricted rights to the   �
echo �          user. Often the Batch Explorer has more rights.                    �
echo �                                                                             �
echo �    2. The program does not view the files correctly, what should I do now?  �
echo �        - This error is often caused when working under restrictions. Some-  �
echo �          times it is possible to enter "goto :Initializer".                 �
echo �                                                                             �
echo �    3. The program crashes very often. Is there an unknown error?            �
echo �        - In general, the program requires a long time to analyze a folder's �
echo �          content. While calculating, it seems as if the Explorer crashed.   �
echo �          If waiting does not work, you may contact the programmer.          �
echo �                                                                             �
echo �    4. Does the program need to be installed?                                �
echo �        - No, the program is a single file. There are no other files needed. �
echo �                                                                             �
set /p ".=����Press any key to continue . . .������������������������������������������ͼ" <nul
pause >nul
FOR /L %%A IN (1,1,79) DO set /p ".=" <nul
echo �    5. How do I use the Batch Explorer?                                      �
echo �        - You need to type particular commands when required. Press enter to �
echo �          execute them. A list of commands is available via "Help > Commands"�
echo �                                                                             �
echo �    6. How do I customize the Batch Explorer?                                �
echo �        - You can change a few settings via "Help > Window settings". Title, �
echo �          colors, text and design can only be changed by editing the source  �
echo �          code. Read more about customization by entering "2" below.         �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
set /p ".=����Press any key to continue . . .������������������������������������������ͼ" <nul
pause >nul
FOR /L %%A IN (1,1,79) DO set /p ".=" <nul
echo �����������������������������������������������������������������������������͹
echo �                                                                             �
echo � Support                                                                     �
echo � �������                                                                     �
echo �    You can contact the programmer either via YouTube or via ICQ.            �
echo �                                                                             �
echo �    YouTube user name: GrellesLicht28                                        �
echo �    ICQ number: 414-702-600                                                  �
echo �                                                                             �
echo �    Available between                                                        �
echo �      Mo - Do    15:45 - 21:30    GMT+0                                      �
echo �      Fr - Su    12:00 - 21:30    GMT+0                                      �
echo �                                                                             �
echo �    Contact requested when                                                   �
echo �      � having found uncovered errors,                                       �
echo �      � needing help about functions of the program or the program itself,   �
echo �      � having suggestions what to add to the program,                       �
echo �      � having found the program on another website than                     �
echo �        www.batchlog.pytalhost.com.                                          �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
set /p ".=����Press any key to continue . . .������������������������������������������ͼ" <nul
pause >nul
FOR /L %%A IN (1,1,79) DO set /p ".=" <nul
echo �����������������������������������������������������������������������������͹
echo �                                                                             �
echo � Enter one of the following numbers to view more information                 �
echo � �����������������������������������������������������������                 �
echo �   1: View covered errors                                                    �
echo �   2: View some ways to customize the Batch Explorer                         �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �����������������������������������������������������������������������������ͼ
set /p UserInput_Help=� 
if "%UserInput_Help%" == "1" call :Help_CoveredErrors
if "%UserInput_Help%" == "2" call :Help_Customization
endlocal
exit /b


 :Help_CoveredErrors
:Help_CoveredErrors
cls
echo �����������������������������������������������������������������������������ͻ
echo � Covered errors                                                              �
echo � ��������������                                                              �
echo �   1: Minimum amount of lines and columns to work correctly                  �
echo �   2: Using only available lines and columns to prevent invisible output     �
echo �   3: Prevent the program from calculating too long by using "System         �
echo �      Overload" in large folders (e.g. system32; this does not work for      �
echo �      folders that are not named in the file)                                �
echo �   4: Prevention of corrupt empty fields (in case of 0 folders and 0 files)  �
echo �   5: Prevention of switching the pages to empty ones (via previous and next)�
echo �   6: Prevention of corrupt display when having a column amount ending with  �
echo �      a "6" and a "7"                                                        �
echo �   7: Prevention of error messages about opening a non-existing file (in the �
echo �      "Open-With"-section)                                                   �
echo �   8: Edit the user's input in the "Find"-section as best as possible        �
echo �   9: Prevent the user from using disallowed characters when creating a new  �
echo �      file                                                                   �
set /p ".=����Press any key to continue . . .������������������������������������������ͼ" <nul
pause >nul
FOR /L %%A IN (1,1,79) DO set /p ".=" <nul
echo �                                                                             �
echo �  10: Warn the user if a new file could not be created                       �
echo �  11: Complete the list of properties in case one could not be found out     �
echo �  12: Warn the user if the file "INFO2" could not be backed up into %systemdrive%\      �
echo �  13: Shorten the current directory to prevent corrupt display               �
echo �  14: Shorten file extensions or/and file names to prevent corrupt display   �
echo �  15: Prevent immediate "Clear screen" after command input (useful for       �
echo �      people who use batch commands)                                         �
echo �  16: Prevent program from crashing because of jumping to a non-specified    �
echo �      label by using it twice at the same position                           �
echo �  17: Prevent program from calculating a folder's size wrong in case it is   �
echo �      greater than 2 GB. Does not work for content greater than 30 GB.       �
echo �  18: Prevent program from giving a drive itself as location in "Properties".�
echo �      Instead, it gives "My Computer".                                       �
echo �  19: Edit username and borders in case they or the current directory have   �
echo �      less than a particular amount of letters to prevent display corruption �
echo �                                                                             �
echo �  20: Prevention of crashing when editing a large file in the MS-Dos Editor  �
echo �      by widening the local memory by removing used variables.               �
echo �                                                                             �
echo �����������������������������������������������������������������������������ͼ
set /p .=
exit /b




 :Help_Customization
:Help_Customization
cls
set UserInput_Help=
echo �����������������������������������������������������������������������������ͻ
echo � Customization of the Batch Explorer                                         �
echo � �����������������������������������                                         �
echo �   1: Change the window's size                                               �
echo �   2: Change the icons of the folders                                        �& :: Z. 16 (24) und Z. 410 (418)
echo �   3: Change the output (the text) that is written in particular cases       �
echo �   4: Change the title of the file when executed                             �
echo �   5: Change the background and the font color                               �
echo �   6: Add folders to the System Overload                                     �& :: Z. 135 (143)
echo �                                                                             �
echo �                                                                             �
echo �����������������������������������������������������������������������������ͼ
set /p UserInput_Help=� 
	echo.
	echo.
if "%UserInput_Help%" == "1" (
	echo You can change the window's size via "Help > Window settings".
	echo To change the window's size while starting the file, you may start the file
	echo in Notepad++ and add below the TITLE-command the line familiar to
	echo "mode con cols=[Amount of columns (def: 80)] lines=[Amount of lines (def: 25)]"
	echo E.g. mode con cols=157 lines=80
	echo.
	echo cols=157 is full screen mode on 1280x1024 resolution.
	echo.
	echo The Batch Explorer requires 60 columns and 30 lines minimum.
	echo.
)
if "%UserInput_Help%" == "2" (
	echo You can change the icons of the folders by opening the file in Notepad++ and
	echo changing the values of the variables "FolderIcon_1" till "FolderIcon_4".
	echo.
	echo Remember to enter exactly 3 characters per variable, otherwise the display
	echo later on will be corrupted.
	echo.
	echo The variables are between the lines 16 to 19.
	echo.
	echo Warning: CMD does not view special characters the same as Notepad++. To get
	echo          a list of available characters with their Ascii codes, you may
	echo          have a look at the Batch dictionary by using "Help > Batch online".
	echo.
)
if "%UserInput_Help%" == "3" (
	echo To change the output in particular cases, you need to open this file in
	echo Notepad++. Press Ctrl+F to open the Search-function. Search the file for
	echo the lines/words you would like to change and press enter.
	echo.
	echo The lines/words have to be placed behind an ECHO-command.
	echo When found, you may change them as if you wanted to correct a mistake.
	echo.
	echo Make sure to keep the ECHO-commands and not to have more than 79 letters
	echo per line. Otherwise, the file might not work correctly.
	echo.
	echo Warning: If there are variables [written between %%%% or exclamation marks]
	echo          in the line, it is not recommended to change them.
	echo          Any changes may corrupt the display.
	echo.
)
if "%UserInput_Help%" == "4" (
	echo To change the title from the title bar, you need to open the file in
	echo Notepad++ and change the words behind the TITLE-command in line 2.
	echo.
	echo Make sure to keep the command itself.
	echo.
)
if "%UserInput_Help%" == "5" (
	echo To change the colors, you need to open the file in Notepad++ and change
	echo the hexadecimal code behind the COLOR-command in line 6.
	echo.
	echo To view possible code combinations, open CMD and enter "color /?".
	echo.
)
if "%UserInput_Help%" == "6" (
	echo To add folders to the System Overload [protection against too high calculating
	echo time], open the file in Notepad++ and direct to line 135.
	echo.
	echo To add folders from the Windows-directory, add their names into the parentheses
	echo between "IN" and "DO" from the FOR-command seperated from the other ones.
	echo.
	echo To add folders from other directories, copy one of the IF-commands below and
	echo paste it right below the other ones. Change the characters between the " "
	echo behind the == to the path you want to add.
	echo E.g:
	echo Change: if /i "%%%%~E" == "%%SystemRoot%%\Help" set Overload=1
	echo To:     if /i "%%%%~E" == "C:\Users\User\AppData\Local\Temp" set Overload=1
	echo.
)
pause
exit /b









 :Settings
:Settings
cls
set Delay=
set IncorrectSettings=
set MaximumLineAmountCON=
set Repition=
mode con
echo.
echo.
:: Languages in this order: German - English and Italian - French - Dutch - Polish - Portugese - Spanish x3 - Czech - Turkish x3
FOR /F "tokens=1,2 delims=: " %%A IN ('mode con') DO (
	if "%%A" == "Zeilen" set MaximumLineAmountCON=%%B
	if "%%A" == "Lines" set MaximumLineAmountCON=%%B
	if "%%A" == "Lignes" set MaximumLineAmountCON=%%B
	if "%%A" == "Lijnen" set MaximumLineAmountCON=%%B
	if "%%A" == "Linie" set MaximumLineAmountCON=%%B
	if "%%A" == "Linhas" set MaximumLineAmountCON=%%B
	if "%%A" == "Lineas" set MaximumLineAmountCON=%%B
	if "%%A" == "L�neas" set MaximumLineAmountCON=%%B
	if "%%A" == "L�neas" set MaximumLineAmountCON=%%B
	if "%%A" == "Linky" set MaximumLineAmountCON=%%B
	if "%%A" == "Cizgyler" set MaximumLineAmountCON=%%B
	if "%%A" == "�izgyler" set MaximumLineAmountCON=%%B
	if "%%A" == "�izgyler" set MaximumLineAmountCON=%%B
)
echo !MaximumLineAmountCON! lines available
echo !Lines! lines used from Batch Explorer
echo.
echo !Cols! columns available
echo !Cols! columns used from Batch Explorer
echo.
echo.
echo --- If you do not want to change a particular setting, just press enter ---
set /p    Lines=New amount of lines:   
set /p     Cols=New amount of columns: 
set /p Repition=New repition rate:     
set /p    Delay=New delay:             

echo.
echo.
set /a Lines=!Lines!
set /a Cols=!Cols!
set /a Repition=!Repition! 2>nul
set /a Delay=!Delay! 2>nul

if "!Lines!" == "0" (
	echo The amount of lines is not possible. The settings will be reset.
	pause
	set IncorrectSettings=1
)
if not "!IncorrectSettings!" == "1" if "!Cols!" == "0" (
	echo The amount of columns is not possible. The settings will be reset.
	pause
	set IncorrectSettings=1
)
if "!IncorrectSettings!" == "1" (call :Check_WindowSettings) ELSE (
	mode con lines=!Lines!
	mode con cols=!Cols!
	if not "!Repition!" == "" mode con rate=!Repition!
	if not "!Delay!" == ""  mode con delay=!Delay!
)
pause
exit /b



 :About
:About
cls
echo �����������������������������������������������������������������������������ͻ
echo � About Batch Explorer                                                        �
echo � ��������������������                                                        �
echo �   � Copyright 2011 GrellesLicht28                                           �
echo �   This is a creation of Makroware �                                         �
echo �                                                                             �
echo �   All rights reserved.                                                      �
echo �                                                                             �
echo �                                                                             �
echo �                                                                             �
echo �   This file was created and designed by GrellesLicht28, a user from         �
echo �   Youtube.                                                                  �
echo �                                                                             �
echo �   It is intended to be an alternative to the default Windows Explorer. To   �
echo �   do so, it has a graphical interface allowing the user an easy overview.   �
echo �   It is also intended to be in use on computers that deny their users the   �
echo �   access to particular parts of the hard disk by passing some restrictions  �
echo �   from Windows by.                                                          �
echo �                                                                             �
echo �   This file was written from 27th Feb. 2011 to XX. May 2011.                �
echo �   It is based on Microsoft Windows XP Prof. SP3.                            �
echo �                                                                             �
set /p ".=����Press any key to continue . . .������������������������������������������ͼ" <nul
pause >nul
FOR /L %%A IN (1,1,79) DO set /p ".=" <nul
echo �                                                                             �
echo �   This program is free and open source. It can be edited and customized     �
echo �   easily. Any user has the permission to edit the file for inoffensive      �
echo �   purposes.                                                                 �
echo �                                                                             �
echo �   Online info and availability on                                           �
echo �                                                                             �
echo �       www.batchlog.pytalhost.com                                            �
echo �       ��������������������������                                            �
echo �����������������������������������������������������������������������������ͼ
set /p ".="
exit /b