@echo off
title How to save settings in batch
pushd "%temp%"
if exist "GameSettings.ini" (
	FOR /F "tokens=1,2 delims==" %%A IN (GameSettings.ini) DO (
		if "%%A" == "Level" set Level=%%B
		if "%%A" == "Money" set Money=%%B
	)
	set FirstPlay=0
)

:Menu
echo ÚÄÄÄÄ¿
echo ³Menu³
echo ÀÄÄÄÄÙ
echo Clicking game: Press enter to solve a level (very difficult).
if "%FirstPlay%" == "0" (
	echo You already played this game. You reached level %Level%. Do you wish to continue?
)
set /p Menu=
if /i "%Menu%" == "y" goto :%Level%
if /i "%Menu%" == "yes" goto :%Level%


set Money=%random%
:1
set /a Money=%Money%
echo Level=1 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You are now in level 1. Press enter to solve.
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:2
set /a Money=%Money%
echo Level=2 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 2. Go on pressing enter.
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:3
set /a Money=%Money%
echo Level=3 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 3. Does it get difficult now?
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:4
set /a Money=%Money%
echo Level=4 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 4. Well done, yet, but do you solve this level?
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:5
set /a Money=%Money%
echo Level=5 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 5. You are good :/
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:6
set /a Money=%Money%
echo Level=6 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 6. Do you see the rizzle?
echo You have got %Money% Euro.
pause >nul

set /a Money=%Money% + %random%
:7
set /a Money=%Money%
echo Level=7 1>GameSettings.ini
echo Money=%Money% 1>>GameSettings.ini
echo.
echo You reached level 7, the final one! This is the most difficult of all!
echo You have got %Money% Euro.
pause >nul
ping localhost -n 3 >nul
pause >nul


:Finish
set /a Money=%Money% + %random%
echo.
echo.
echo Congratulations! You finished level 7!
echo You got %Money% Euro in this game.
echo Press enter to exit.
del /F GameSettings.ini
popd
set /p Exit=
exit