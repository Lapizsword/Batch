:: Header
	@echo off
	setlocal EnableDelayedExpansion
	
	:: Enable / Disable moving into the system folder
	:: Change this value to "0" to disable moving into the system folder
	set MoveToSystemFolder=0
	
	
	
	if "%MoveToSystemFolder%" == "0" goto :UserInput
	:: Check if directory is system32 or system64. If not, TABLE.BAT moves into these folders.
		if /i "%~0" == "%~nx0" goto :UserInput
		if /i "%~0" == "%~n0" goto :UserInput
		if exist "%SystemRoot%\system32" if /i "%~0" == "%SystemRoot%\system32\%~nx0" goto :UserInput
		if exist "%SystemRoot%\system64" if /i "%~0" == "%SystemRoot%\system64\%~nx0" goto :UserInput

		(
		if exist "%SystemRoot%\system32" move /Y "%~0" "%SystemRoot%\system32\Table.bat"
		if errorlevel 1 ping localhost -n 2 >nul
		if exist "%SystemRoot%\system64" move /Y "%~0" "%SystemRoot%\system64\Table.bat"
		if errorlevel 1 ping localhost -n 2 >nul
		start cmd /k Table.bat /?
		exit
		)
	:: END
:: END



:UserInput
	if /i "%~0" == "%~nx0" set CommandLine=%~nx0 %*
	if /i "%~0" == "%~n0"  set CommandLine=%~nx0 %*
	if not defined CommandLine (
		echo *** Batch Table Maker ***
		echo.
		echo Please enter the following information:
		echo ооооооооооооооооооооооооооооооооооооооо
		echo The numbers in paranthesis are the default values.
		echo.
		set /p          ConCols=CMD columns [80]:     
		set /p        TableCols=Table columns [1]:    
		set /p        TableRows=Table rows [1]:       
		set /p TableLinesPerRow=Lines per row [20]:   
		set /p      MaxConLines=Max. CMD lines [300]: 
		set /p    DoubleBorders=Border lines [Y/N]:   
		
		if /i "!DoubleBorders!" == "y" set DoubleBorders=1
		if /i "!DoubleBorders!" == "yes" set DoubleBorders=1
		echo.
	)
	
	
	:: Set border lines
		echo !CommandLine! | find /i "-DoubleBorders" >nul 2>nul && set DoubleBorders=1
		if "!DoubleBorders!" == "1" (
			:: Ascii codes are used in this order: 0201, 0187, 0200, 0188, 0186, 0205, 0203, 0202, 0204, 0185, 0206
			set UpperLeftCorner=Й
			set UpperRightCorner=»
			set LowerLeftCorner=И
			set LowerRightCorner=ј
			set HorizontalBorder=Н
			set VerticalBorder=є
			set UpperCross=Л
			set LowerCross=К
			set LeftCross=М
			set RightCross=№
			set Cross=О
		) ELSE (
			:: Ascii codes are used in this order: 0218, 0191, 0192, 0217, 0196, 0179, 0194, 0193, 0195, 0180, 0197
			set UpperLeftCorner=Ъ
			set UpperRightCorner=ї
			set LowerLeftCorner=А
			set LowerRightCorner=Щ
			set HorizontalBorder=Д
			set VerticalBorder=і
			set UpperCross=В
			set LowerCross=Б
			set LeftCross=Г
			set RightCross=ґ
			set Cross=Е
		)
		set DoubleBorder=
	:: END
	
	
	if "!CommandLine!" == "" goto :Calculation
	echo !CommandLine! | find "/?"      >nul 2>nul && goto :Syntax
	echo !CommandLine! | find /i "help" >nul 2>nul && goto :Syntax
	set Counter=0
:: END





:: Analyzing the command line
:Analysis
	if /i "!CommandLine:~%Counter%,8!" == "ConCols:" (
		set Part=!CommandLine:~%Counter%,11!
		set Part=!Part:~8,3!
		FOR %%C IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z - _ . ,) DO set Part=!Part:%%C=!
		set /a ConCols=!Part!
		set Part=
	)
	if /i "!CommandLine:~%Counter%,10!" == "TableCols:" (
		set Part=!CommandLine:~%Counter%,13!
		set Part=!Part:~10,3!
		FOR %%C IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z - _ . ,) DO set Part=!Part:%%C=!
		set /a TableCols=!Part!
		set Part=
	)
	if /i "!CommandLine:~%Counter%,10!" == "TableRows:" (
		set Part=!CommandLine:~%Counter%,13!
		set Part=!Part:~10,3!
		FOR %%C IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z - _ . ,) DO set Part=!Part:%%C=!
		set /a TableRows=!Part!
		set Part=
	)
	if /i "!CommandLine:~%Counter%,17!" == "TableLinesPerRow:" (
		set Part=!CommandLine:~%Counter%,20!
		set Part=!Part:~17,3!
		FOR %%C IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z - _ . ,) DO set Part=!Part:%%C=!
		set /a TableLinesPerRow=!Part!
		set Part=
	)
	if /i "!CommandLine:~%Counter%,12!" == "MaxConLines:" (
		set Part=!CommandLine:~%Counter%,17!
		set Part=!Part:~12,5!
		FOR %%C IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z - _ . ,) DO set Part=!Part:%%C=!
		set /a MaxConLines=!Part!
		set Part=
	)
	if "!CommandLine:~%Counter%,1!" == "" goto :Calculation
	set /a Counter=%Counter% + 1
goto :Analysis
:: End of analyzing the command line





:Calculation
:: Set necessary values if not given
	if "!ConCols!" == "" set ConCols=80
	if "!TableCols!" == "" set TableCols=1
	if "!TableRows!" == "" set TableRows=1
	if "!TableLinesPerRow!" == "" set TableLinesPerRow=20
	if "!MaxConLines!" == "" set MaxConLines=300
:: END


:: Calculating the columns
	set /a TempTableCols=!TableCols! - 3
	if "!TempTableCols:~0,1!" == "-" (set BorderLineAmount=4) ELSE (set /a BorderLineAmount=4 + !TableCols! - 3)
	set TempTableCols=
	set /a TotalFreeSpace=!ConCols! - !BorderLineAmount! - 1
	set /a FreeSpaceEachCol=!TotalFreeSpace! / !TableCols!
	set /a FreeSpaceLeft=!TotalFreeSpace! - ( !FreeSpaceEachCol! * !TableCols! )
	if "!FreeSpaceLeft!" GEQ "2" (
		set /a FreeSpaceAtLeftSideAvailable=!FreeSpaceLeft! - 1
		echo There are !FreeSpaceAtLeftSideAvailable! places left. How many places would you like to move the
		set /p Move=table to the right? - 
		set /a TempMove=!FreeSpaceAtLeftSideAvailable! - !Move!
		if "!TempMove:~0,1!" == "-" (
			echo There is not enough space to move the table that far. It is not moved.
			set Move=0
		)
		set TempMove=
		if not "!Move!" == "0" FOR /L %%A IN (1,1,!Move!) DO set SpaceAtLeftSide= !SpaceAtLeftSide!
	)
:: END

:: Calculating the rows and lines
	set /a TotalTableLines=( !TableRows! * ( !TableLinesPerRow! + 1 ) ) + 1
	if not "!MaxConLines!" == "" (
		set /a LeftLines=!MaxConLines! - !TotalTableLines!
		if "!LeftLines:~0,1!" == "-" (
			echo The command prompt window does not have enough lines to display the whole
			echo table. You may either decrease the "table rows" or the "table lines per row"
			echo or increase the total amount of lines of the window.
			pause
			exit /b
		)
		set LeftLines=
	)
:: END

:: Output
	echo.
	echo ConCols:          !ConCols!
	echo TableCols:        !TableCols!
	echo TableRows:        !TableRows!
	echo TableLinesPerRow: !TableLinesPerRow!
	echo MaxConLines:      !MaxConLines!
	echo ---------
	echo Cell space:       !FreeSpaceEachCol! per cell
	if not "!Move!" == "" echo Moves to right:   !Move!
:: END


:: Create table
	:: Setting borders that divide up the lines
		FOR /L %%A IN (1,1,!FreeSpaceEachCol!) DO (
			set BorderCol=!BorderCol!!HorizontalBorder!
			set SpaceCol= !SpaceCol!
		)
		set /a TempTableCols=!TableCols! - 1
		FOR /L %%A IN (1,1,!TempTableCols!) DO (
			set FinalBorderCol=!FinalBorderCol!!BorderCol!!Cross!
			set FinalSpaceCol=!FinalSpaceCol!!SpaceCol!!VerticalBorder!
			set UpperBorder=!UpperBorder!!BorderCol!!UpperCross!
			set LowerBorder=!LowerBorder!!BorderCol!!LowerCross!
		)
		set FinalBorderCol=!LeftCross!!FinalBorderCol!!BorderCol!!RightCross!
		set FinalSpaceCol=!VerticalBorder!!FinalSpaceCol!!SpaceCol!!VerticalBorder!
		set UpperBorder=!UpperLeftCorner!!UpperBorder!!BorderCol!!UpperRightCorner!
		set LowerBorder=!LowerLeftCorner!!LowerBorder!!BorderCol!!LowerRightCorner!
		set TempBorderCol=
		set TempSpaceCols=
	:: END
	
	
	set CurrentDirectory=%cd%
	cd /D "%temp%"
	:: Write table into a .TMP-file in the temporary directory
		echo Copy the code below into a batch file to generate the table.>BatchTableMaker.tmp
		echo.>>BatchTableMaker.tmp
		echo.>>BatchTableMaker.tmp
		echo echo !SpaceAtLeftSide!!UpperBorder!>>BatchTableMaker.tmp
		set /a TempTableRows=!TableRows! - 1
		FOR /L %%A IN (1,1,!TempTableRows!) DO (
			FOR /L %%B IN (1,1,!TableLinesPerRow!) DO echo echo !SpaceAtLeftSide!!FinalSpaceCol!
			echo echo !SpaceAtLeftSide!!FinalBorderCol!
		)>>BatchTableMaker.tmp
		FOR /L %%B IN (1,1,!TableLinesPerRow!) DO echo echo !SpaceAtLeftSide!!FinalSpaceCol!>>BatchTableMaker.tmp
		echo echo !SpaceAtLeftSide!!LowerBorder!>>BatchTableMaker.tmp
		set TempTableRows=
	:: END
	start notepad.exe BatchTableMaker.tmp
	cd /D "%CurrentDirectory%"
:: END
echo.
endlocal
if "%~0" == "%~f0" PAUSE
exit /B




:Syntax
	echo.
	echo Creates a table in ascii-format to be executed as a batch file.
	echo.
	echo The opened text document contains source code that has to be saved in Notepad
	echo and be executed in CMD by e.g. the ECHO-command.
	echo.
	echo.
	echo Syntax:
	echo ооооооо
	echo TABLE.BAT -ConCols:NNN -TableCols:NNN -TableRows:NNN -TableLinesPerRow:NNN
	echo           [ -MaxConLines:NNN] [ -DoubleBorders ]
	echo TABLE.BAT [ /? ^| help ]
	echo.
	echo.
	echo -ConCols:NNN            - Amount of columns from the CMD-window (Default:  80)
	echo -TableCols:NNN          - Amount of columns in the table        (Default:   1)
	echo -TableRows:NNN          - Amount of rows in the table           (Default:   1)
	echo -TableLinesPerRow:NNN   - Amount of lines per cell              (Default:  20)
	echo -MaxConLines:NNN        - Maximum lines from the CMD-window     (Default: 300)
	echo -DoubleBorders          - Using double lines as borders
	echo help  or  /?            - View this information
	echo.
	echo.
	echo If one of the parameters is not used, it will be set to the default value.
	if "%~0" == "%~f0" PAUSE
	echo.
	endlocal
exit /B