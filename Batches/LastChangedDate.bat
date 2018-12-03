:: ************************************************************************
:: * File found on http://www.dostips.com under category "DateAndTime"    *
:: * Originally created at 01/01/2006                                     *
:: * Originally last changed at 22/03/2009                                *
:: * Edited at 30/09/2010 by GrellesLicht28                               *
:: * --- New functions:                                                   *
:: *     --- Better overview                                              *
:: *     --- Sort itself                                                  *
:: ************************************************************************

@echo off
	if not "%~0" == "%~nx0" if not "%~0" == "%~n0" TITLE When has which file been changed last time?
	setlocal EnableExtensions
	setlocal EnableDelayedExpansion
	if not "%~1" == "Sortmode" mode con lines=512

:: Change this value to "1" to enable sortmode (takes more time)
	set Sortmode=0

:: Check if sortmode is activated. If so, it sorts its own output using "sort"
	if "%~1" == "Sortmode" goto :Startfunction
	if "%Sortmode%" == "1" (
		echo Sortmode activated.
		echo ооооооооооооооооооо
	)
	if "%Sortmode%" == "1" %~nx0 Sortmode|sort /+55 
	if "%Sortmode%" == "1" goto :Endfunction


:Startfunction
call:jdate tnow "%date%"
for /F "delims=" %%F in ('dir /A /B /S *.*') do (
    call:ftime tfile "%%F"
    set /a diff=tnow-tfile
	set file=%%~nxF
	FOR /L %%A IN (2,1,50) DO if "!file:~%%A,1!" == "" set file=!file! 
	FOR /L %%A IN (1,1,3) DO if "!diff:~%%A,1!" == "" set diff= !diff!
    echo !file! is !diff! days old
)

:Endfunction
ECHO.
if not "%~0" == "%~nx0" if not "%~0" == "%~n0" PAUSE
EXIT /B


::-----------------------------------------------------------------------------------
::-- Functions start below here
::-----------------------------------------------------------------------------------


:ftime JD filename attr -- returns the file time in julian days
::                      -- JD    [out]    - valref file time in julian days
::                      -- attr  [in,opt] - time field to be used, creation/last-access/last-write, see 'dir /?', i.e. /tc, /ta, /tw, default is /tw
:: $created 20060101 :$changed 20090322 :$categories DateAndTime
:: $source http://www.dostips.com
SETLOCAL
set file=%~2
set attr=%~3
if not defined attr (call:jdate JD "- %~t2"
) ELSE (for /f %%a in ('"dir %attr% /-c "!file!"|findstr "^^[0-9]""') do call:jdate JD "%%a")
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo.%JD%)
)
EXIT /b


:jdate JD DateStr -- converts a date string to julian day number with respect to regional date format
::                -- JD      [out,opt] - julian days
::                -- DateStr [in,opt]  - date string, e.g. "03/31/2006" or "Fri 03/31/2006" or "31.3.2006"
:: $reference http://groups.google.com/group/alt.msdos.batch.nt/browse_frm/thread/a0c34d593e782e94/50ed3430b6446af8#50ed3430b6446af8
:: $created 20060101 :$changed 20080219
:: $source http://www.dostips.com
SETLOCAL
set DateStr=%~2&if "%~2"=="" set DateStr=%date%
for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('"echo.|date"') do (
    for /f "tokens=1-3 delims=/.- " %%A in ("%DateStr:* =%") do (
        set %%a=%%A&set %%b=%%B&set %%c=%%C))
set /a "jj=10000%jj% %%10000,mm=100%mm% %% 100,tt=100%tt% %% 100"
set /a JD=tt-32075+1461*(jj+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((jj+4900+(mm-14)/12)/100)/4
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo.%JD%)
EXIT /b