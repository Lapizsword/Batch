@echo off
REM Quelle www.source-center.de
Title Process Manager
SETLOCAL ENABLEDELAYEDEXPANSION
PUSHD "%TEMP%"
set SPW=0
set offset=
set sorder=
set osetpid=27
set osetmem=60
set osetcpu=141

:Reload
cls
set num=0
echo -----------------------------------------------
echo [Process Name]      [PID]       [MEM] [CPUTime]
echo -----------------------------------------------
if not defined NAME set NAME=All
if "!NAME!" == "All" (
tasklist /FO TABLE /NH /V | SORT !offset! !sorder! >"plist.txt"
) else (
tasklist /FI "USERNAME eq !NAME!" /FO TABLE /NH /V | SORT !offset! !sorder! >"plist.txt"
)
for /f "tokens=*" %%a in (plist.txt) do (
set /a num+=1
set tempvar=%%a
if "!tempvar:~34,1!" == " " (
set "list=!tempvar:~0,20! !tempvar:~29,5! !tempvar:~66,9!K!tempvar:~147,10!"
set osetpid=29
set osetmem=66
set osetcpu=147
) else (
set "list=!tempvar:~0,20! !tempvar:~27,5! !tempvar:~60,9!K!tempvar:~141,10!"
set osetpid=27
set osetmem=60
set osetcpu=141
)
echo !list!
)
:Reload_End
del /F "plist.txt" >nul 2>&1
echo.
echo ----------------------------------------------
if "!NAME!"=="All" (
echo All processes - [!num!] Processes running
) else (
echo !NAME! - [!num!] Processes running
)
echo ----------------------------------------------
echo.
if not defined ac (
if /i "!NAME!"=="%username%" goto :MNG
if /i "!NAME!"=="SYSTEM" goto :MNG
if /i "!NAME!"=="All" goto :MNG
)
if /i "!ac!"=="A" set NAME=
if /i "!ac!"=="U" set NAME=%username%
if /i "!ac!"=="S" set NAME=SYSTEM
if /i "!ac!"=="T" goto :SPW
if /i "!ac!"=="E" goto :Explore
if /i "!ac!"=="K" goto :Kill
if /i "!ac!"=="M" goto :SMEM
if /i "!ac!"=="N" goto :SNAME
if /i "!ac!"=="P" goto :SPID
if /i "!ac!"=="X" EXIT
set ac=
goto :Reload


:MNG
echo Options:
echo  Sort by:    N=Name, P=PID,     M=MEM
echo  Show procs: A=All,  S=System,  U=User, T=Paths
echo  Functions:  K=Kill, E=Explore, X=Exit
set /p ac=Manage : 
if "!SPW!" == "1" goto :EOF
goto :Reload

:SPW
set SPW=1
cls
wmic process get ExecutablePath,ProcessID
echo.
call :MNG
if /i "!ac!"=="E" set SPW=0&&goto :Explore
if /i "!ac!"=="K" set SPW=0&&goto :Kill
set SPW=0
goto :Reload


:Kill
echo Type PID to Kill.
set /p PID=PID: 
if not defined PID (
set ac=
goto :Reload
)
taskkill /F /PID !PID! >nul 2>&1
if errorlevel 1 (echo No task running with this PID.) else (
if !PID! geq 0 if !PID! lss 10 (
echo Cannot kill a critical process.
goto :clr_var
) else (
echo Success: Task with PID=!PID!
echo 	      has been terminated.
))
:clr_var
set ac=
set PID=
set exepath=
del /F "path.txt" >nul 2>&1
pause >nul
goto :Reload

:Explore
echo Type PID to explore.
set /p PID=PID: 
if not defined PID (
set ac=
goto :Reload
)
if !PID! lss 10 goto :clr_var
if !PID! gtr 10000 goto :clr_var
wmic process get ProcessID,ExecutablePath | find " !PID!" >"path.txt"
for /f "delims=" %%a in (path.txt) do (
set tempvar=%%a
for /f "delims=" %%b in ("!tempvar!") do set exepath=%%~dpb
)
if not defined exepath (
echo No task running with this PID.
pause >nul
) else (
explorer ""!exepath!""
)
goto :clr_var

:SNAME
set offset=
set sorder=
set ac=
goto :Reload

:SPID
set offset=/+!osetpid!
set sorder=
set ac=
goto :Reload

:SMEM
set offset=/+!osetmem!
set sorder=/R
set ac=
goto :Reload