@echo off
REM (C) Copyright 2010 GrellesLicht28 / S1r1us13
REM This is a creation of Makroware.
title Speed Count - BatchGame
setlocal enabledelayedexpansion
pushd %temp%
if not exist "BatchGame-Highscore-Easy.tmp" call :Highscores-Create Easy
if not exist "BatchGame-Highscore-Medium.tmp" call :Highscores-Create Medium
if not exist "BatchGame-Highscore-Heavy.tmp" call :Highscores-Create Heavy
if "%1" == "StartGame25" goto :%1
if "%1" == "StartGame100" goto :%1
if "%1" == "StartGame400" goto :%1
if "%1" == "Guess" goto :%1
set Level=Medium

:Menu
cls
set Choice=
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º   Find the place of the block     º
echo ÌÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¹
echo º 1: Instructions                   º
echo º 2: Start game                     º
echo º 3: Highscores                     º
echo º 4: Reset highscores               º
echo º                                   º
echo º (C) Copyright 2010 GrellesLicht28 º
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /p Choice=Choice: 
if "%Choice%" == "1" goto :Instructions
if "%Choice%" == "2" goto :StartGame
if "%Choice%" == "3" call :Highscores
if "%Choice%" == "4" call :Delete-Highscores
echo.
pause
goto :Menu




:Instructions
echo.
echo Depending on the difficulty there are 25, 100 or 400 places on game play.
echo One of them contains a block. The placed are counted from upper left to 
echo lower right.
echo.
echo The aim of the game is to write the result within 3 seconds into the smaller
echo window. If you were fast enough, it is counted as one point.
echo.
echo To end the game, enter "End".
echo.
pause
set Call=
set Amount=1
echo.
FOR /L %%A IN (11,1,100) DO set Call=!Call!%%A 
echo The places have the following positions:
echo îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî
echo { 1} { 2} { 3} { 4} { 5} { 6} { 7} { 8} { 9} {10}
echo.
call :Display100 %Call%
pause
goto :Menu






:StartGame
set Level=
set Levelchoice=
set Speed=
set Speedchoice=
echo.
echo Which difficulty would you like to play?
echo 1: Easy   ( 25 boxes)
echo 2: Medium (100 boxes)
echo 3: Heavy  (400 boxes)
echo.
set /p Levelchoice=Choice: 
if "%Levelchoice%" == "1" set Level=Easy
if "%Levelchoice%" == "2" set Level=Medium
if "%Levelchoice%" == "3" set Level=Heavy
if /i "%Levelchoice%" == "Easy" set Level=Easy
if /i "%Levelchoice%" == "Medium" set Level=Medium
if /i "%Levelchoice%" == "Heavy" set Level=Heavy
if not defined Level (
	echo Wrong prompt.
	pause
	goto :Menu
)
echo.
echo Which speed level would you like to play?
echo 1: Very slow (5 seconds to guess)
echo 2: Slow      (4 seconds to guess)
echo 3: Middle    (3 seconds to guess) [Default]
echo 4: Fast      (2 seconds to guess)
echo 5: Very fast (1 second to guess)
echo.
set /p Speedchoice=
if "%Speedchoice%" == "1" set Speed=6
if "%Speedchoice%" == "2" set Speed=5
if "%Speedchoice%" == "3" set Speed=4
if "%Speedchoice%" == "4" set Speed=3
if "%Speedchoice%" == "5" set Speed=2
if not defined Speed (
	echo Wrong prompt.
	pause
	goto :Menu
)
if "%Level%" == "Easy" start %~s0 StartGame25 %Speed%
if "%Level%" == "Medium" start %~s0 StartGame100 %Speed%
if "%Level%" == "Heavy" start %~s0 StartGame400 %Speed%
pause
goto :Menu









:StartGame25
set KA=(
set KZ=)
if "%2" == "6" set Speed=[Very slow]
if "%2" == "5" set Speed=[Slow]
if "%2" == "4" set Speed=[Middle]
if "%2" == "3" set Speed=[Fast]
if "%2" == "2" set Speed=[Very fast]
set Level=Easy
set Points=0
start %~s0 Guess

:Start25
cls
set Call=
set Amount=0
set Prompt=26
set Aim=
set Number=%random:~1,2%
if "%Number:~0,1%" == "0" set Number=%Number:~1,1%
if not "%Number:~1,1%" == "" if "%Number:~0,1%" GTR "2" (goto :Start25) ELSE (if "%Number:~0,1%" EQU "2" if "%Number:~1,1%" GTR "4" goto :Start25)
set /a Aim=!Number! + 1
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 
set /a Number=25 - %Number%
set Call=!Call!Û 
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 

call :Display25 %Call%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Prompt=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Prompt%') DO set Prompt=%%A
if /i "!Prompt!" == "End" goto :Evaluation

set /a Prompt=!Prompt!
set /a Aim=!Aim!
echo %Aim% - !Prompt!
if "!Prompt!" == "!Aim!" (
	echo.
	echo Your answer was correct.
	ping localhost -n 2 >nul
	set /a Points=!Points! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start25


:Display25
shift /0
echo {%0} {%1} {%2} {%3} {%4}
shift /0
shift /0
shift /0
shift /0
echo.
set /a Amount=%Amount% + 1
if "%Amount%" == "5" exit /b
goto :Display25






:StartGame100
set KA=(
set KZ=)
if "%2" == "6" set Speed=[Very slow]
if "%2" == "5" set Speed=[Slow]
if "%2" == "4" set Speed=[Middle]
if "%2" == "3" set Speed=[Fast]
if "%2" == "2" set Speed=[Very fast]
set Level=Medium
set Points=0
start %~s0 Guess

:Start100
cls
set Call=
set Amount=0
set Prompt=101
set Aim=
set Number=%random:~1,2%
if "%Number:~0,1%" == "0" set Number=%Number:~1,1%
set /a Aim=!Number! + 1
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 
set /a Number=100 - %Number%
set Call=!Call!Û 
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 

call :Display100 %Call%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Prompt=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Prompt%') DO set Prompt=%%A
if /i "!Prompt!" == "End" goto :Evaluation

set /a Prompt=!Prompt!
set /a Aim=!Aim!
echo %Aim% - !Prompt!
if "!Prompt!" == "!Aim!" (
	echo.
	echo Your answer was correct.
	ping localhost -n 2 >nul
	set /a Points=!Points! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start100


:Display100
shift /0
echo {%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
echo.
set /a Amount=%Amount% + 1
if "%Amount%" == "10" exit /b
goto :Display100






:StartGame400
set KA=(
set KZ=)
if "%2" == "6" set Speed=[Very slow]
if "%2" == "5" set Speed=[Slow]
if "%2" == "4" set Speed=[Middle]
if "%2" == "3" set Speed=[Fast]
if "%2" == "2" set Speed=[Very fast]
set Level=Heavy
set Points=0
mode con lines=46
start %~s0 Guess

:Start400
cls
set Call=
set Amount=0
set Prompt=401
set Aim=
set Number=%random:~1,3%
if "%Number:~0,1%" == "0" set Number=%Number:~1,2%
if "%Number:~0,1%" == "0" set Number=%Number:~1,1%
if not "%Number:~2,1%" == "" if "%Number:~0,1%" GEQ "4" goto :Start400
set /a Aim=!Number! + 1
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 
set /a Number=400 - %Number%
set Call=!Call!Û 
FOR /L %%A IN (1,1,%Number%) DO set Call=!Call!- 

call :Display400 %Call%

ping localhost -n %2 >nul
if exist BatchGame.tmp set /p Prompt=<BatchGame.tmp >nul 2>&1
FOR /F "usebackq" %%A IN ('%Prompt%') DO set Prompt=%%A
if /i "!Prompt!" == "End" goto :Evaluation

set /a Prompt=!Prompt!
set /a Aim=!Aim!
echo %Aim% - !Prompt!
if "!Prompt!" == "!Aim!" (
	echo.
	echo Your answer was correct.
	ping localhost -n 2 >nul
	set /a Points=!Points! + 1
)

if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
goto :Start400


:Display400
set Display=
shift /0
set Display={%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
set Display=%Display% {%0} {%1} {%2} {%3} {%4} {%5} {%6} {%7} {%8} {%9}
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
shift /0
echo %Display%
echo.
set /a Amount=%Amount% + 1
if "%Amount%" == "20" exit /b
goto :Display400








:: %%A = Entire line of a file
:: %%D = Difference between the current amount of points and the one from the last highscore
:: %%S = Set rank
:: %%M = Move ranking
:: ---> Moves rank 1 to rank 2 and rank 2 to rank 3 etc.
:: %%O = Deductive from alphabet (...L, M, N, O, P...)
:: ---> %%O is all from %%A behind the colon (First place:  %%O)

::     ---> First place:  Username (20 points) on 26.12.2010 at 20:00:00,00 [Fast]
::		  = First place:  %username% !KA!%Points% points!KZ! on %time% at %date% %Speed%
::		  = %%A
::		  = %%M %%N:  %%O


:Evaluation
cls
FOR /F "delims=" %%A IN (BatchGame-Highscore-%Level%.tmp) DO (
	FOR /F "tokens=4 delims=( " %%D IN ("%%A") DO set /a Difference=%Points% - %%D >nul 2>nul || set Difference=
	if not "!Difference:~0,1!" == "-" if "!Rank!" == "" FOR /F %%S IN ("%%A") DO set Rank=%%S
)
if "!Rank!" == "" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	set Highscore=%%O
	if "!Highscore!" == "" (
		if "%%M" == "First" set Rank=First
		if "!Rank!" == "" if "%%M" == "Second" set Rank=Second
		if "!Rank!" == "" if "%%M" == "Third" set Rank=Third
	)
)
if "!Rank!" == "First" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	set First=First place:  %username% !KA!%Points% points!KZ! on %date% at %time% %Speed%
	if "%%M" == "First" set Second=Second place: %%O
	if "%%M" == "Second" set Third=Third place:  %%O
)
if "!Rank!" == "Second" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "First" set First=First place:  %%O
	set Second=Second place: %username% !KA!%Points% points!KZ! on %date% at %time% %Speed%
	if "%%M" == "Second" set Third=Third place:  %%O
)
if "!Rank!" == "Third" FOR /F "tokens=1,2,* delims=: " %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "First" set First=First place:  %%O
	if "%%M" == "Second" set Second=Second place: %%O
	set Third=Third place:  %username% !KA!%Points% points!KZ! on %date% at %time% %Speed%
)
if "!Rank!" == "" FOR /F "tokens=1,*" %%M IN (BatchGame-Highscore-%Level%.tmp) DO (
	if "%%M" == "First" set First=First %%N
	if "%%M" == "Second" set Second=Second %%N
	if "%%M" == "Third" set Third=Third %%N
)
echo !First!>BatchGame-Highscore-%Level%.tmp
echo !Second!>>BatchGame-Highscore-%Level%.tmp
echo !Third!>>BatchGame-Highscore-%Level%.tmp
if exist BatchGame.tmp del /F BatchGame.tmp >nul 2>&1
exit







:Highscores
cls
echo Highscores
echo îîîîîîîîîî
echo  -^> Easy
echo     îîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Easy.tmp) DO echo     ú%%A
echo.
echo  -^> Medium
echo     îîîîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Medium.tmp) DO echo     ú%%A
echo.
echo  -^> Heavy
echo     îîîîî
FOR /F "delims=" %%A IN (BatchGame-Highscore-Heavy.tmp) DO echo     ú%%A
exit /b



:Delete-Highscores
set Delete=
cls
echo Which highscore list would you like to reset?
echo 1: Grade easy
echo 2: Grade medium
echo 3: Grade heavy
echo.
set /p Delete=Choice: 
if "%Delete%" == "1" set Grade=Easy
if "%Delete%" == "2" set Grade=Medium
if "%Delete%" == "3" set Grade=Heavy
if defined Grade call :Highscores-Create %Grade%
exit /b














:Guess
title Game
mode con cols=14 lines=6
:Guess_2
cls
echo **********
set /p Place=Place: 
echo **********
echo %Place% 1>BatchGame.tmp
if /i "%Place%" == "End" exit
goto :Guess_2









:Highscores-Create
echo First place:  >BatchGame-Highscore-%1.tmp
echo Second place: >>BatchGame-Highscore-%1.tmp
echo Third place:  >>BatchGame-Highscore-%1.tmp
exit /b