@echo off
REM (C) Copyright S1r1us13 / GrellesLicht28
REM This is a creation of Makroware.
title G-Dawtech
color 0E
SETLOCAL ENABLEDELAYEDEXPANSION
pushd !Temp!
if exist "G-Dawtech Virusscan-Report.log" del "G-Dawtech Virusscan-Report.log"
FOR /F "delims=" %%A IN ("%0") DO set Eigenpfad=%%~sA
if exist "GDOpt.ini" goto :Vor_Start2
REM ------------------------------------------------------------------------------------------------------------
echo Scantyp:           X Alle Dateien>GDOpt.ini
echo                      Intelligente Dateienauswahl>>GDOpt.ini
echo                      Dateierweiterungsliste>>GDOpt.ini
REM *** In die Klammern der FOR-Schleife den Befehl per Variablenaufruf schreiben: "dir /A /B /S %Scantyp%". ***
echo Aktion bei Fund:   X Nachfragen>>GDOpt.ini
echo                      Automatisch entfernen>>GDOpt.ini
REM ***                Beim Auswerten der Datei alle 100%igen Funde direkt löschen lassen.                   ***
echo Suchlauf:          X Optimiert>>GDOpt.ini
echo                      Minimale CPU-Auslastung ^(nicht empfohlen^)>>GDOpt.ini
REM ***                  IN den FOR-Befehl den Befehl %Suchlauf% ohne weitere Parameter.                     ***
echo Counter:           X Aktivieren>>GDOpt.ini
echo                      Deaktivieren>>GDOpt.ini
REM ***  Der Counter bestimmt, ob die durchsuchten Dateien angezeigt werden und ob gezählt wird oder nicht.  ***
REM ------------------------------------------------------------------------------------------------------------
:Vor_Start2
if not exist GDDtErw.ini call :Vor_Start3
FOR /F "tokens=1,2 delims=X" %%A IN (GDOpt.ini) DO (
if "%%B" == " Alle Dateien" set Scantyp="%homedrive%\"
if "%%B" == " Intelligente Dateienauswahl" set Scantyp="%homedrive%\*.exe" "%homedrive%\*.dll" "%homedrive%\*.dat"
if "%%B" == " Dateierweiterungsliste" FOR /F "delims=" %%f IN (GDDtErw.ini) DO set Scantyp=!Scantyp!"%homedrive%\%%f" 
if "%%B" == " Nachfragen" set Aktion_Bei_Fund=Nachfragen
if "%%B" == " Automatisch entfernen" set Aktion_Bei_Fund=Entfernen
if "%%B" == " Optimiert" set Suchlauf=REM Nichts.
if "%%B" == " Minimale CPU-Auslastung (nicht empfohlen)" set Suchlauf=ping localhost -n 2 ^>nul
if "%%B" == " Aktivieren" (
set Counter=^>^>"G-Dawtech Virusscan-Report.log"
set Counter2=
set echo=echo
set echo2=echo.
set cls=cls
set set=set
)
if "%%B" == " Deaktivieren" (
set Counter=
set Counter2=^&set /a Funde=^^!Funde^^! +1
REM ------Counter  muss mit Prozentzeichen aufgerufen werden.-------
REM ------Counter2 muss mit Prozentzeichen aufgerufen werden.-------
set echo=REM
set echo2=REM A
set cls=REM A
set set=REM 
))
goto :Vor_Start4
:Vor_Start3
echo *.app>GDDtErw.ini
echo *.asp>>GDDtErw.ini
echo *.bas>>GDDtErw.ini
echo *.bat>>GDDtErw.ini
echo *.cmd>>GDDtErw.ini
echo *.com>>GDDtErw.ini
echo *.cpl>>GDDtErw.ini
echo *.dll>>GDDtErw.ini
echo *.drv>>GDDtErw.ini
echo *.exe>>GDDtErw.ini
echo *.htm>>GDDtErw.ini
echo *.html>>GDDtErw.ini
echo *.inf>>GDDtErw.ini
echo *.ini>>GDDtErw.ini
echo *.jet>>GDDtErw.ini
echo *.jpeg>>GDDtErw.ini
echo *.jpg>>GDDtErw.ini
echo *.lnk>>GDDtErw.ini
echo *.pdf>>GDDtErw.ini
echo *.php>>GDDtErw.ini
echo *.png>>GDDtErw.ini
echo *.rar>>GDDtErw.ini
echo *.scr>>GDDtErw.ini
echo *.script>>GDDtErw.ini
echo *.sys>>GDDtErw.ini
echo *.tmp>>GDDtErw.ini
echo *.url>>GDDtErw.ini
echo *.vb>>GDDtErw.ini
echo *.vba>>GDDtErw.ini
echo *.vbs>>GDDtErw.ini
echo *.xxx>>GDDtErw.ini
echo *.zip>>GDDtErw.ini
exit /b
:Vor_Start4
set Funde=0
set Warnungen=0
set Hinweise=0
if "%1" == "/REMOVE" (
echo.>"C:\AUTOEXEC.BAT"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /F
cls
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo                        Û                                Û
echo                        Û  G-DAWTECH ANTI-VIRUS SCANNER  Û
echo                        Û                                Û
echo                        Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo                        Û                                Û
echo                        Û  --^> Virenentfernung           Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo Alle Viren sollten nun entfernt worden sein.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
ping localhost -n 6 >nul
exit
)
if "%1" == "/high" goto :Antivirus-Start
if "%1" == "/normal" goto :Antivirus-Start
if "%1" == "/low" goto :Antivirus-Start
REM --------------------------------------------------------------------------------
:Priority
cls
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo                        Û                                Û
echo                        Û  G-DAWTECH ANTI-VIRUS SCANNER  Û
echo                        Û                                Û
echo                        Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo                        Û                                Û
echo                        Û  --^> Priorit„t                 Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo Geben Sie hier die Priorit„t des Scanners ein:
echo H = Hoch                         Scanner l„uft schneller als andere Programme.
echo N = Normal                       Scanner l„uft mit anderen Programmen.
echo L = Niedrig                      Scanner l„uft langsamer als andere Programme.
echo.
set /P Priority=
FOR /F "delims=" %%I IN ("%0") DO set G-Dawtech=%%~sI
if /I "%Priority%" == "H" start /high %G-Dawtech% /high&&exit
if /I "%Priority%" == "High" start /high %G-Dawtech% /high&&exit
if /I "%Priority%" == "N" start /normal %G-Dawtech% /normal&&exit
if /I "%Priority%" == "Normal" start /normal %G-Dawtech% /normal&&exit
if /I "%Priority%" == "L" start /low %G-Dawtech% /low&&exit
if /I "%Priority%" == "Low" start /low %G-Dawtech% /low&&exit
echo Priorit„tsklasse nicht erkannt.
pause
goto :Priority
REM --------------------------------------------------------------------------------





REM --------------------------------------------------------------------------------
:Antivirus-Start
title G-Dawtech
set Menu=
mode con lines=50
REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo  Û                                                                            Û
echo  Û                        G-DAWTECH ANTI-VIRUS SCANNER                        Û
echo  Û                                                                            Û
echo  Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo  Û                                                                            Û
echo  Û W„hlen Sie die Option, die Sie durchfhren m”chten:                        Û
echo  Û                                                                            Û
echo  Û 0: Scanner beenden                                                         Û
echo  Û 1: Registryscan                                                            Û
echo  Û 2: Systemscan                                                              Û
echo  Û 3: Voller Scan                                                             Û
echo  Û 4: Datei / Ordner ausw„hlen                                                Û
echo  Û 5: Ergebnisse                                                              Û
echo  Û 6: Removaltools (nur Dateien und Ordner)                                   Û
echo  Û 7: Konfiguration                                                           Û
echo  Û                                                                            Û
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
set /p Menu=Wahl: 
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if "%Menu%" == "" goto :Antivirus-Start
if "%Menu%" == "0" goto :Ende
if /I "%Menu%" == "Q0" EXIT
if /I "%Menu%" == "0Q" EXIT
if "%Menu%" == "1" goto :Registryscan
if "%Menu%" == "2" goto :Systemscan
if "%Menu%" == "3" set Scan=voll&&goto :Registryscan
if "%Menu%" == "4" goto :Eigenscan
if "%Menu%" == "5" goto :Ergebnis
if "%Menu%" == "6" goto :Entfernen
if "%Menu%" == "7" goto :Optionen
echo Die Wahl "%Menu%" ist kein m”glicher Befehl.
pause
goto :Antivirus-Start
:Registryscan
echo.
echo Scan der Registry wird gestartet. Bitte warten...
set Anzahl_Dateien=0
title G-Dawtech - Scan der Registry wird vorbereitet.
FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_CLASSES_ROOT" /S`) DO (
if "echo" == "REM" (
if "!Anzahl_Dateien!" == "0" title G-Dawtech - Registryscan l„uft.&mode con lines=300&set Anzahl_Dateien=1
) ELSE (
if "!Anzahl_Dateien!" == "0" title G-Dawtech - Registryscan l„uft.&mode con lines=8&set Anzahl_Dateien=1
)
set HKCR=%%A
if /I "!HKCR:~0,17!" == "HKEY_CLASSES_ROOT" (
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{af55160d-cde1-4a8b-8001-66da06bee740}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{40ca90f3-4098-4877-ae87-23eb612b18c7}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{4c3b62af-ca25-4fba-8405-32e44f83bb6f}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{5a635a91-c303-45c9-8db9-f759d98a3b9d}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{7e335d04-2e6e-4d0e-a921-c3d9192e7121}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{99ccfb8c-6380-4a14-8fdd-ef3e7e95335d}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b20d7add-989c-4bc0-a797-f6fe7998efd7}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{bfc20a15-b0ac-44cc-a25a-a7039014ba9f}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{f019aec4-4c95-46de-a107-e302473e3b9a}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2557dd3f-23a0-477c-bcd8-90fd0aecc4b8}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2893116c-a176-42b1-8794-da8c9fc45564}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{99fdca0c-7380-4e9c-8d99-5dc4750334ef}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b1d9f4b1-b9ff-463f-bf15-ab9cb26160f7}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{d8560ac2-21b5-4c1a-bdd4-bd12bc83b082}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{8ad9ad05-36be-4e40-ba62-5422eb0d02fb}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{aebf09e2-0c15-43c8-99bf-928c645d98a0}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{8ee46f55-1ce1-4db9-811a-68938ec7f3dd}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{a87dfd99-cf81-4241-85ce-881e0026b686}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{c96b9fae-a032-4100-bb47-32ef05e28be4}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2447e305-5e90-42a8-bd1e-0bc333b807e1}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{50d2fdcc-2707-49cb-8223-7fe0424909aa}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{878ce013-7ba9-4650-a78c-b2234c0c1648}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{30b15818-e110-4527-9c05-46ace5a3460d}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{618aad04-921f-44c2-be38-c0818af69861}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b5d2ed96-62f9-4c2c-956d-e425b1f67337}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{d3a412e8-1e4b-47d2-9b12-f88291f5afbb}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{3ceb04ab-08af-45f4-81b4-70d13c1f7b85}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{a7213d71-47e1-4832-92d7-d61dfe9f231f}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{cf82f350-e1c4-4916-ac12-ba73db60afb7}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{15fd8424-d12a-4c51-8c6c-d5d57b80f781}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{67b3becf-7b6f-42b2-99f0-f7656f89cffa}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{715ffd42-4e05-4eab-9513-c8daa5395ae2}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{759d6f7c-8d30-45b6-abea-fa51c190eed5}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{9a4a64a4-a2fb-48fa-9bba-1ac50267695d}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{0af9a087-0cbf-46b2-9dc9-52d0d16b5ab6}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{a56fe01c-77c4-4f5e-8198-e4b72207890a}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{0729f461-8054-47dc-8d39-a31b61cc0119}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{a57470de-14c7-4fcd-9d4c-e5711f24f0ed}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{e343edfc-1e6c-4cb5-aa29-e9c922641c80}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{cdca70d8-c6a6-49ee-9bed-7429d6c477a2}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{d136987f-e1c4-4ccc-a220-893df03ec5df}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{148e1447-c728-48fd-beec-a7d06c5fff58}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{8292078f-f6e9-412b-8eb1-360c05c5ece5}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{76d54105-99eb-4ecb-95b2-a944f50cc566}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{03d7ff6e-9781-40b5-bb7f-94291a361604}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{c62a9e79-2b52-439b-af57-2e60bb06e86c}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{abec1835-3181-4abd-8dde-875aec4df6d2}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2d00aa2a-69ef-487a-8a40-b3e27f07c91e}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{86c5840b-80c4-4c30-a655-37344a542009}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{b0cb585f-3271-4e42-88d9-ae5c9330d554}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{71f731b3-008b-4052-9ea4-4145acce40c3}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{20ea9658-6bc3-4599-a87d-6371fe9295fc}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a16ad1e9-f69a-45af-9462-b1c286708842}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a7cddcdc-beeb-4685-a062-978f5e07ceee}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{c9ccbb35-d123-4a31-affc-9b2933132116}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2f9ad413-2e0b-4a85-bb2a-cf961238262a}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{70880ce6-308c-4204-a89e-b266c3f7b7fa}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{8c788aa2-7530-43be-97b7-4d491f13bea3}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{14113b47-d59c-4f0f-9d10-ff1730265584}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a9c42a57-421c-4572-8b12-249c59183d1c}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a5b6fa30-d317-41ca-9cb1-c898d3c7f34e}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{cc19a5f2-b4ad-41d5-a5c9-0680904c1483}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a3e67daa-da01-4da5-98be-3088b554a11e}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{d95c7240-0282-4c01-93f5-673bca03da86}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{62906e60-bce2-4e1b-9ed0-8b9042ee15e4}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{f9bfa98d-9935-4ea4-a05a-72c7f0778f02}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.lfgax" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.lfgax.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostie.bho" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostie.bho.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbax" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbax.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbinfoband" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbinfoband.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebutton" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebutton.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebuttona" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebuttona.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.rprtctrl" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.rprtctrl.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\srv.coreservices" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\srv.coreservices.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hotbarax.userprofiles" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hotbarax.userprofiles.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdic" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdic.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdisp" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdisp.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.coreservices" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.coreservices.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbmain.commband" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbmain.commband.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbr.hbmain" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbr.hbmain.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.mailanim" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.mailanim.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.webmailsend" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.webmailsend.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.htmlmenuui" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.htmlmenuui.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.toolbarctl" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.toolbarctl.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\wallpaper.wallpapermanager" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\wallpaper.wallpapermanager.1" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Anzahl_Dateien=!Anzahl_Dateien! +1
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: %%A
))
set /a Anzahl_Dateien=!Anzahl_Dateien!
echo.
echo Hkey_Current_User wird vorbereitet...

FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_CURRENT_USER" /S`) DO (
set HKCU=%%A
if /I "!HKCU:~0,4!" == "HKEY" (
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{a7cddcdc-beeb-4685-a062-978f5e07ceee}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b2}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b3}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\Software\Hotbar" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\Software\hotbarsa" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\fcn" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\ShoppingReport" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Anzahl_Dateien=!Anzahl_Dateien! +1
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: %%A
))
set /a Anzahl_Dateien=!Anzahl_Dateien!
echo.
echo Hkey_Local_Machine wird vorbereitet...

FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_LOCAL_MACHINE" /S`) DO (
set HKLM=%%A
if /I "!HKLM:~0,4!" == "HKEY" (
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b2}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b3}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{eddbb5ee-bb64-4bfc-9dbe-e7c85941335b}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{a3e67daa-da01-4da5-98be-3088b554a11e}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{d95c7240-0282-4c01-93f5-673bca03da86}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\findbasic" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\shoppingreport" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Findbasic Service" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Findbasic" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\ShoppingReport" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Anzahl_Dateien=!Anzahl_Dateien! +1
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: %%A
))
set /a Anzahl_Dateien=!Anzahl_Dateien!

FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbaroe`) DO (
if /I "%%A" == "hotbaroe" (
echo [FUND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbaroe%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbaroe
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbarsa`) DO (
if /I "%%A" == "hotbarsa" (
echo [FUND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbarsa%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbarsa
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v weatherdpa`) DO (
if /I "%%A" == "weatherdpa" (
echo [FUND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\weatherdpa%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\weatherdpa
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" (
echo [FUND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" (
echo [FUND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FUND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b2}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FUND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b2}%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b2}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b3}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FUND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b3}%Counter%
echo.%Counter%
%cls%
%echo% Registry wird durchsucht...
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentaner Schlssel: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b3}
))
title G-Dawtech - Registryscan beendet.
if "%Scan%" == "voll" call :Systemscan
if not "%echo%" == "REM" mode con lines=300
if exist "G-Dawtech Virusscan-Report.log" (
FOR /F "usebackq tokens=1" %%A IN (G-Dawtech Virusscan-Report.log) DO (
if "%%A" == "[FUND]" set /a Funde=!Funde! +1
if "%%A" == "[WARNUNG]" set /a Warnungen=!Warnungen! +1
if "%%A" == "[HINWEIS]" set /a Hinweise=!Hinweise! +1
)
echo.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
type "G-Dawtech Virusscan-Report.log"
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
)
echo.
echo.
echo Scan abgeschlossen.
echo.
echo.
echo Viren gefunden     : !Funde!
echo Verd„chtige Dateien: !Warnungen!
echo Hinweise           : !Hinweise!
echo.
set /p ende=
echo.
pause
pause
goto :Antivirus-Start






:Systemscan
title G-Dawtech - Systemscan wird vorbereitet.
echo.
echo Scan der Systempartition wird gestartet. Bitte warten...
set Systemscantitel=0
FOR /F "usebackq delims=" %%A IN (`dir /A /B /S %Scantyp%`) DO (
if "!Systemscantitel!" == "0" (
title G-Dawtech - Systemscan l„uft.
set Systemscantitel=1
if "%echo%" == "REM" (
if not "%Menu%" == "3" mode con lines=300
) ELSE (
mode con lines=8
))
if /I "%%~nxA" == "a.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "b.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "c.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "d.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "e.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "f.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "g.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "h.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "a.dat" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "msa.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "msb.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "lst.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "p1.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic.dll" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic145.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "setub.exe" echo [FUND]%Counter%&echo %%A%Counter%echo.%Counter%%Counter2%
if /I "%%~nxA" == "vturs.dll" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "cabal_online.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "Software cool.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "skip 2.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "warn chin ball.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%Suchlauf%
%set% /a Anzahl_Dateien=!Anzahl_Dateien! +1
%cls%
%echo% Scan l„uft.
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentane Datei: %%A
)
if not "%echo%" == "REM" mode con lines=300
if exist "%appdata%\findbasic" (
echo [FUND]
echo "%appdata%\findbasic"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%ProgramFiles%\findbasic" (
echo [FUND]
echo "%ProgramFiles%\findbasic"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\Hotbar" (
echo [FUND]
echo "%appdata%\Hotbar"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%ProgramFiles%\Hotbar" (
echo [FUND]
echo "%ProgramFiles%\Hotbar"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\ShoppingReport" (
echo [FUND]
echo "%appdata%\ShoppingReport"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%ProgramFiles%\ShoppingReport" (
echo [FUND]
echo "%ProgramFiles%\ShoppingReport"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\WeatherDPA" (
echo [FUND]
echo "%appdata%\WeatherDPA"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\comp two long internet" (
echo [FUND]
echo "%appdata%\comp two long internet"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\beep axis mode free" (
echo [FUND]
echo "%appdata%\beep axis mode free"
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%appdata%\Softru~1" (
echo [FUND]
echo "%appdata%\Softru..."
echo [HINWEIS] Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%userprofile%\Eigene Dateien\Antivirus 1.6" (
echo [FUND]
echo "%userprofile%\Eigene Dateien\Antivirus 1.6"
echo [HINWEIS] Rogue Antivirus MS-DOS // Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%userprofile%\Eigene Dateien\Antivirus 1.7" (
echo [FUND]
echo "%userprofile%\Eigene Dateien\Antivirus 1.7"
echo [HINWEIS] Rogue Antivirus MS-DOS // Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if exist "%userprofile%\Eigene Dateien\Virenprojekte" (
echo [FUND]
echo "%userprofile%\Eigene Dateien\Virenprojekte"
echo [HINWEIS] DOS Virenmacher Sch„dlinge // Gesamter Ordner infiziert.
echo.
set /a Funde=!Funde! +1
set /a Hinweise=!Hinweise! +1
)
if "%Menu%" == "1" exit /b
if "%Menu%" == "3" exit /b
if exist "G-Dawtech Virusscan-Report.log" (
FOR /F "delims= " %%A IN (G-Dawtech Virusscan-Report.log) DO (
if "%%A" == "[FUND]" set /a Funde=!Funde! +1
if "%%A" == "[WARNUNG]" set /a Warnungen=!Warnungen! +1
if "%%A" == "[HINWEIS]" set /a Hinweise=!Hinweise! +1
)
echo.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
type "G-Dawtech Virusscan-Report.log"
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
)
echo.
copy /Y "%homedrive%\AUTOEXEC.BAT" "AUTOEXEC.BAT" >nul 2>&1
FOR /F "usebackq delims=" %%A IN (`dir /A /B "%temp%\AUTOEXEC.BAT"`) DO (
if not "%%~zA" == "0" (
if not "%%~zA" == "14" (echo Warnung: C:\Autoexec.bat wurde ver„ndert.&set /a Warnungen=!Warnungen! +1)
))
del /A /F "AUTOEXEC.BAT"
echo.
echo.
echo Scan abgeschlossen.
echo.
echo.
echo Viren gefunden     : !Funde!
echo Verd„chtige Dateien: !Warnungen!
echo Hinweise           : !Hinweise!
echo.
if "%Aktion_Bei_Fund%" == "Entfernen" goto :Entfernen
set /p ende=
echo.
pause
pause
goto :Antivirus-Start

:Ergebnis
if "%echo%" == "echo" (
mode con lines=300
echo Bisher durchsuchte Objekte: !Anzahl_Dateien!
echo.
echo.
echo.
if exist "G-Dawtech Virusscan-Report.log" type "G-Dawtech Virusscan-Report.log"
echo.
) ELSE (
echo Der Counter ist deaktiviert. Die einzelnen Funde, Warnungen und Hinweise k”nnen
echo nicht erneut gezeigt werden, falls vorhanden.
)
echo.
echo Viren gefunden     : !Funde!
echo Verd„chtige Dateien: !Warnungen!
echo Hinweise           : !Hinweise!
echo.
set /p ende=
goto :Antivirus-Start



:Eigenscan
set Funde=0
set Warnungen=0
set Hinweise=0
set Eigenscan=
set Anzahl_Dateien=0
echo.
echo.
echo Geben Sie hier die zu scannende Datei ein mitsamt Pfad:
set /p Eigenscan=
if "%Eigenscan%" == "" goto :Antivirus-Start
if /I "%Eigenscan%" == "n" goto :Antivirus-Start
if /I "%Eigenscan%" == "stop" goto :Antivirus-Start
if /I "%Eigenscan%" == "abort" goto :Antivirus-Start
if /I "%Eigenscan%" == "abruch" goto :Antivirus-Start
if /I "%Eigenscan%" == "cancel" goto :Antivirus-Start
if /I "%Eigenscan%" == "abbruch" goto :Antivirus-Start
if /I "%Eigenscan%" == "abrechen" goto :Antivirus-Start
if /I "%Eigenscan%" == "abbrechen" goto :Antivirus-Start

title G-Dawtech - Dateienscan
echo.>"G-Dawtech Virusscan-Report.log"
FOR /F "usebackq delims=" %%A IN (`dir /A /B /S "%Eigenscan%"`) DO (
if /I "%%~nxA" == "a.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "b.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "c.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "d.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "e.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "f.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "g.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "h.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "a.dat" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "msa.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "msb.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "lst.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "findbasic.dll" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "findbasic.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "findbasic145.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "setub.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "vturs.dll" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "cabal_online.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "svchost.exe" if not "%%A" == "%SystemRoot%\system32\svchost.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "Software cool.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "skip 2.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1
if /I "%%~nxA" == "warn chin ball.exe" echo [FUND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Funde=!Funde! +1%
if /I "%%~nA" == "virus" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "trojan" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "malware" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "troja" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1%&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "gen" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "spyware" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
if /I "%%~nA" == "adware" echo [Warnung]%Counter%&echo %%A%Counter%&echo [Hinweis] Diese Datei wurde als Virus dargestellt, ist aber wom”glich keiner.%Counter%&echo.%Counter%&set /a Warnungen=!Warnungen! +1&set /a Hinweise=!Hinweise! +1
%set% /a Anzahl_Dateien=!Anzahl_Dateien! +1
%cls%
%echo% Scan l„uft.
%echo% Bisher durchsuchte Objekte: !Anzahl_Dateien!
%echo2%
%echo% Momentane Datei: %%A
)
echo.
echo.
if exist "G-Dawtech Virusscan-Report.log" type "G-Dawtech Virusscan-Report.log"
echo.
echo Viren gefunden     : !Funde!
echo Verd„chtige Dateien: !Warnungen!
echo Hinweise           : !Hinweise!
echo.
set /p ende=
echo.
pause
goto :Antivirus-Start






:Entfernen
if "%echo%" == "REM" (
echo Der Counter ist deaktiviert. Es gibt keine Logdatei, die ausgewertet werden k”nnte.
echo Somit mssen Sie die Viren manuell entfernen.
echo.
pause
goto :Antivirus-Start
)
set Entfernen=
if "%Aktion_Bei_Fund%" == "Entfernen" goto :Entfernen_Auto
echo.
echo.
echo M”chten Sie alle Dateien, die in "G-Dawtech Virusscan-Report.log" angegeben
echo wurden unwiderruflich l”schen? Dateien, die von Windows ben”tigt werden, die
echo aber infiziert sind, k”nnen das System zum Absturz bringen! (J / N)
set /p Entfernen=
if /I "%Entfernen%" == "j" goto :Entfernen-J
if /I "%Entfernen%" == "ja" goto :Entfernen-J
if /I "%Entfernen%" == "yes" goto :Entfernen-J
if /I "%Entfernen%" == "y" goto :Entfernen-J
echo Die Dateien werden nicht bearbeitet.
pause
goto :Antivirus-Start
:Entfernen-J
if not exist "G-Dawtech Virusscan-Report.log" (
echo Es wurden keine Dateien in der G-Dawtech-Logdatei protokolliert.
pause
goto :Antivirus-Start
)
:Entfernen_Auto
FOR /F "delims=" %%A IN (G-Dawt~1.log) DO (
set Dateipfad=%%A
if "!Dateipfad:~1,2!" == ":\" (
sc stop "%%~nA" >nul 2>&1
sc delete "%%~nA" >nul 2>&1
taskkill /F /T /IM %%~nxA >nul 2>&1
del /F "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo Die Datei "%%A" wurde erfolgreich enfernt.
if "!ERRORLEVEL!" == "1" (
del /AS /F "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo Die Datei "%%A" wurde erfolgreich enfernt.
if "!ERRORLEVEL!" == "1" (
del /AH /F "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo Die Datei "%%A" wurde erfolgreich enfernt.
if "!ERRORLEVEL!" == "1" (
del /AHS /F "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo Die Datei "%%A" wurde erfolgreich enfernt.
if "!ERRORLEVEL!" == "1" (
echo Die Datei "%%A"
echo kann nicht bei laufendem Windows gel”scht werden. Sie wird daher beim Neustart
echo gel”scht.
echo del /F "%%A">>"C:\AUTOEXEC.BAT"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /t REG_SZ /d "%Eigenpfad% /REMOVE" /F
set Neustart=1
))))))
if "!Neustart!" == "1" (
echo M”chten Sie den Computer jetzt neustarten?
set /p Neustart=
if /I "!Neustart!" == "j" shutdown -r -t 20 -c "Die Viren werden beim Neustart vor dem Booten von Windows gel”scht."
if /I "!Neustart!" == "ja" shutdown -r -t 20 -c "Die Viren werden beim Neustart vor dem Booten von Windows gel”scht."
if /I "!Neustart!" == "yes" shutdown -r -t 20 -c "Die Viren werden beim Neustart vor dem Booten von Windows gel”scht."
if /I "!Neustart!" == "y" shutdown -r -t 20 -c "Die Viren werden beim Neustart vor dem Booten von Windows gel”scht."
)
echo.
pause
goto :Antivirus-Start





:Optionen
title G-Dawtech - Konfiguration
set Optionswahl=
mode con lines=50
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo                        Û                                Û
echo                        Û  G-DAWTECH ANTI-VIRUS SCANNER  Û
echo                        Û                                Û
echo                        Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo                        Û                                Û
echo                        Û --^> Konfiguration              Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo.
type GDOpt.ini
echo.
echo.
echo Um Hilfe zu einem Thema zu erlangen, geben Sie die Zeilennummer des Themas ein.
echo Um eine Option zu „ndern, geben Sie die Zeilennummer gefolgt von einem C ein
echo z.B. "2C". Damit wrde der Scantyp ge„ndert werden.
echo Um die Dateierweiterungsliste zu bearbeiten, geben Sie 3E ein.
echo Ohne Eingabe gelangen Sie zurck zum Hauptmen.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄ
set /p Optionswahl=Wahl: 
echo ÄÄÄÄÄÄÄÄÄÄÄ
echo.
if /I "%Optionswahl%" == "delete settings" (
del /F GDOpt.ini
del /F GDDtErw.ini
set GD-Neustart=1
)
if "%Optionswahl%" == "" (
if "%GD-Neustart%" == "1" (
echo Die Žnderungen werden nach einem Neustart von G-Dawtech wirksam.
pause
start %Eigenpfad%
exit
) ELSE (
goto :Antivirus-Start
))
if "%Optionswahl%" == "1" (
echo Der Scantyp ist die Art, mit der das System nach infizierten Dateien und Ordner
echo auf Viren gescannt werden. Er beeinflusst die Dauer des Scans stark.
echo Der schnellste Lauf ist "Intelligente Dateienauswahl".
echo "Alle Dateien" ist standardm„áig aktiviert.
)
if "%Optionswahl%" == "2" (
echo Der Scantyp "Intelligente Dateienauswahl" ist der schnellste Scan. Bei ihm
echo wird anhand den Dateien automatisch entschieden, ob sie auf Viren gescannt
echo werden oder nicht.
)
if "%Optionswahl%" == "3" (
echo Der Scantyp "Dateierweiterungsliste" l„sst Sie bestimmen, welche Dateien
echo gescannt werden sollen. Dabei k”nnen Sie sowohl welche hinzufgen als auch
echo entfernen.
)
if "%Optionswahl%" == "4" (
echo Standardm„áig wird ein Fund nur angezeigt. Sie k”nnen ihn dann per "Removal-
echo tools" leicht entfernen. Funde, Warnungen und Hinweise werden erst nach dem
echo Scan angezeigt. Diese Option wird empfohlen.
)
if "%Optionswahl%" == "5" (
echo Die m”gliche Aktion "Automatisch entfernen" bei einem Fund l”scht alle Funde
echo und verd„chtige Dateien direkt nach dem Scan. Diese Option kann im schlimmsten
echo Fall das System besch„digen und wird nicht empfohlen.
)
if "%Optionswahl%" == "6" (
echo Der optimierte Suchlauf ist schnell, verwendet aber so Prozessorleistung wie
echo m”glich. Diese Option ist standardm„áig aktiviert.
)
if "%Optionswahl%" == "7" (
echo Der Suchlauf mit minimaler CPU-Auslastung verzichtet auf verfgbare
echo CPU-Leistung, scannt aber pro Sekunde nur eine Datei. Diese Option wird
echo nicht empfohlen.
)
if "%Optionswahl%" == "8" (
echo Der Counter bestimmt, ob die gescannten Dateien gez„hlt und angezeigt werden.
echo Ist er aktiviert, wird dies angezeigt. Bei einem Virenfund, einer Warnung
echo oder einem Hinweis wird eine Logdatei erstellt, die am Ende ausgewertet wird.
)
if "%Optionswahl%" == "9" (
echo Ist der Counter deaktiviert, wird keine Logdatei erstellt bei einem Fund,
echo einer Warnung oder einem Hinweis, sondern sie werden sofort angezeigt. Das
echo Programm kann dann nicht mehr handeln, allerdings k”nnen Sie sich frher
echo ber die Viren informieren.
)

REM -------------------------
if /I "%Optionswahl%" == "1C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Scantyp:             Alle Dateien" (echo Scantyp:           X Alle Dateien>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Intelligente Dateienauswahl" (echo                      Intelligente Dateienauswahl>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Dateierweiterungsliste" (echo                      Dateierweiterungsliste>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "2C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Scantyp:           X Alle Dateien" (echo Scantyp:             Alle Dateien>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                     Intelligente Dateienauswahl" (echo                    X Intelligente Dateienauswahl>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Dateierweiterungsliste" (echo                      Dateierweiterungsliste>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "3C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Scantyp:           X Alle Dateien" (echo Scantyp:             Alle Dateien>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Intelligente Dateienauswahl" (echo                      Intelligente Dateienauswahl>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                     Dateierweiterungsliste" (echo                    X Dateierweiterungsliste>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "4C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Aktion bei Fund:     Nachfragen" (echo Aktion bei Fund:   X Nachfragen>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Automatisch entfernen" (echo                      Automatisch entfernen>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "5C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Aktion bei Fund:   X Nachfragen" (echo Aktion bei Fund:     Nachfragen>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                     Automatisch entfernen" (echo                    X Automatisch entfernen>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "6C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Suchlauf:            Optimiert" (echo Suchlauf:          X Optimiert>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Minimale CPU-Auslastung (nicht empfohlen)" (echo                      Minimale CPU-Auslastung ^(nicht empfohlen^)>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "7C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Suchlauf:          X Optimiert" (echo Suchlauf:            Optimiert>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                     Minimale CPU-Auslastung (nicht empfohlen)" (echo                    X Minimale CPU-Auslastung ^(nicht empfohlen^)>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "8C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Counter:             Aktivieren" (echo Counter:           X Aktivieren>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                   X Deaktivieren" (echo                      Deaktivieren>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "9C" (
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "Counter:           X Aktivieren" (echo Counter:             Aktivieren>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
FOR /F "delims=" %%A IN (GDOpt.ini) DO (
if "%%A" == "                     Deaktivieren" (echo                    X Deaktivieren>>GDOpt.tmp) ELSE (echo %%A>>GDOpt.tmp)
)
move /Y GDOpt.tmp GDOpt.ini
set GD-Neustart=1
)
REM -------------------------
if /I "%Optionswahl%" == "3E" goto :Dateierweiterungsliste
echo.
echo Nach einer Žnderung der Konfiguration mssen Sie G-Dawtech neustarten.
pause
goto :Optionen


:Dateierweiterungsliste
mode con lines=300
title G-Dawtech - Dateierweiterungsliste
set Dateierweiterungsliste=
set Name=
echo Folgende Dateierweiterungen stehen in der Liste:
echo îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî
type GDDtErw.ini
echo.
echo.
echo Zum Entfernen einer Erweiterung, geben Sie die Erweiterung als z.B. ".exe" an
echo und fgen Sie ein " /remove" hinzu: ".exe /remove"
echo Zum Hinzufgen einer Erweiterung, geben Sie die Erweiterung als z.B. ".exe" an
echo und fgen Sie ein " /add" hinzu: ".exe /add"
echo.
echo Mit "reset" setzen Sie die Liste zurck.
echo Ohne Eingabe kehren Sie zu der Konfiguration zurck.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
set /p Dateierweiterungsliste=Dateierweiterung: .
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if "%Dateierweiterungsliste%" == "" goto :Optionen
FOR /F "tokens=1,2 delims=/" %%A IN ("%Dateierweiterungsliste%") DO (
set Name=.%%A
if /I "%%B" == "remove" (
FOR /F "usebackq delims=" %%f IN (GDDtErw.ini) DO (
if not "%%f" == "*!Name:~0,-1!" echo %%f>>GDDtErw.tmp
)
move /Y GDDtErw.tmp GDDtErw.ini
set GD-Neustart=1
)
if /I "%%B" == "add" (
echo *!Name:~0,-1!>>GDDtErw.ini
FOR /F "usebackq delims=" %%q IN (`sort GDDtErw.ini`) DO echo %%q>>GDDtErw.tmp
move /Y GDDtErw.tmp GDDtErw.ini
set GD-Neustart=1
))
if /I "%Dateierweiterungsliste%" == "reset" call :Vor_Start3
goto :Dateierweiterungsliste














REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************





:Ende
if "%Counter3%" == "" set Counter3=1
cls
title G-Dawtech wird beendet...
echo Vielen Dank, dass Sie G-Dawtech verwendet haben.
echo.
if "!Counter3!" == "1" echo     [Û        ]
if "!Counter3!" == "2" echo     [Û±       ]
if "!Counter3!" == "3" echo     [Û±Û      ]
if "!Counter3!" == "4" echo     [Û±Û±     ]
if "!Counter3!" == "5" echo     [Û±Û±Û    ]
if "!Counter3!" == "6" echo     [Û±Û±Û±   ]
if "!Counter3!" == "7" echo     [Û±Û±Û±Û  ]
if "!Counter3!" == "8" echo     [Û±Û±Û±Û± ]
if "!Counter3!" == "9" echo     [Û±Û±Û±Û±Û]
ping localhost -n 2 >nul
if "!Counter3!" == "9" EXIT
set /a Counter3=!Counter3! +1
goto :Ende
