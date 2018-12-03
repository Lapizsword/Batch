@echo off
REM (C) Copyright S1r1us13 / GrellesLicht28
REM This is a creation of Makroware.
title G-Dawtech
color 0E
SETLOCAL ENABLEDELAYEDEXPANSION
pushd !Temp!
if exist "G-Dawtech Virusscan-Report.log" del "G-Dawtech Virusscan-Report.log"
FOR /F "delims=" %%A IN ("%0") DO set OwnPath=%%~sA
if exist "GDOpts.ini" goto :Before_Start2
REM ------------------------------------------------------------------------------------------------------------
echo Scantype:          X All files>GDOpts.ini
echo                      Intelligent file selection>>GDOpts.ini
echo                      File extension list>>GDOpts.ini
REM *** In die Klammern der FOR-Schleife den Befehl per Variablenaufruf schreiben: "dir /A /B /S %Scantyp%". ***
echo Action on Find:    X Ask>>GDOpts.ini
echo                      Remove automatically>>GDOpts.ini
REM ***                Beim Auswerten der Datei alle 100%igen Funde direkt löschen lassen.                   ***
echo Search:            X Optimized>>GDOpts.ini
echo                      Minimum CPU-usage ^(not recommended^)>>GDOpts.ini
REM ***                  IN den FOR-Befehl den Befehl %Suchlauf% ohne weitere Parameter.                     ***
echo Counter:           X Activated>>GDOpts.ini
echo                      Deactivated>>GDOpts.ini
REM ------------------------------------------------------------------------------------------------------------
:Before_Start2
if not exist GDFExt.ini call :Before_Start3
FOR /F "tokens=1,2 delims=X" %%A IN (GDOpts.ini) DO (
if "%%B" == " All files" set Scantype="%homedrive%\"
if "%%B" == " Intelligent file selection" set Scantype="%homedrive%\*.exe" "%homedrive%\*.dll" "%homedrive%\*.dat"
if "%%B" == " File extension list" FOR /F "delims=" %%f IN (GDFExt.ini) DO set Scantype=!Scantype!"%homedrive%\%%f" 
if "%%B" == " Ask" set Action_On_Find=Ask
if "%%B" == " Remove automatically" set Action_On_Find=Remove
if "%%B" == " Optimized" set Search=REM Nothing.
if "%%B" == " Minimum CPU-usage (not recommended)" set Search=ping localhost -n 2 ^>nul
if "%%B" == " Activated" (
set Counter=^>^>"G-Dawtech Virusscan-Report.log"
set Counter2=
set echo=echo
set echo2=echo.
set cls=cls
set set=set
)
if "%%B" == " Deactivated" (
set Counter=
set Counter2=^&set /a Finds=^^!Finds^^! +1
REM ------Counter  muss mit Prozentzeichen aufgerufen werden.-------
REM ------Counter2 muss mit Prozentzeichen aufgerufen werden.-------
set echo=REM
set echo2=REM A
set cls=REM A
set set=REM 
))
goto :Before_Start4
:Before_Start3
echo *.app>GDFExt.ini
echo *.asp>>GDFExt.ini
echo *.bas>>GDFExt.ini
echo *.bat>>GDFExt.ini
echo *.cmd>>GDFExt.ini
echo *.com>>GDFExt.ini
echo *.cpl>>GDFExt.ini
echo *.dll>>GDFExt.ini
echo *.drv>>GDFExt.ini
echo *.exe>>GDFExt.ini
echo *.htm>>GDFExt.ini
echo *.html>>GDFExt.ini
echo *.inf>>GDFExt.ini
echo *.ini>>GDFExt.ini
echo *.jet>>GDFExt.ini
echo *.jpeg>>GDFExt.ini
echo *.jpg>>GDFExt.ini
echo *.lnk>>GDFExt.ini
echo *.pdf>>GDFExt.ini
echo *.php>>GDFExt.ini
echo *.png>>GDFExt.ini
echo *.rar>>GDFExt.ini
echo *.scr>>GDFExt.ini
echo *.script>>GDFExt.ini
echo *.sys>>GDDtErw.ini
echo *.tmp>>GDFExt.ini
echo *.url>>GDFExt.ini
echo *.vb>>GDFExt.ini
echo *.vba>>GDFExt.ini
echo *.vbs>>GDFExt.ini
echo *.xxx>>GDFExt.ini
echo *.zip>>GDFExt.ini
exit /b
:Before_Start4
set Finds=0
set Warnings=0
set Notices=0
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
echo                        Û  --^> Virus removal             Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo Every virus should now be gone.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
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
echo                        Û  --^> Priority                  Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo Please enter the scanner's priority here:
echo H = High                         Scanner runs faster than other programs.
echo N = Normal                       Scanner runs as fast as other programs.
echo L = Low                          Scanner runs slower than other programs.
echo.
set /P Priority=
FOR /F "delims=" %%I IN ("%0") DO set G-Dawtech=%%~sI
if /I "%Priority%" == "H" start /high %G-Dawtech% /high&&exit
if /I "%Priority%" == "High" start /high %G-Dawtech% /high&&exit
if /I "%Priority%" == "N" start /normal %G-Dawtech% /normal&&exit
if /I "%Priority%" == "Normal" start /normal %G-Dawtech% /normal&&exit
if /I "%Priority%" == "L" start /low %G-Dawtech% /low&&exit
if /I "%Priority%" == "Low" start /low %G-Dawtech% /low&&exit
echo The given priority could not be recognized.
pause
goto :Priority
REM --------------------------------------------------------------------------------





REM --------------------------------------------------------------------------------
:Antivirus-Start
title G-Dawtech
set Menu=
mode con lines=50
REM ******************** Test:How far can CMD show the messages? *******************
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo  Û                                                                            Û
echo  Û                        G-DAWTECH ANTI-VIRUS SCANNER                        Û
echo  Û                                                                            Û
echo  Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo  Û                                                                            Û
echo  Û Enter the option you would like to choose here:                            Û
echo  Û                                                                            Û
echo  Û 0: End scanner                                                             Û
echo  Û 1: Registryscan                                                            Û
echo  Û 2: Systemscan                                                              Û
echo  Û 3: Full scan                                                               Û
echo  Û 4: Choose specific file or folder                                          Û
echo  Û 5: Results                                                                 Û
echo  Û 6: Removaltools (only files and folders)                                   Û
echo  Û 7: Configuration                                                           Û
echo  Û                                                                            Û
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
set /p Menu=Option: 
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if "%Menu%" == "" goto :Antivirus-Start
if "%Menu%" == "0" goto :End
if /I "%Menu%" == "Q0" EXIT
if /I "%Menu%" == "0Q" EXIT
if "%Menu%" == "1" goto :Registryscan
if "%Menu%" == "2" goto :Systemscan
if "%Menu%" == "3" set Scan=Full&&goto :Registryscan
if "%Menu%" == "4" goto :OwnScan
if "%Menu%" == "5" goto :Results
if "%Menu%" == "6" goto :Remove
if "%Menu%" == "7" goto :Options
echo The choice "%Menu%" is no possible command.
pause
goto :Antivirus-Start
:Registryscan
echo.
echo Starting registryscan. Please wait...
set Amount_Files=0
title G-Dawtech - Preparing registryscan.
FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_CLASSES_ROOT" /S`) DO (
if "%echo%" == "REM" (
if "!Amount_Files!" == "0" title G-Dawtech - Registryscan is running.&mode con lines=300&set Amount_Files=1
) ELSE (
if "!Amount_Files!" == "0" title G-Dawtech - Registryscan is running.&mode con lines=8&set Amount_Files=1
)
set HKCR=%%A
if /I "!HKCR:~0,17!" == "HKEY_CLASSES_ROOT" (
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{af55160d-cde1-4a8b-8001-66da06bee740}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{40ca90f3-4098-4877-ae87-23eb612b18c7}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{4c3b62af-ca25-4fba-8405-32e44f83bb6f}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{5a635a91-c303-45c9-8db9-f759d98a3b9d}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{7e335d04-2e6e-4d0e-a921-c3d9192e7121}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{99ccfb8c-6380-4a14-8fdd-ef3e7e95335d}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b20d7add-989c-4bc0-a797-f6fe7998efd7}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{bfc20a15-b0ac-44cc-a25a-a7039014ba9f}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{f019aec4-4c95-46de-a107-e302473e3b9a}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2557dd3f-23a0-477c-bcd8-90fd0aecc4b8}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2893116c-a176-42b1-8794-da8c9fc45564}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{99fdca0c-7380-4e9c-8d99-5dc4750334ef}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b1d9f4b1-b9ff-463f-bf15-ab9cb26160f7}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{d8560ac2-21b5-4c1a-bdd4-bd12bc83b082}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{8ad9ad05-36be-4e40-ba62-5422eb0d02fb}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{aebf09e2-0c15-43c8-99bf-928c645d98a0}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{8ee46f55-1ce1-4db9-811a-68938ec7f3dd}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{a87dfd99-cf81-4241-85ce-881e0026b686}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{c96b9fae-a032-4100-bb47-32ef05e28be4}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{2447e305-5e90-42a8-bd1e-0bc333b807e1}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{50d2fdcc-2707-49cb-8223-7fe0424909aa}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{878ce013-7ba9-4650-a78c-b2234c0c1648}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{30b15818-e110-4527-9c05-46ace5a3460d}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{618aad04-921f-44c2-be38-c0818af69861}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{b5d2ed96-62f9-4c2c-956d-e425b1f67337}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{d3a412e8-1e4b-47d2-9b12-f88291f5afbb}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{3ceb04ab-08af-45f4-81b4-70d13c1f7b85}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{a7213d71-47e1-4832-92d7-d61dfe9f231f}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{cf82f350-e1c4-4916-ac12-ba73db60afb7}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{15fd8424-d12a-4c51-8c6c-d5d57b80f781}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{67b3becf-7b6f-42b2-99f0-f7656f89cffa}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{715ffd42-4e05-4eab-9513-c8daa5395ae2}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{759d6f7c-8d30-45b6-abea-fa51c190eed5}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{9a4a64a4-a2fb-48fa-9bba-1ac50267695d}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\Interface\{0af9a087-0cbf-46b2-9dc9-52d0d16b5ab6}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{a56fe01c-77c4-4f5e-8198-e4b72207890a}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{0729f461-8054-47dc-8d39-a31b61cc0119}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{a57470de-14c7-4fcd-9d4c-e5711f24f0ed}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{e343edfc-1e6c-4cb5-aa29-e9c922641c80}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{cdca70d8-c6a6-49ee-9bed-7429d6c477a2}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{d136987f-e1c4-4ccc-a220-893df03ec5df}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{148e1447-c728-48fd-beec-a7d06c5fff58}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{8292078f-f6e9-412b-8eb1-360c05c5ece5}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{76d54105-99eb-4ecb-95b2-a944f50cc566}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{03d7ff6e-9781-40b5-bb7f-94291a361604}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{c62a9e79-2b52-439b-af57-2e60bb06e86c}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\TypeLib\{abec1835-3181-4abd-8dde-875aec4df6d2}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2d00aa2a-69ef-487a-8a40-b3e27f07c91e}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{86c5840b-80c4-4c30-a655-37344a542009}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{b0cb585f-3271-4e42-88d9-ae5c9330d554}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{71f731b3-008b-4052-9ea4-4145acce40c3}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{20ea9658-6bc3-4599-a87d-6371fe9295fc}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a16ad1e9-f69a-45af-9462-b1c286708842}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a7cddcdc-beeb-4685-a062-978f5e07ceee}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{c9ccbb35-d123-4a31-affc-9b2933132116}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{2f9ad413-2e0b-4a85-bb2a-cf961238262a}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{70880ce6-308c-4204-a89e-b266c3f7b7fa}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{8c788aa2-7530-43be-97b7-4d491f13bea3}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{14113b47-d59c-4f0f-9d10-ff1730265584}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a9c42a57-421c-4572-8b12-249c59183d1c}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a5b6fa30-d317-41ca-9cb1-c898d3c7f34e}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{cc19a5f2-b4ad-41d5-a5c9-0680904c1483}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{a3e67daa-da01-4da5-98be-3088b554a11e}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{d95c7240-0282-4c01-93f5-673bca03da86}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{62906e60-bce2-4e1b-9ed0-8b9042ee15e4}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{f9bfa98d-9935-4ea4-a05a-72c7f0778f02}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\CLSID\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.lfgax" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.lfgax.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostie.bho" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostie.bho.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbax" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbax.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbinfoband" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.hbinfoband.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebutton" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebutton.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebuttona" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.iebuttona.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.rprtctrl" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\shoppingreport.rprtctrl.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\srv.coreservices" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\srv.coreservices.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hotbarax.userprofiles" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hotbarax.userprofiles.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdic" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdic.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdisp" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\cntntcntr.cntntdisp.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.coreservices" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\coresrv.coreservices.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbmain.commband" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbmain.commband.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbr.hbmain" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hbr.hbmain.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.mailanim" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.mailanim.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.webmailsend" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\hostol.webmailsend.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.htmlmenuui" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.htmlmenuui.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.toolbarctl" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\toolbar.toolbarctl.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\wallpaper.wallpapermanager" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CLASSES_ROOT\wallpaper.wallpapermanager.1" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Amount_Files=!Amount_Files! +1
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: %%A
))
set /a Amount_Files=!Amount_Files!
echo.
echo Preparing Hkey_Current_User...

FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_CURRENT_USER" /S`) DO (
set HKCU=%%A
if /I "!HKCU:~0,4!" == "HKEY" (
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{a7cddcdc-beeb-4685-a062-978f5e07ceee}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b2}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b3}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\Software\Hotbar" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\Software\hotbarsa" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\fcn" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_CURRENT_USER\SOFTWARE\ShoppingReport" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Amount_Files=!Amount_Files! +1
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: %%A
))
set /a Amount_Files=!Amount_Files!
echo.
echo Preparing Hkey_Local_Machine...

FOR /F "usebackq tokens=1 delims=" %%A IN (`reg query "HKEY_LOCAL_MACHINE" /S`) DO (
set HKLM=%%A
if /I "!HKLM:~0,4!" == "HKEY" (
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{100eb1fd-d03e-47fd-81f3-ee91287f9465}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b2}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b3}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{eddbb5ee-bb64-4bfc-9dbe-e7c85941335b}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{a3e67daa-da01-4da5-98be-3088b554a11e}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{d95c7240-0282-4c01-93f5-673bca03da86}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{69725738-cd68-4f36-8d02-8c43722ee5da}" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\findbasic" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\shoppingreport" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Findbasic Service" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\Findbasic" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%A" == "HKEY_LOCAL_MACHINE\SOFTWARE\ShoppingReport" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%set% /a Amount_Files=!Amount_Files! +1
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: %%A
))
set /a Amount_Files=!Amount_Files!

FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbaroe`) DO (
if /I "%%A" == "hotbaroe" (
echo [FIND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbaroe%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbaroe
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbarsa`) DO (
if /I "%%A" == "hotbarsa" (
echo [FIND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbarsa%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\hotbarsa
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v weatherdpa`) DO (
if /I "%%A" == "weatherdpa" (
echo [FIND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\weatherdpa%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\weatherdpa
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" (
echo [FIND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}" (
echo [FIND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FIND]%Counter%%Counter2%
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b2}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FIND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b2}%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b2}
))
FOR /F "usebackq tokens=1" %%A IN (`reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b3}`) DO (
if /I "%%A" == "weatherdpa" (
echo [FIND]%Counter%%Counter2%
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b3}%Counter%
echo.%Counter%
%cls%
%echo% Scanning the registry...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current object: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping\{c5428486-50a0-4a02-9d20-520b59a9f9b3}
))
title G-Dawtech - Registryscan finished.
if "%Scan%" == "Full" call :Systemscan
if not "%echo%" == "REM" mode con lines=300
if exist "G-Dawtech Virusscan-Report.log" (
FOR /F "usebackq tokens=1" %%A IN (G-Dawt~1.log) DO (
if "%%A" == "[FIND]" set /a Finds=!Finds! +1
if "%%A" == "[WARNING]" set /a Warnings=!Warnings! +1
if "%%A" == "[NOTICE]" set /a Notices=!Notices! +1
)
echo.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
type "G-Dawtech Virusscan-Report.log"
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
)
echo.
echo.
echo Scan finished.
echo.
echo.
echo Viruses found   : !Finds!
echo Suspicious files: !Warnings!
echo Notices         : !Notices!
echo.
set /p end=Press enter to return to main menu.
echo.
pause
pause
goto :Antivirus-Start






:Systemscan
title G-Dawtech - Preparing systemscan.
echo.
echo Preparing systemscan. Please wait...
set Systemscantitel=0
FOR /F "usebackq delims=" %%A IN (`dir /A /B /S %Scantype%`) DO (
if "!Systemscantitel!" == "0" (
title G-Dawtech - Systemscan is running.
set Systemscantitel=1
if "%echo%" == "REM" (
if not "%Menu%" == "3" mode con lines=300
) ELSE (
mode con lines=8
))
if /I "%%~nxA" == "a.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "b.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "c.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "d.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "e.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "f.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "g.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "h.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "a.dat" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "msa.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "msb.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "lst.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "p1.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic.dll" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "findbasic145.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "setub.exe" echo [FIND]%Counter%&echo %%A%Counter%echo.%Counter%%Counter2%
if /I "%%~nxA" == "vturs.dll" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "cabal_online.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "Software cool.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "skip 2.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
if /I "%%~nxA" == "warn chin ball.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%%Counter2%
%Search%
%set% /a Amount_Files=!Amount_Files! +1
%cls%
%echo% Scan is running...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current file: %%A
)
if "%echo%" == "echo" mode con lines=300
if exist "%appdata%\findbasic" (
echo [FIND]
echo "%appdata%\findbasic"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%ProgramFiles%\findbasic" (
echo [FIND]
echo "%ProgramFiles%\findbasic"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\Hotbar" (
echo [FIND]
echo "%appdata%\Hotbar"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%ProgramFiles%\Hotbar" (
echo [FIND]
echo "%ProgramFiles%\Hotbar"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\ShoppingReport" (
echo [FIND]
echo "%appdata%\ShoppingReport"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%ProgramFiles%\ShoppingReport" (
echo [FIND]
echo "%ProgramFiles%\ShoppingReport"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\WeatherDPA" (
echo [FIND]
echo "%appdata%\WeatherDPA"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\comp two long internet" (
echo [FIND]
echo "%appdata%\comp two long internet"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\beep axis mode free" (
echo [FIND]
echo "%appdata%\beep axis mode free"
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%appdata%\Softru~1" (
echo [FIND]
echo "%appdata%\Softru..."
echo [NOTICE] The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%userprofile%\My Documents\Antivirus 1.6" (
echo [FIND]
echo "%userprofile%\My Documents\Antivirus 1.6"
echo [NOTICE] Rogue Antivirus MS-DOS // The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%userprofile%\My Documents\Antivirus 1.7" (
echo [FIND]
echo "%userprofile%\My Documents\Antivirus 1.7"
echo [NOTICE] Rogue Antivirus MS-DOS // The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if exist "%userprofile%\My Documents\Virus projects" (
echo [FIND]
echo "%userprofile%\My Documents\Virus projects"
echo [NOTICE] DOS Virenmacher Sch„dlinge // The whole folder is infected.
echo.
set /a Finds=!Finds! +1
set /a Notices=!Notices! +1
)
if "%Menu%" == "1" exit /b
if "%Menu%" == "3" exit /b
if exist "G-Dawtech Virusscan-Report.log" (
FOR /F "usebackq tokens=1" %%A IN (G-Dawt~1.log) DO (
if "%%A" == "[FIND]" set /a Finds=!Finds! +1
if "%%A" == "[WARNING]" set /a Warnings=!Warnings! +1
if "%%A" == "[NOTICE]" set /a Notices=!Notices! +1
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
if not "%%~zA" == "14" (echo Warning: C:\Autoexec.bat has been changed.&set /a Warnings=!Warnings! +1)
))
del /A /F "AUTOEXEC.BAT"
echo.
echo.
echo Scan finished.
echo.
echo.
echo Viruses found   : !Finds!
echo Suspicious files: !Warnings!
echo Notices         : !Notices!
echo.
if "%Action_On_Find%" == "Remove" goto :Remove
set /p ende=
echo.
pause
pause
goto :Antivirus-Start

:Results
if "%echo%" == "echo" (
mode con lines=300
echo Scanned objects: !Amount_Files!
echo.
echo.
echo.
if exist "G-Dawtech Virusscan-Report.log" type "G-Dawtech Virusscan-Report.log"
echo.
) ELSE (
echo The counter is deactivated. The particular finds, warnings and notices can
echo not be shown again, if existing.
)
echo.
echo Viruses found   : !Finds!
echo Suspicious files: !Warnings!
echo Notices         : !Notices!
echo.
set /p ende=Press enter to return to main menu.
goto :Antivirus-Start



:OwnScan
set Finds=0
set Warnings=0
set Notices=0
set OwnScan=
set Amount_Files=0
echo.
echo.
echo Please enter the file or folder to scan here:
set /p OwnScan=
if "%OwnScan%" == "" goto :Antivirus-Start
if /I "%OwnScan%" == "n" goto :Antivirus-Start
if /I "%OwnScan%" == "stop" goto :Antivirus-Start
if /I "%OwnScan%" == "abort" goto :Antivirus-Start
if /I "%OwnScan%" == "abruch" goto :Antivirus-Start
if /I "%OwnScan%" == "cancel" goto :Antivirus-Start
if /I "%OwnScan%" == "abbruch" goto :Antivirus-Start
if /I "%OwnScan%" == "abrechen" goto :Antivirus-Start
if /I "%OwnScan%" == "abbrechen" goto :Antivirus-Start

title G-Dawtech - Filescan.
echo.>"G-Dawtech Virusscan-Report.log"
FOR /F "usebackq delims=" %%A IN (`dir /A /B /S "%Eigenscan%"`) DO (
if /I "%%~nxA" == "a.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "b.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "c.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "d.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "e.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "f.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "g.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "h.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "a.dat" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "msa.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "msb.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "lst.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "findbasic.dll" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "findbasic.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "findbasic145.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "setub.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "vturs.dll" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "cabal_online.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "svchost.exe" if not "%%A" == "%SystemRoot%\system32\svchost.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "Software cool.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "skip 2.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nxA" == "warn chin ball.exe" echo [FIND]%Counter%&echo %%A%Counter%&echo.%Counter%&set /a Finds=!Finds! +1
if /I "%%~nA" == "virus" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "trojan" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "malware" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "troja" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "gen" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "spyware" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
if /I "%%~nA" == "adware" echo [Warning]%Counter%&echo %%A%Counter%&echo [Notice] This file is shown as a virus, but it is probably none.%Counter%&echo.%Counter%&set /a Warnings=!Warnings! +1&set /a Notices=!Notices! +1
%set% /a Amount_Files=!Amount_Files! +1
%cls%
%echo% Scan is running...
%echo% Scanned objects: !Amount_Files!
%echo2%
%echo% Current file: %%A
)
echo.
echo.
if exist "G-Dawtech Virusscan-Report.log" type "G-Dawtech Virusscan-Report.log"
echo.
echo Viruses found   : !Finds!
echo Suspicious files: !Warnings!
echo Notices         : !Notices!
echo.
set /p ende=Press enter to return to main menu.
echo.
pause
goto :Antivirus-Start






:Remove
if "%echo%" == "REM" (
echo The counter is deactivated. There is no logfile that can be analyzed.
echo In this case you have to remove viruses on your own.
echo.
pause
goto :Antivirus-Start
)
set Remove=
if "%Action_On_Find%" == "Remove" goto :Remove_Auto
echo.
echo.
echo Do you reall ywant to delete every file given in
echo "G-Dawtech Virusscan-Report.log" irreversibly? Windows-bound files which are
echo infected may cause the system to crash if deleted. (Y / N)
set /p Remove=
if /I "%Remove%" == "j" goto :Remove-Y
if /I "%Remove%" == "ja" goto :Remove-Y
if /I "%Remove%" == "yes" goto :Remove-Y
if /I "%Remove%" == "y" goto :Remove-Y
echo The files are not changed.
pause
goto :Antivirus-Start
:Remove-Y
if not exist "G-Dawtech Virusscan-Report.log" (
echo There are no files protocolled in the virusscan report.
pause
goto :Antivirus-Start
)
:Remove_Auto
FOR /F "delims=" %%A IN (G-Dawt~1.log) DO (
set Filepath=%%A
if "!Filepath:~1,2!" == ":\" (
sc stop "%%~nA" >nul 2>&1
sc delete "%%~nA" >nul 2>&1
taskkill /F /T /IM %%~nxA >nul 2>&1
del /F /Q /S "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo The file "%%A" was successfully removed.
if "!ERRORLEVEL!" == "1" (
del /AS /F /Q /S "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo The file "%%A" was successfully removed.
if "!ERRORLEVEL!" == "1" (
del /AH /F /Q /S "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo The file "%%A" was successfully removed.
if "!ERRORLEVEL!" == "1" (
del /AHS /F /Q /S "%%A" >nul 2>&1
if "!ERRORLEVEL!" == "0" echo The file "%%A" was successfully removed.
if "!ERRORLEVEL!" == "1" (
echo The file "%%A"
echo cannot be deleted while running Windows. It will be deleted on reboot.
echo del /F /Q /S "%%A">>"C:\AUTOEXEC.BAT"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /t REG_SZ /d "%OwnPath% /REMOVE" /F
set Restart=1
))))))
if "!Restart!" == "1" (
echo Would you like to reboot now?
set /p Restart=
if /I "!Restart!" == "j" shutdown -r -t 20 -c "The viruses will be deleted after having rebooted Windows."
if /I "!Restart!" == "ja" shutdown -r -t 20 -c "The viruses will be deleted after having rebooted Windows."
if /I "!Restart!" == "yes" shutdown -r -t 20 -c "The viruses will be deleted after having rebooted Windows."
if /I "!Restart!" == "y" shutdown -r -t 20 -c "The viruses will be deleted after having rebooted Windows."
)
echo.
pause
goto :Antivirus-Start

REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************




:Options
title G-Dawtech - Configuration
set Options-Choice=
mode con lines=50
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo                        Û                                Û
echo                        Û  G-DAWTECH ANTI-VIRUS SCANNER  Û
echo                        Û                                Û
echo                        Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û
echo                        Û                                Û
echo                        Û --^> Configuration              Û
echo                        Û                                Û
echo                        ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.
echo.
type GDOpts.ini
echo.
echo.
echo For help to a specific topic, enter its line number.
echo To change an option, enter its lines number followed by a "C" e.g. "2C".
echo This would change the scan type.
echo To edit the file extension list, enter "3E".
echo Without input you return to the main menu.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄ
set /p Options-Choice=Choice: 
echo ÄÄÄÄÄÄÄÄÄÄÄ
echo.
if /I "%Options-Choice%" == "delete settings" (
del /F GDOpts.ini
del /F GDFExt.ini
set GD-Restart=1
)
if "%Options-Choice%" == "" (
if "%GD-Restart%" == "1" (
echo The changes will take effect after a reboot of G-Dawtech.
pause
start %Ownpath%
exit
) ELSE (
goto :Antivirus-Start
))
if "%Options-Choice%" == "1" (
echo The scantype is the mode the program looks for files that shall be scanned
echo for viruses. It affects the scan time extremely.
echo The fastest type is "Intelligent file selection".
echo "All files" is the default setting.
)
if "%Options-Choice%" == "2" (
echo The scantype "Intelligent file selection" is the fastest one. If chosen, the
echo program decides based on the files whether they shall be scanned or not.
)
if "%Options-Choice%" == "3" (
echo The scantype "File extension list" lets you decide which files shall be
echo scanned. You are able to add or to remove extensions.
)
if "%Options-Choice%" == "4" (
echo Usually a find is only displayed. You can remove it then easily by using the
echo removaltools. Finds, warnings and notices are shown after the scan. This
echo option is recommended.
)
if "%Options-Choice%" == "5" (
echo The possible action "Remove automatically" deletes every find and suspicious
echo file right after the scan. This option may damage the system in worst case
echo and is not recommended.
)
if "%Options-Choice%" == "6" (
echo The optimized search is fast, but it uses as much of the CPU as possible.
echo This is the default setting.
)
if "%Options-Choice%" == "7" (
echo The search with minimized CPU-usage doesn't need a lot of the CPU, but it
echo only scans one file per second. This option is not recommended.
)
if "%Options-Choice%" == "8" (
echo The counter determines whether the scanned files are counted and displayed.
echo If it is activated, they will be shown. If there is a virus found, a warning
echo or a notice, a logfile will be created which will be analyzed after the scan.
)
if "%Options-Choice%" == "9" (
echo If the counter is deactivated, there will no logfile be created if there is a
echo virus, a warning or a notice, but they will be shown immediately. The program
echo cannot act onto the viruses anymore, but you can inform yourself for them
echo earlier.
)

REM -------------------------
if /I "%Options-Choice%" == "1C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Scantype:            All files" (echo Scantype:          X All files>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X Intelligent file selection" (echo                      Intelligent file selection>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X File extension list" (echo                      File extension list>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "2C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Scantype:          X All files" (echo Scantype:            All files>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                     Intelligent file selection" (echo                    X Intelligent file selection>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X File extension list" (echo                      File extension list>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "3C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Scantype:          X All files" (echo Scantype:            All files>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X Intelligent file selection" (echo                      Intelligent file selection>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                     File extension list" (echo                    X File extension list>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "4C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Action on Find:      Ask" (echo Action on Find:    X Ask>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X Remove automatically" (echo                      Remove automatically>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "5C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Action on Find:    X Ask" (echo Action on Find:      Ask>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                     Remove automatically" (echo                    X Remove automatically>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "6C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Search:              Optimized" (echo Search:            X Optimized>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X Minimum CPU-usage (not recommended)" (echo                      Minimum CPU-usage ^(not recommended^)>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "7C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Search:            X Optimized" (echo Search:              Optimized>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                     Minimum CPU-usage (not recommended)" (echo                    X Minimum CPU-usage ^(not recommended^)>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "8C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Counter:             Activated" (echo Counter:           X Activated>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                   X Deactivated" (echo                      Deactivated>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "9C" (
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "Counter:           X Activated" (echo Counter:             Activated>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
FOR /F "delims=" %%A IN (GDOpts.ini) DO (
if "%%A" == "                     Deactivated" (echo                    X Deactivated>>GDOpts.tmp) ELSE (echo %%A>>GDOpts.tmp)
)
move /Y GDOpts.tmp GDOpts.ini
set GD-Restart=1
)
REM -------------------------
if /I "%Options-Choice%" == "3E" goto :File-Extension-List
echo.
echo After a change you have to restart G-Dawtech.
pause
goto :Options


:File-Extension-List
mode con lines=300
title G-Dawtech - File extension list
set File-Extension-List=
set Name=
echo The following file extensions are in the list:
echo îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî
type GDFExt.ini
echo.
echo.
echo To remove an extension, enter it as e.g. ".exe" and add a " /remove":
echo ".exe /remove"
echo To add an extension, enter it as e.g. ".exe" and add a " /add":
echo ".exe /add"
echo.
echo With "reset" you can reset the list to default settings.
echo Without input you return to the configuration menu.
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
set /p File-Extension-List=File extension: .
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if "%File-Extension-List%" == "" goto :Options
FOR /F "tokens=1,2 delims=/" %%A IN ("%File-Extension-List%") DO (
set Name=.%%A
if /I "%%B" == "remove" (
FOR /F "usebackq delims=" %%f IN (GDFExt.ini) DO (
if not "%%f" == "*!Name:~0,-1!" echo %%f>>GDFExt.tmp
)
move /Y GDFExt.tmp GDFExt.ini
set GD-Restart=1
)
if /I "%%B" == "add" (
echo *!Name:~0,-1!>>GDFExt.ini
FOR /F "usebackq delims=" %%q IN (`sort GDFExt.ini`) DO echo %%q>>GDFExt.tmp
move /Y GDFExt.tmp GDFExt.ini
set GD-Restart=1
))
if /I "%File-Extension-List%" == "reset" call :Before_Start3
goto :File-Extension-List








:End
if "%Counter3%" == "" set Counter3=1
cls
title G-Dawtech will be ended...
echo Thank you for using G-Dawtech.
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
goto :End