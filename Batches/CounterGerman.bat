@echo off 
:start
echo Geben Sie die zu beginnende Zahl ein.
set /p Zahl=
echo Soll hoch oder runtergezaehlt werden?
set /p hoch_runter=
if /I "%hoch_runter%" == "hoch" goto :hoch
if /I "%hoch_runter%" == "runter" goto :runter
cls
goto :start

:hoch
echo Um wie viel soll immer hochgezaehlt werden?
set /p plus=
echo Wie lange sollen die Pausen sein (Sekunden+1)?
set /p sek=
echo Bis wie viel soll gezaehlt werden?
set /p hoch_e=
echo.
echo %Zahl%
:hoch_start
set /a Zahl=%Zahl% +%plus%
echo %Zahl%
if %sek% GTR 1 ping localhost -n %sek% >nul
if %Zahl% GEQ %hoch_e% goto :Ende_hoch
goto :hoch_start

:Ende_hoch
echo Das Zaehlwerk ist am Ende angelangt.
pause
EXIT

:runter
echo Um wie viel soll immer runtergezaehlt werden?
set /p minus=
echo Wie lange sollen die Pausen sein (Sekunden+1)?
set /p sek=
echo Bis wie viel soll gezaehlt werden?
set /p runter_e=
echo.
echo %Zahl%
ping localhost -n %sek% >nul
:runter_start
set /a Zahl=%Zahl% -%minus%
echo %Zahl%
if %sek% GTR 1 ping localhost -n %sek% >nul
if %Zahl% LEQ %runter_e% goto :Ende_runter
goto :runter_start

:Ende_runter
echo Das Zaehlwerk ist am Ende angelangt.
pause
EXIT