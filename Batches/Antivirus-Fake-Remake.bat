@echo off
setlocal enabledelayedexpansion
set setlocal_enabledetailedcommanding=0
FOR /F "usebackq tokens=1,2 delims==" %%A IN (`assoc .QUA`) DO if "%%B" == "" assoc .qua=Quarantierte Datei
FOR /F "usebackq delims=" %%A IN ('%0') DO set Eigenpfad=%%~sA

if not exist "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED" md "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED"
if not exist "%userprofile%\Eigene Dateien\Antivirus 1.6\Logs" md "%userprofile%\Eigene Dateien\Antivirus 1.6\Logs"
cd /D "%userprofile%\Eigene Dateien\Antivirus 1.6\Logs"
if not exist "Ergnsse.ini" call :Ergnsse

if exist "Update.log" (FOR /F "usebackq tokens=1,5" %%A IN (Update.log) DO (
if "%%A" == "Update" set Update=%%B             
if "%%A" == "Kompletter" set Systemscan=%%B             
))
if not exist "Update.log" echo.>Update.log
if "!Update!" == "%date%             " (set Update=Heute                  ) ELSE (set Update=Noch nicht durchgefhrt)
if "!Systemscan!" == "%date%             " (set Systemscan=Heute                  ) ELSE (set Systemscan=Noch nicht durchgefhrt)
set Antivirusstatus=Aktiv                  
set Antivirusstatus2=Deaktivieren
set Firewallstatus=Aktiv                  
set Firewallstatus2=Deaktivieren
set Upgrade=Noch nicht durchgefhrt
set color=2a
if "!Update:~0,1!" == "H" (set Start=Start_Update) ELSE (set Start=Start)
set Quarantane=0
FOR /R "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED" %%A IN (*.*) DO set /a Quarantane=!Quarantane! +1

if not exist "Enstlngn.ini" call :Enstlngn

goto :!Start!


:Start
cls
set Wahl=
title Antivirus v1.6
color !color!
echo    Thema                          Status                    Befehl
echo.
echo 1: AntiVirus                      %Antivirusstatus%   %Antivirusstatus2%
echo 2: Letzte Systemberprfung       !Systemscan!   System jetzt prfen
echo 3: Letztes Update                 !Update!   Update starten
echo 4: Upgrade                        %Upgrade%   Upgrade auf Premium
echo 5: Ereignisse                                               Aufrufen
echo 6: Quarant„ne                     %Quarantane% Dateien                 Aufrufen
echo 7: Einstellungen
echo.
set /p Wahl=
if "%Wahl%" == "1" goto :Antivirus
if "%Wahl%" == "2" goto :Systemscan
if "%Wahl%" == "3" goto :Update
if "%Wahl%" == "4" goto :Upgrade
if "%Wahl%" == "5" goto :Ereignisse
if "%Wahl%" == "6" goto :Quarantane
if "%Wahl%" == "7" goto :Einstellungen
echo Befehl unbekannt.
pause
goto :!Start!









:Start_Update
cls
set Wahl=
title Antivirus v1.7
color !color!
echo    Thema                          Status                    Befehl
echo.
echo 1: AntiVirus                      %Antivirusstatus%   %Antivirusstatus2%
echo 2: Letzte Systemberprfung       !Systemscan!   System jetzt prfen
echo 3: Letztes Update                 !Update!   Update starten
echo 4: Upgrade                        %Upgrade%   Upgrade auf Premium
echo 5: Ereignisse                                               Aufrufen
echo 6: Quarant„ne                     %Quarantane% Dateien                 Aufrufen
echo 7: Einstellungen
echo 8: Firewall                       %Firewallstatus%   %Firewallstatus2%
echo 9: Backup                                                   Backup ziehen
echo 10:Windows Tools
echo.
set /p Wahl=
if "%Wahl%" == "1" goto :Antivirus2
if "%Wahl%" == "2" goto :Systemscan
if "%Wahl%" == "3" goto :Update
if "%Wahl%" == "4" goto :Upgrade
if "%Wahl%" == "5" goto :Ereignisse
if "%Wahl%" == "6" goto :Quarantane
if "%Wahl%" == "7" goto :Einstellungen
if "%Wahl%" == "8" goto :Firewall
if "%Wahl%" == "9" goto :Backup
if "%Wahl%" == "10" goto :Windows-Tools
echo Befehl unbekannt.
pause
goto :!Start!






:Antivirus
if "!color!" == "2a" (
set color=4c
echo Warnung                     Antivirus wurde deaktiviert.>>"Ergnsse.ini"
) ELSE (
set color=2a
echo Information                 Antivirus wurde aktiviert.>>"Ergnsse.ini"
)
if "!Antivirusstatus!" == "Aktiv                  " (set Antivirusstatus=Inaktiv                ) ELSE (set Antivirusstatus=Aktiv                  )
if "!Antivirusstatus2!" == "Deaktivieren" (set Antivirusstatus2=Aktivieren) ELSE (set Antivirusstatus2=Deaktivieren)
goto :!Start!




:Antivirus2
if "!color!" == "2a" (
set color2=2c
echo Warnung                     Antivirus wurde deaktiviert.>>"Ergnsse.ini"
)
if "!color!" == "4a" (
set color2=4c
echo Warnung                     Antivirus wurde deaktiviert.>>"Ergnsse.ini"
)
if "!color!" == "2c" (
set color2=2a
echo Information                 Antivirus wurde aktiviert.>>"Ergnsse.ini"
)
if "!color!" == "4c" (
set color2=4a
echo Information                 Antivirus wurde aktiviert.>>"Ergnsse.ini"
)
set color=!color2!
set color2=
if "!Antivirusstatus!" == "Aktiv                  " (set Antivirusstatus=Inaktiv                ) ELSE (set Antivirusstatus=Aktiv                  )
if "!Antivirusstatus2!" == "Deaktivieren" (set Antivirusstatus2=Aktivieren) ELSE (set Antivirusstatus2=Deaktivieren)
goto :!Start!







:Systemscan
if "!Start!" == "Start" (title Antivirus v1.6 - Systemscan) ELSE (title Antivirus v1.7 - Systemscan)
set Systemscan=Heute                  
echo Information                 Systemscan wurde durchgefhrt.>>"Ergnsse.ini"
cls
echo         System wird gescannt...                      0%%
echo     ²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      1%%
echo     ²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      2%%
echo     ²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      3%%
echo     ²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      4%%
echo     ²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      5%%
echo     ²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      6%%
echo     ²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      7%%
echo     ²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      8%%
echo     ²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      9%%
echo     ²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      10%%
echo     ²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      11%%
echo     ²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      12%%
echo     ²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      13%%
echo     ²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      14%%
echo     ²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      15%%
echo     ²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      16%%
echo     ²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      17%%
echo     ²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      18%%
echo     ²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      19%%
echo     ²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      20%%
echo     ²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      21%%
echo     ²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      22%%
echo     ²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      23%%
echo     ²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      24%%
echo     ²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      25%%
echo     ²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      26%%
echo     ²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      27%%
echo     ²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      28%%
echo     ²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      29%%
echo     ²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      30%%
echo     ²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      31%%
echo     ²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      32%%
echo     ²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      33%%
echo     ²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      34%%
echo     ²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      35%%
echo     ²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      36%%
echo     ²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      37%%
echo     ²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      38%%
echo     ²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      39%%
echo     ²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      40%%
echo     ²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      41%%
echo     ²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      42%%
echo     ²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      43%%
echo     ²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      44%%
echo     ²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      45%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      46%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      47%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      48%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      49%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      50%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      51%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      52%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      53%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      54%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 4 >nul
cls
echo         System wird gescannt...                      72%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      73%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      74%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      75%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      76%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      77%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      78%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      79%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      80%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      81%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      82%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      83%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      84%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      85%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      86%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      87%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      88%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      89%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      90%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      91%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      92%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      93%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      94%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      95%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      96%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      97%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      98%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      99%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
ping localhost -n 1 >nul
cls
echo         System wird gescannt...                      100%%
echo     ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ping localhost -n 1 >nul
cls
if exist "%userprofile%\Desktop\Eicar.com" set eicar=1
if exist "%userprofile%\Desktop\Eicar.txt" set eicar=1
if exist "%homedrive%\eicar.com" set eicar=1
if exist "%homedrive%\eicar.txt" set eicar=1
if exist "eicar.com" set eicar=1
if exist "eicar.txt" set eicar=1
echo Systemscan abgeschlossen.
if "!eicar!" == "1" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO if "%%A" == "Akustik" if "%%B" == "E" start /min sndrec32 /play /close "%SystemRoot%\Media\chord.wav"
echo Fund                        Malware wurde gefunden.>>"Ergnsse.ini"
echo Ein Virus wurde gefunden. Es handelt sich um
echo.
echo EICAR-Testvirus
echo.
echo.
echo Die Datei ist ungef„hrlich, gilt aber zum Testen von Antivirensoftware.
echo.
echo M”chten Sie die Datei trotzdem in die Quarant„ne verschieben? (J / N^)
) ELSE (
echo Es wurde kein Virus gefunden.
echo.
echo Mit Enter kommen Sie wieder zum Hauptmen.
)
set eicar=
set /p Viruswahl=
if /I "%Viruswahl%" == "y" set Move=1
if /I "%Viruswahl%" == "yes" set Move=1
if /I "%Viruswahl%" == "j" set Move=1
if /I "%Viruswahl%" == "ja" set Move=1
set Viruswahl=
if "!Move!" == "1" (
echo ---^> Virus wurde in die Quarant„ne verschoben.>>"Ergnsse.ini"
if exist "%userprofile%\Desktop\Eicar.com" (
move "%userprofile%\Desktop\Eicar.com" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.com.QUA"
set /a Quarantane=!Quarantane! +1
)
if exist "%userprofile%\Desktop\Eicar.txt" (
move "%userprofile%\Desktop\Eicar.txt" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.txt.QUA"
set /a Quarantane=!Quarantane! +1
)
if exist "%homedrive%\eicar.com" (
move "%homedrive%\eicar.com" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.com.QUA"
set /a Quarantane=!Quarantane! +1
)
if exist "%homedrive%\eicar.txt" (
move "%homedrive%\eicar.txt" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.txt.QUA"
set /a Quarantane=!Quarantane! +1
)
if exist "eicar.com" (
move "eicar.com" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.com.QUA"
set /a Quarantane=!Quarantane! +1
)
if exist "eicar.txt" (
move "eicar.txt" "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED\!Quarantane!eicar.txt.QUA"
set /a Quarantane=!Quarantane! +1
)
) ELSE (
echo ---^> Virus wurde ignoriert.>>"Ergnsse.ini"
)
set Move=
FOR /F "usebackq tokens=1-6" %%A IN (Update.log) DO (
if "%%A" == "Kompletter" echo Kompletter Systemscan wurde am %date% durchgefhrt.>>Update.tmp
)
if not exist "Update.tmp" (
echo Kompletter Systemscan wurde am %date% durchgefhrt.>>Update.log
del /F Update.tmp
) ELSE (
del /F Update.tmp
FOR /F "usebackq tokens=1-6" %%A IN (Update.log) DO (
if "%%A" == "Kompletter" (echo Kompletter Systemscan wurde am %date% durchgefhrt.>>Update.tmp) ELSE (echo %%A %%B %%C %%D %%E %%F>>Update.tmp)
move /Y "Update.tmp" "Update.log"
))
goto :!Start!






:Update
echo.
echo M”chten Sie jetzt auf Updates prfen? (J / N)
set /P Updater=
if /I "%Updater%" == "n" goto :Start
if /I "%Updater%" == "no" goto :Start
if /I "%Updater%" == "nein" goto :Start
set Updater=
set zahl=0
:Update2
echo Auf Updates prfen...
echo.
echo                                 I             I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I²            I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I ²           I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I² ²          I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I ² ²         I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I² ² ²        I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I ² ² ²       I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I  ² ² ²      I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I   ² ² ²     I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I    ² ² ²    I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I     ² ² ²   I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I      ² ² ²  I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I       ² ² ² I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I        ² ² ²I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I         ² ² I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I          ² ²I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I           ² I
ping localhost -n 1 >nul
cls
echo Auf Updates prfen...
echo.
echo                                 I            ²I
ping localhost -n 1 >nul
cls
set /a zahl=%zahl% +1
if "%zahl%" == "4" goto :Update_Ende
goto :Update2
:Update_Ende
echo Information                 Update wurde durchgefhrt.>>"Ergnsse.ini"
if "%Update%" == "Heute                  " goto :Kein_Update
echo Update wurde erfolgreich am %date% installiert.>>Update.log
echo Updates werden installiert, bitte warten...
echo Firewall=M>>Enstlngn.ini
echo Akustik=E>>Enstlngn.ini
echo Update=3=Zahl>>Enstlngn.ini
echo Scan=7=Zahl>>Enstlngn.ini
ping localhost -n 6 >nul
echo ---^> Erfolgreich installiert.>>"Ergnsse.ini"
echo.
echo Updates wurden erfolgreich installiert.
set Update=Heute                  
set Start=Start_Update
goto :!Start!
:Kein_Update
echo ---^> Keine neuen Updates verfgbar.>>"Ergnsse.ini"
echo Keine neuen Updates verfgbar. Ihr Produkt ist auf dem neuesten Stand.
pause
goto :!Start!











:Upgrade
echo.
echo.
echo M”chten Sie auf Premium aufstufen? (J / N)
echo.
echo Preis..................: 11.95 Euro
echo.
echo Bezahlungsm”glichkeiten: PayPal
echo                          Click And Buy
echo                          šberweisung
echo.
set /p Upgrader=
if /I "%Upgrader%" == "j" (
echo Die Internetverbindung muss zugelassen werden.
start http://www.windowsantivirus.com/upgrade_premium/11.95/
goto :!Start!
)
if /I "%Upgrader%" == "ja" (
echo Die Internetverbindung muss zugelassen werden.
start http://www.windowsantivirus.com/upgrade_premium/11.95/
goto :!Start!
)
if /I "%Upgrader%" == "yes" (
echo Die Internetverbindung muss zugelassen werden.
start http://www.windowsantivirus.com/upgrade_premium/11.95/
goto :!Start!
)
if /I "%Upgrader%" == "y" (
echo Die Internetverbindung muss zugelassen werden.
start http://www.windowsantivirus.com/upgrade_premium/11.95/
goto :!Start!
)
if /I "%Upgrader%" == "n" goto :!Start!
if /I "%Upgrader%" == "no" goto :!Start!
if /I "%Upgrader%" == "nein" goto :!Start!
echo Befehl nicht erkannt.
pause
goto :Upgrade









:Ereignisse
echo.
if not exist "Ergnsse.ini" call :Ergnsse
echo EREIGNISSE
echo ----------------------
type Ergnsse.ini                 
echo.
echo.
set /P Ereignisse_Pause=Drcken Sie Enter zum Fortfahren.
goto :!Start!









:Quarantane
echo.
echo.
echo QUARANTŽNE
echo ----------------------
echo  Datei                     Gefahrenstufe
REM  0eicar.com.vir             1, Datei richtet keinen Schaden an.
echo.
FOR /F "usebackq delims=" %%A IN (`dir /B "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED"`) DO (
echo %%A             1, Datei richtet keinen Schaden an.
)
echo.
echo.
echo M”chten Sie eine Datei aus der Quarant„ne nehmen und auf dem Desktop speichern,
echo geben Sie die Zahl vor der Datei ein und fgen Sie ein " /move" hinzu.
echo.
echo Z.B. "1 /move".
echo.
set /P Quarantane-Wahl=
FOR /F "usebackq tokens=1,2 delims=/ " %%A IN ('%Quarantane-Wahl%') DO if /I "%%B" == "move" call :Quarantane-Move %%A
goto :!Start!

:Quarantane-Move
FOR /F "usebackq delims=" %%A IN (`dir /B /S "%userprofile%\Eigene Dateien\Antivirus 1.6\INFECTED"`) DO (
set Dateiname=%%~nA
if /I "!Dateiname:~0,1!" == "%1" move /-Y "%%A" "%userprofile%\Desktop\!Dateiname:~1,10!"&set /A Quarantane=!Quarantane! -1
)
goto :EOF








:Einstellungen
cls
set Einstellungen_Wahl=
echo EINSTELLUNGEN
echo -------------------
echo.
echo    Thema                             Status
echo -----------------------------------------------
REM  1: Sicherheitskonfiguration          Mittel
REM  2: Heuristik                         Mittel
REM  3: Firewall                          Mittel
REM  4: Akustisches Signal                Aus
REM  5: Warnen, wenn Update älter ist als 3 Tage
REM  6: Warnen, wenn Systemscan älter als 7 Tage
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Sicherheitskonfiguration" (
					if /I "%%B" == "A" (
							    color !color:~0,1!c
							    set color=!color:~0,1!c
							    echo 1: %%A          Aus
							   )
					if /I "%%B" == "N" (
							    color !color:~0,1!a
							    set color=!color:~0,1!a
							    echo 1: %%A          Niedrig
							   )
					if /I "%%B" == "M" (
							    color !color:~0,1!a
							    set color=!color:~0,1!a
							    echo 1: %%A          Mittel
							   )
					if /I "%%B" == "H" (
							    color !color:~0,1!a
							    set color=!color:~0,1!a
							    echo 1: %%A          Hoch
							   )
					)
if "%%A" == "Heuristik" (
			if /I "%%B" == "A" (echo 2: %%A                         Aus)
			if /I "%%B" == "N" (echo 2: %%A                         Niedrig)
			if /I "%%B" == "M" (echo 2: %%A                         Mittel)
			if /I "%%B" == "H" (echo 2: %%A                         Hoch)
			)
if "%%A" == "Firewall" (
					if /I "%%B" == "A" (
							    color 4!color:~1,1!
							    set color=4!color:~1,1!
							    echo 3: %%A                          Aus
							   )
					if /I "%%B" == "N" (
							    color 2!color:~1,1!
							    set color=2!color:~1,1!
							    echo 3: %%A                          Niedrig
							   )
					if /I "%%B" == "M" (
							    color 2!color:~1,1!
							    set color=2!color:~1,1!
							    echo 3: %%A                          Mittel
							   )
					if /I "%%B" == "H" (
							    color 2!color:~1,1!
							    set color=2!color:~1,1!
							    echo 3: %%A                          Hoch
							   )
			)
if "%%A" == "Akustik" (
			if /I "%%B" == "A" (echo 4: Akustisches Signal                Aus)
			if /I "%%B" == "E" (echo 4: Akustisches Signal                Ein)
		      )
if "%%A" == "Update" (
			if /I "%%B" == "A" (echo 5: Nicht warnen, wenn Update veraltet ist.) ELSE (echo 5: Warnen, wenn Update „lter ist als %%B Tage)
		     )
if "%%A" == "Scan" (
			if /I "%%B" == "A" (echo 6: Nicht warnen, wenn Systemscan veraltet ist.) ELSE (echo 6: Warnen, wenn Systemscan „lter als %%B Tage)
		   )
)
echo.
echo Um eine Einstellung zu „ndern, geben Sie dessen Nummer ein gefolgt von einem
echo Leerzeichen und dem Status:
if "!Start!" == "Start_Update" (
echo A=Aus , N=Niedrig , M=Mittel , H=Hoch , E=Ein // Zahl
echo.
echo Beispiele: "1 H" , "4 E" , "5 7" , "6 30"
) ELSE (
echo A=Aus , N=Niedrig , M=Mittel , H=Hoch
echo.
echo Beispiele: "1 H" , "2 A"
echo.
echo Ohne Eingabe kehren Sie zurck zum Hauptmen.
)
set /P Einstellungen_Wahl=
if "%Einstellungen_Wahl%" == "" goto :!Start!

if "%setlocal_enabledetailedcommanding%" == "0" (
if /I "%Einstellungen_Wahl%" == "1 A" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Sicherheitskonfiguration" (echo %%A=A>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "1 N" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Sicherheitskonfiguration" (echo %%A=N>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "1 M" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Sicherheitskonfiguration" (echo %%A=M>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "1 H" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Sicherheitskonfiguration" (echo %%A=H>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "2 A" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Heuristik" (echo %%A=A>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "2 N" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Heuristik" (echo %%A=N>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "2 M" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Heuristik" (echo %%A=M>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "2 H" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Heuristik" (echo %%A=H>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "3 A" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Firewall" (echo %%A=A>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "3 N" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Firewall" (echo %%A=N>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "3 M" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Firewall" (echo %%A=M>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "3 H" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Firewall" (echo %%A=H>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "4 A" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Akustik" (echo %%A=A>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl%" == "4 E" (
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Akustik" (echo %%A=E>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl:~0,1%" == "5" (
set /a Einstellungen_Update=%Einstellungen_Wahl:~2,1%
if "!Einstellungen_Update!" == "0" (set Status_Update=A) ELSE (set Status_Update=!Einstellungen_Update!)
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Update" (echo %%A=!Status_Update!=Zahl>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
if /I "%Einstellungen_Wahl:~0,1%" == "6" (
if "%Einstellungen_Wahl:~3,1%" == "" (set /a Einstellungen_Scan=%Einstellungen_Wahl:~2,1%) ELSE (set /a Einstellungen_Scan=%Einstellungen_Wahl:~2,2%)
if "!Einstellungen_Scan!" == "0" (set Status_Scan=A) ELSE (set Status_Scan=!Einstellungen_Scan!)
FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
if "%%A" == "Scan" (echo %%A=!Status_Scan!=Zahl>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
)
move /Y "Enstlngn.tmp" "Enstlngn.ini"
)
)
set Einstellungen_Update=
set Einstellungen_Scan=
set Status_Update=
set Status_Scan=

if "%setlocal_enabledetailedcommanding%" == "1" (
	FOR /F "usebackq tokens=1,2" %%a IN ('%Einstellungen_Wahl%') DO (
		if "%%a" == "1" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Sicherheitskonfiguration" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
		if "%%a" == "2" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Heuristik" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
		if "%%a" == "3" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Firewall" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
		if "%%a" == "4" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Akustik" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
		if "%%a" == "5" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Update" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
		if "%%a" == "6" (
				FOR /F "usebackq tokens=1,2 delims==" %%A IN (Enstlngn.ini) DO (
					if "%%A" == "Scan" (echo %%A=%%a>>Enstlngn.tmp) ELSE (echo %%A=%%B>>Enstlngn.tmp)
										    )
				move /Y "Enstlngn.tmp" "Enstlngn.ini"
				)
	)
)
goto :Einstellungen









:Firewall
if "!color!" == "2a" (
set color2=4a
echo Warnung                     Firewall wurde deaktiviert.>>"Ergnsse.ini"
)
if "!color!" == "4a" (
set color2=2a
echo Information                 Firewall wurde aktiviert.>>"Ergnsse.ini"
)
if "!color!" == "2c" (
set color2=4c
echo Warnung                     Firewall wurde deaktiviert.>>"Ergnsse.ini"
)
if "!color!" == "4c" (
set color2=2c
echo Information                 Firewall wurde aktiviert.>>"Ergnsse.ini"
)
set color=!color2!
set color2=
if "!Firewallstatus!" == "Aktiv                  " (set Firewallstatus=Inaktiv                ) ELSE (set Firewallstatus=Aktiv                  )
if "!Firewallstatus2!" == "Deaktivieren" (set Firewallstatus2=Aktivieren) ELSE (set Firewallstatus2=Deaktivieren)
goto :!Start!










:Backup
echo.
echo M”chten Sie ein Backup ihres kompletten Systemes ziehen?
set /p Backup=
if /I "%Backup%" == "N" goto :!Start!
if /I "%Backup%" == "No" goto :!Start!
if /I "%Backup%" == "Nein" goto :!Start!
echo Bitte geben Sie die Laufwerkpartition an (z.B. G:\ )
set /p Backup_Laufwerk=
xcopy %homedrive% %Backup_Laufwerk% /S /E /F /H /K /O /X /Y
if ERRORLEVEL 1 echo Bitte legen Sie eine CD / DVD ein. & pause & goto :Backup
echo.
echo.
echo Backup gezogen.
ping localhost -n 3 >nul
pause
goto :!Start!








:Windows-Tools
cls
echo Geben Sie entsprechende Nummern fr folgende Befehle ein.
echo.
echo  1: Microsoft Konfiguration (msconfig)
echo  2: Eingabeaufforderung (CMD)
echo  3: Windows Ereignisanzeige (Eventvwr)
echo  4: Aktuelle Windows Version (winver)
echo  5: Internet Explorer Optionen (Systemsteuerung)
echo  6: Installierte Software anzeigen (Systemsteuerung)
echo  7: Registry (regedit)
echo  8: Windows Sicherheitscenter (Systemsteuerung)
echo  9: Systemeigenschaften (Systemsteuerung // Arbeitsplatz - Eigenschaften)
echo 10: Systeminformationen anzeigen lassen (msinfo32)
echo 11: Systemwiederherstellung (rstrui)
echo 12: Windows Task-Manager (taskmgr)
echo 13: Texteditor 1 (notepad)
echo 14: Texteditor 2 (wordpad)
echo 15: Soundabspieler (sndrec32)
echo 16: Windows Hilfeanzeige (winhelp)
echo 17: Microsoft Paintbrush (mspaint)
echo 18: MS-DOS Texteditor 1 (edit /b)
echo 19: MS-DOS Texteditor 2 (edit /h)
echo 20: Taschenrechner (calc)
echo 21: Defragmentierung (defrag)
echo 22: Zeichentabelle (charmap)
echo 23: Bildschirmlupe (magnify)
echo 24: Bildschirmtastatur (osk)
echo 25: Windows Cleanmanager (cleanmgr)
echo 26: Windows Explorer (explorer)
echo.
set /p Windows-Tools=
if "%Windows-Tools%" == "1" start msconfig
if "%Windows-Tools%" == "2" start "Eingabeaufforderung"
if "%Windows-Tools%" == "3" start eventvwr
if "%Windows-Tools%" == "4" start winver
if "%Windows-Tools%" == "5" start inetcpl.cpl
if "%Windows-Tools%" == "6" start appwiz.cpl
if "%Windows-Tools%" == "7" start regedit
if "%Windows-Tools%" == "8" start wscui.cpl
if "%Windows-Tools%" == "9" start sysdm.cpl
if "%Windows-Tools%" == "10" start msinfo32
if "%Windows-Tools%" == "11" start %SystemRoot%\system32\restore\rstrui.exe
if "%Windows-Tools%" == "12" start taskmgr
if "%Windows-Tools%" == "13" start notepad
if "%Windows-Tools%" == "14" start write
if "%Windows-Tools%" == "15" start sndrec32
if "%Windows-Tools%" == "16" start winhelp
if "%Windows-Tools%" == "17" start mspaint
if "%Windows-Tools%" == "18" start edit /B
if "%Windows-Tools%" == "19" start edit /H
if "%Windows-Tools%" == "20" start calc
if "%Windows-Tools%" == "21" start dfrg.msc
if "%Windows-Tools%" == "22" start charmap
if "%Windows-Tools%" == "23" start magnify
if "%Windows-Tools%" == "24" start osk
if "%Windows-Tools%" == "25" start cleanmgr
if "%Windows-Tools%" == "26" start explorer
goto :!Start!







REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************














:Ergnsse
echo Typ                         Aktion>"Ergnsse.ini"
echo.>>"Ergnsse.ini"
goto :EOF





:Enstlngn
echo Sicherheitskonfiguration=M>Enstlngn.ini
echo Heuristik=M>>Enstlngn.ini
goto :EOF




















