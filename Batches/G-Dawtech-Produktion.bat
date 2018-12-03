@echo off
REM (C) Copyright S1r1us13 / GrellesLicht28
REM This is a creation of Makroware.

REM *************************************************************
REM *								*
REM * DLL-Datei für Registryschlüssel				*
REM * DLL-Datei für normale Dateien				*
REM * DLL-Datei für Ordner					*
REM * DLL-Datei für Quick Scan					*
REM * BAT-Datei für Hauptscanner				*
REM * BAT-Datei für Ende					*
REM * BAT-Datei für Priorität					*
REM * BAT-Datei für entfernen [call XYZ.bat]			*
REM * BMP-Datei für Logo					*
REM * LOG-Datei für Scanzeiten					*
REM *								*
REM *************************************************************

REM *************************************************************
REM *								*
REM * RegCR.dll ; RegCU.dll ; RegLM.dll ; RegV.dll		*
REM * InfctdFiles.dll						*
REM * InfctdFolders.dll 					*
REM * QFls.dll 							*
REM * GDscan.bat						*
REM * egd.bat							*
REM * G-Dawtech.bat						*
REM * Rmv.bat							*
REM * Logo.bmp							*
REM * G-Dawtech Virusscan-Report_%date%_%time%.log		*
REM *								*
REM *************************************************************

title G-Dawtech Setup
echo -----------------
echo Do you wish to install G-Dawtech? (Y / N)
set /P Install1=
echo -----------------
if /I "%Install1%" == "y" goto :License
if /I "%Install1%" == "ye" goto :License
if /I "%Install1%" == "ya" goto :License
if /I "%Install1%" == "yes" goto :License
if /I "%Install1%" == "yeah" goto :License
if /I "%Install1%" == "j" goto :License
if /I "%Install1%" == "jo" goto :License
if /I "%Install1%" == "ja" goto :License
if /I "%Install1%" == "joa" goto :License
if /I "%Install1%" == "o" goto :License
if /I "%Install1%" == "oui" goto :License
if /I "%Install1%" == "ouais" goto :License
if /I "%Install1%" == "si" goto :License
if /I "%Install1%" == "sí" goto :License
if /I "%Install1%" == "sì" goto :License
if /I "%Install1%" == "tak" goto :License
if /I "%Install1%" == "evet" goto :License
echo The installation was cancelled.
pause
exit /B




:License
echo LICENSE AGREEMENT
echo.
echo 1. LICENSE AGREEMENT
echo By continuing you agree to be bound by the terms of this License.
echo You agree to let the developers have the rights to remove, change, check
echo or to modify the program in any way and to delete all copies of it.
echo.
echo 2. SOFTWARE USAGE PERMISSION
echo In agreeing the License G-Dawtech Antivirus will be available for you and run,
echo work and help you to find and delete viruses as well as possible.
echo.
echo READ THE FOLLOWING TERMS CAREFULLY AND ENTIRELY
echo -You may NOT resell, copy, sub-license, rent, lease or distribute the
echo  software without our written permission to do so. We reserve the right
echo  to withdraw any changes, installed programs or modified files.
echo -You may NOT repackage, translate, adapt or create derivative works
echo  based upon G-Dawtech in whole or in part.
echo -You may NOT use the software to engage in any illegal activity like
echo  prorgamming destructive, informinating, stealing, dialing or phishing
echo  software.
echo -You may NOT modify, change, transfer or assign your rights under this License
echo  to any person or authorise all or any part of the software to be copied.
echo -You may NOT add, replace, remove, delete or unlimit any right given to you
echo  by this License.
echo.
echo 3. LAW AND JUSTICE
echo If you agree the terms of this License you must not violate the conditions.
echo Any violation will be prosecuted by law and punished by payments and
echo prison.
echo.
echo 4. GENERAL
echo -If any part of this License was not completely understandable the punishments
echo  are still valid. Contact any helper to make sure you do not violate against
echo  the terms of this License.
echo -If any part of this License has to be changed, modified or deleted, please
echo  contact us per E-mail without doing any changes without our permission
echo  or on your own.
echo -This License is written, signed and authorised by our employers from
echo  Makroware.
echo -Updates may be licensed to you by Makroware with additional or different
echo  terms of use, but we do not have obligation to provide any other Licenses
echo  than this one or to provide any updates.
echo -This License is the entire agreement between you and us and supply specific
echo  rights to you to use the software, but also to us to deliver any
echo  advertising, undertakings or representations to the software and you due to
echo  your knowledge.
echo -Makroware is entitled to change, transfer, assign, delete or to remove any
echo  of the rights given to you by this License agreement at any time.
echo.
echo.
echo Do you agree to the terms of this License agreement? (Y / N)
set /p License-Agreement=
if /I "%License-Agreement%" == "y" goto :Installer
if /I "%License-Agreement%" == "ye" goto :Installer
if /I "%License-Agreement%" == "ya" goto :Installer
if /I "%License-Agreement%" == "yes" goto :Installer
if /I "%License-Agreement%" == "yeah" goto :Installer
if /I "%License-Agreement%" == "j" goto :Installer
if /I "%License-Agreement%" == "jo" goto :Installer
if /I "%License-Agreement%" == "ja" goto :Installer
if /I "%License-Agreement%" == "joa" goto :Installer
if /I "%License-Agreement%" == "o" goto :Installer
if /I "%License-Agreement%" == "oui" goto :Installer
if /I "%License-Agreement%" == "ouais" goto :Installer
if /I "%License-Agreement%" == "si" goto :Installer
if /I "%License-Agreement%" == "sí" goto :Installer
if /I "%License-Agreement%" == "sì" goto :Installer
if /I "%License-Agreement%" == "tak" goto :Installer
if /I "%License-Agreement%" == "evet" goto :Installer
echo -----------------
echo The installation was cancelled.
pause
exit /B






:Installer
echo -----------------
echo.
echo Please enter the folder you would like to use for G-Dawtech:
set /P Install-Path=
if not exist "%Install-Path%" (
echo The folder does not exist, would you like to create one? (Y / N^)
set /P Install-Path_New-Folder=
if /I "%Install-Path_New-Folder%" == "n" goto :Installer
if /I "%Install-Path_New-Folder%" == "ne" goto :Installer
if /I "%Install-Path_New-Folder%" == "no" goto :Installer
if /I "%Install-Path_New-Folder%" == "nee" goto :Installer
if /I "%Install-Path_New-Folder%" == "nie" goto :Installer
if /I "%Install-Path_New-Folder%" == "non" goto :Installer
if /I "%Install-Path_New-Folder%" == "not" goto :Installer
if /I "%Install-Path_New-Folder%" == "pas" goto :Installer
if /I "%Install-Path_New-Folder%" == "yok" goto :Installer
if /I "%Install-Path_New-Folder%" == "nein" goto :Installer
if /I "%Install-Path_New-Folder%" == "nope" goto :Installer
if /I "%Install-Path_New-Folder%" == "hayir" goto :Installer
if /I "%Install-Path_New-Folder%" == "degil" goto :Installer
if /I "%Install-Path_New-Folder%" == "never" goto :Installer
if /I "%Install-Path_New-Folder%" == "nicht" goto :Installer
MD "%Install-Path%"
)
:Install-Type
echo.
echo Would you like to do a full or a quick installation?
echo 1: full			2: quick
set /p Install-Type=
if not "%Install-Type%" == "1" (
if not "%Install-Type%" == "2" (
echo Command could not be recognized.
pause
goto :Install-Type
))
cls
echo G-Dawtech Setup is starting.
echo.
echo HKEY_CLASSES_ROOT\Interface\{af55160d-cde1-4a8b-8001-66da06bee740}>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{40ca90f3-4098-4877-ae87-23eb612b18c7}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{4c3b62af-ca25-4fba-8405-32e44f83bb6f}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{5a635a91-c303-45c9-8db9-f759d98a3b9d}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{7e335d04-2e6e-4d0e-a921-c3d9192e7121}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{99ccfb8c-6380-4a14-8fdd-ef3e7e95335d}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{b20d7add-989c-4bc0-a797-f6fe7998efd7}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{bfc20a15-b0ac-44cc-a25a-a7039014ba9f}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{f019aec4-4c95-46de-a107-e302473e3b9a}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{2557dd3f-23a0-477c-bcd8-90fd0aecc4b8}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{2893116c-a176-42b1-8794-da8c9fc45564}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{99fdca0c-7380-4e9c-8d99-5dc4750334ef}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{b1d9f4b1-b9ff-463f-bf15-ab9cb26160f7}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{d8560ac2-21b5-4c1a-bdd4-bd12bc83b082}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{8ad9ad05-36be-4e40-ba62-5422eb0d02fb}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{aebf09e2-0c15-43c8-99bf-928c645d98a0}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{8ee46f55-1ce1-4db9-811a-68938ec7f3dd}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{a87dfd99-cf81-4241-85ce-881e0026b686}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{c96b9fae-a032-4100-bb47-32ef05e28be4}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{2447e305-5e90-42a8-bd1e-0bc333b807e1}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{50d2fdcc-2707-49cb-8223-7fe0424909aa}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{878ce013-7ba9-4650-a78c-b2234c0c1648}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{30b15818-e110-4527-9c05-46ace5a3460d}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{618aad04-921f-44c2-be38-c0818af69861}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{b5d2ed96-62f9-4c2c-956d-e425b1f67337}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{d3a412e8-1e4b-47d2-9b12-f88291f5afbb}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{3ceb04ab-08af-45f4-81b4-70d13c1f7b85}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{a7213d71-47e1-4832-92d7-d61dfe9f231f}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{cf82f350-e1c4-4916-ac12-ba73db60afb7}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{15fd8424-d12a-4c51-8c6c-d5d57b80f781}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{67b3becf-7b6f-42b2-99f0-f7656f89cffa}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{715ffd42-4e05-4eab-9513-c8daa5395ae2}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{759d6f7c-8d30-45b6-abea-fa51c190eed5}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{9a4a64a4-a2fb-48fa-9bba-1ac50267695d}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\Interface\{0af9a087-0cbf-46b2-9dc9-52d0d16b5ab6}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{a56fe01c-77c4-4f5e-8198-e4b72207890a}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{0729f461-8054-47dc-8d39-a31b61cc0119}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{a57470de-14c7-4fcd-9d4c-e5711f24f0ed}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{e343edfc-1e6c-4cb5-aa29-e9c922641c80}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{cdca70d8-c6a6-49ee-9bed-7429d6c477a2}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{d136987f-e1c4-4ccc-a220-893df03ec5df}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{148e1447-c728-48fd-beec-a7d06c5fff58}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{8292078f-f6e9-412b-8eb1-360c05c5ece5}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{76d54105-99eb-4ecb-95b2-a944f50cc566}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{03d7ff6e-9781-40b5-bb7f-94291a361604}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{c62a9e79-2b52-439b-af57-2e60bb06e86c}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\TypeLib\{abec1835-3181-4abd-8dde-875aec4df6d2}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{2d00aa2a-69ef-487a-8a40-b3e27f07c91e}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{86c5840b-80c4-4c30-a655-37344a542009}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{b0cb585f-3271-4e42-88d9-ae5c9330d554}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{71f731b3-008b-4052-9ea4-4145acce40c3}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{100eb1fd-d03e-47fd-81f3-ee91287f9465}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{20ea9658-6bc3-4599-a87d-6371fe9295fc}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{a16ad1e9-f69a-45af-9462-b1c286708842}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{a7cddcdc-beeb-4685-a062-978f5e07ceee}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{c9ccbb35-d123-4a31-affc-9b2933132116}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{2f9ad413-2e0b-4a85-bb2a-cf961238262a}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{70880ce6-308c-4204-a89e-b266c3f7b7fa}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{8c788aa2-7530-43be-97b7-4d491f13bea3}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{14113b47-d59c-4f0f-9d10-ff1730265584}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{a9c42a57-421c-4572-8b12-249c59183d1c}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{a5b6fa30-d317-41ca-9cb1-c898d3c7f34e}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{cc19a5f2-b4ad-41d5-a5c9-0680904c1483}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{a3e67daa-da01-4da5-98be-3088b554a11e}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{d95c7240-0282-4c01-93f5-673bca03da86}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{62906e60-bce2-4e1b-9ed0-8b9042ee15e4}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{f9bfa98d-9935-4ea4-a05a-72c7f0778f02}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\CLSID\{69725738-cd68-4f36-8d02-8c43722ee5da}>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\coresrv.lfgax>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\coresrv.lfgax.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostie.bho>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostie.bho.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.hbax>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.hbax.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.hbinfoband>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.hbinfoband.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.iebutton>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.iebutton.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.iebuttona>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.iebuttona.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.rprtctrl>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\shoppingreport.rprtctrl.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\srv.coreservices>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\srv.coreservices.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbcoresrv.dynamicprop.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hotbarax.userprofiles>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hotbarax.userprofiles.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\cntntcntr.cntntdic>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\cntntcntr.cntntdic.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\cntntcntr.cntntdicp>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\cntntcntr.cntntdicp.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\coresrv.coreservices>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\coresrv.coreservices.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbmain.commband>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbmain.commband.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbr.hbmain>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hbr.hbmain.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostol.mailanim>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostol.mailanim.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostol.webmailsend>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\hostol.webmailsend.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\toolbar.htmlmenuui>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\toolbar.htmlmenuui.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\toolbar.toolbarctl>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\toolbar.toolbarctl.1>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\wallpaper.wallpapermanager>>"%Install-Path%\RegCR.dll"
echo HKEY_CLASSES_ROOT\wallpaper.wallpapermanager.1>>"%Install-Path%\RegCR.dll"
REM ......................
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{a7cddcdc-beeb-4685-a062-978f5e07ceee}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{100eb1fd-d03e-47fd-81f3-ee91287f9465}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b2}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{c5428486-50a0-4a02-9d20-520b59a9f9b3}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\Stats\{69725738-cd68-4f36-8d02-8c43722ee5da}>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\Software\Hotbar>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\Software\hotbarsa>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\fcn>>"%Install-Path%\RegCU.dll"
echo HKEY_CURRENT_USER\SOFTWARE\ShoppingReport>>"%Install-Path%\RegCU.dll"
REM ......................
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Explorer Bars\{2aa2fbf8-9c76-4e97-a226-25c5f4ab6358}>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b2}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Extensions\{c5428486-50a0-4a02-9d20-520b59a9f9b3}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{eddbb5ee-bb64-4bfc-9dbe-e7c85941335b}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{100eb1fd-d03e-47fd-81f3-ee91287f9465}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{a3e67daa-da01-4da5-98be-3088b554a11e}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{d95c7240-0282-4c01-93f5-673bca03da86}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{69725738-cd68-4f36-8d02-8c43722ee5da}>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\findbasic>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\shoppingreport>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\Findbasic>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SOFTWARE\ShoppingReport>>"%Install-Path%\RegLM.dll"
echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Findbasic Service>>"%Install-Path%\RegLM.dll"
REM ......................
echo "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b2}>"%Install-Path%\RegV.dll"
echo "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Extensions\CmdMapping" /v {c5428486-50a0-4a02-9d20-520b59a9f9b3}>>"%Install-Path%\RegV.dll"
echo "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\ShellBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegV.dll"
echo "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Toolbar\WebBrowser" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegV.dll"
echo "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v weatherdpa>>"%Install-Path%\RegV.dll"
echo "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Toolbar" /v {90b8b761-df2b-48ac-bbe0-bcc03a819b3b}>>"%Install-Path%\RegV.dll"
echo "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbaroe>>"%Install-Path%\RegV.dll"
echo "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v hotbarsa>>"%Install-Path%\RegV.dll"
REM ......................
echo a.exe>"%Install-Path%\InfctdFiles.dll"
echo b.exe>>"%Install-Path%\InfctdFiles.dll"
echo c.exe>>"%Install-Path%\InfctdFiles.dll"
echo cabal_online.exe>>"%Install-Path%\InfctdFiles.dll"
echo d.exe>>"%Install-Path%\InfctdFiles.dll"
echo e.exe>>"%Install-Path%\InfctdFiles.dll"
echo f.exe>>"%Install-Path%\InfctdFiles.dll"
echo findbasic.dll>>"%Install-Path%\InfctdFiles.dll"
echo findbasic.exe>>"%Install-Path%\InfctdFiles.dll"
echo findbasic145.exe>>"%Install-Path%\InfctdFiles.dll"
echo g.exe>>"%Install-Path%\InfctdFiles.dll"
echo h.exe>>"%Install-Path%\InfctdFiles.dll"
echo i.exe>>"%Install-Path%\InfctdFiles.dll"
echo j.exe>>"%Install-Path%\InfctdFiles.dll"
echo k.exe>>"%Install-Path%\InfctdFiles.dll"
echo l.exe>>"%Install-Path%\InfctdFiles.dll"
echo lst.exe>>"%Install-Path%\InfctdFiles.dll"
echo m.exe>>"%Install-Path%\InfctdFiles.dll"
echo msa.exe>>"%Install-Path%\InfctdFiles.dll"
echo msb.exe>>"%Install-Path%\InfctdFiles.dll"
echo n.exe>>"%Install-Path%\InfctdFiles.dll"
echo o.exe>>"%Install-Path%\InfctdFiles.dll"
echo p.exe>>"%Install-Path%\InfctdFiles.dll"
echo q.exe>>"%Install-Path%\InfctdFiles.dll"
echo r.exe>>"%Install-Path%\InfctdFiles.dll"
echo s.exe>>"%Install-Path%\InfctdFiles.dll"
echo setub.exe>>"%Install-Path%\InfctdFiles.dll"
echo skip 2.exe>>"%Install-Path%\InfctdFiles.dll"
echo software cool.exe>>"%Install-Path%\InfctdFiles.dll"
echo t.exe>>"%Install-Path%\InfctdFiles.dll"
echo u.exe>>"%Install-Path%\InfctdFiles.dll"
echo v.exe>>"%Install-Path%\InfctdFiles.dll"
echo vchost.exe>>"%Install-Path%\InfctdFiles.dll"
echo vturs.exe>>"%Install-Path%\InfctdFiles.dll"
echo w.exe>>"%Install-Path%\InfctdFiles.dll"
echo warn chin ball.exe>>"%Install-Path%\InfctdFiles.dll"
echo x.exe>>"%Install-Path%\InfctdFiles.dll"
echo y.exe>>"%Install-Path%\InfctdFiles.dll"
echo z.exe>>"%Install-Path%\InfctdFiles.dll"
REM ......................
echo %appdata%\beep axis mode free>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\comp two long internet>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\findbasic>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\Hotbar>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\ShoppingReport>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\Shopping Report>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\Softru~1>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\WeatherDPA>>"%Install-Path%\InfctdFolders.dll"
echo %appdata%\Weather DPA>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\findbasic>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\Hotbar>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\ShoppingReport>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\Shopping Report>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\WeatherDPA>>"%Install-Path%\InfctdFolders.dll"
echo %ProgramFiles%\Weather DPA>>"%Install-Path%\InfctdFolders.dll"
REM ......................
echo @echo off>"%Install-Path%\G-Dawtech.bat"
echo REM (C) Copyright S1r1us13 / GrellesLicht28>>"%Install-Path%\G-Dawtech.bat"
echo REM This is a creation of Makroware.>>"%Install-Path%\G-Dawtech.bat"
echo title G-Dawtech>>"%Install-Path%\G-Dawtech.bat"
echo color 0E>>"%Install-Path%\G-Dawtech.bat"
echo :Start>>"%Install-Path%\G-Dawtech.bat"
echo cls>>"%Install-Path%\G-Dawtech.bat"
echo echo                         ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>>"%Install-Path%\G-Dawtech.bat"
echo echo                         Û                              Û>>"%Install-Path%\G-Dawtech.bat"
echo echo                         Û G-DAWTECH ANTI-VIRUS SCANNER Û>>"%Install-Path%\G-Dawtech.bat"
echo echo                         Û                              Û>>"%Install-Path%\G-Dawtech.bat"
echo echo                         ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>>"%Install-Path%\G-Dawtech.bat"
echo echo.>>"%Install-Path%\G-Dawtech.bat"
echo echo Enter here the scanner's priority:>>"%Install-Path%\G-Dawtech.bat"
echo echo H = High                         Scanner runs faster than other programs.>>"%Install-Path%\G-Dawtech.bat"
echo echo N = Normal                       Scanner runs as fast as other programs.>>"%Install-Path%\G-Dawtech.bat"
echo echo L = Low                          Scanner runs slower than other programs.>>"%Install-Path%\G-Dawtech.bat"
echo echo.>>"%Install-Path%\G-Dawtech.bat"
echo set /P Priority=>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "H" start /high GDscan.bat /high^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "High" start /high GDscan.bat /high^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "N" start /normal GDscan.bat /normal^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "Normal" start /normal GDscan.bat /normal^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "L" start /low GDscan.bat /low^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo if /I "%%Priority%%" == "Low" start /low GDscan.bat /low^&^&exit>>"%Install-Path%\G-Dawtech.bat"
echo echo Given priority could not be recognized.>>"%Install-Path%\G-Dawtech.bat"
echo pause>>"%Install-Path%\G-Dawtech.bat"
echo goto :Start>>"%Install-Path%\G-Dawtech.bat"
REM ......................
REM HAUPTSCANNER
REM ......................
echo @echo off>"%Install-Path%\GDscan.bat"
echo REM (C) Copyright S1r1us13 / GrellesLicht28>>"%Install-Path%\GDscan.bat"
echo REM This is a creation of Makroware.>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech>>"%Install-Path%\GDscan.bat"
echo color 0E>>"%Install-Path%\GDscan.bat"
echo SETLOCAL ENABLEDELAYEDEXPANSION>>"%Install-Path%\GDscan.bat"
echo if not exist "%%cd%%\Logs" MD "%%cd%%\Logs">>"%Install-Path%\GDscan.bat"
echo set Log="%%cd%%\Logs\G-Dawtech Virusscan-Report_%%date%%_%%time%%.log">>"%Install-Path%\GDscan.bat"
echo set "Viruses=0" >>"%Install-Path%\GDscan.bat"
echo set "Suspicious=0" >>"%Install-Path%\GDscan.bat"
echo set "Notices=0" >>"%Install-Path%\GDscan.bat"
echo set "File-Amount=0" >>"%Install-Path%\GDscan.bat"
echo :Antivirus-Start>>"%Install-Path%\GDscan.bat"
echo mode con lines=50 >>"%Install-Path%\GDscan.bat"
echo title G-Dawtech>>"%Install-Path%\GDscan.bat"
echo set Menu=>>"%Install-Path%\GDscan.bat"
echo set Scan=>>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo type Logo.bmp>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo ------------------->>"%Install-Path%\GDscan.bat"
echo set /p Menu=Option: >>"%Install-Path%\GDscan.bat"
echo echo ------------------->>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "0" goto :End>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "1" goto :Registryscan>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "2" goto :Systemscan>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "3" goto :Quick-Systemscan>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "4" set Scan=full^&goto :Registryscan>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "5" goto :OwnScan>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "6" goto :Results>>"%Install-Path%\GDscan.bat"
echo if "%%Menu%%" == "7" goto :Remove>>"%Install-Path%\GDscan.bat"
echo echo The option "%%Menu%%" is no valid command.>>"%Install-Path%\GDscan.bat"
echo pause>>"%Install-Path%\GDscan.bat"
echo goto :Antivirus-Start>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
echo :Registryscan>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Starting registryscan...>>"%Install-Path%\GDscan.bat"
echo mode con lines=6 >>"%Install-Path%\GDscan.bat"
echo echo Starting Registrscan...>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo FOR /F "usebackq delims=" %%%%A IN (`reg query "HKCR" /S`) DO (>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Registryscan is running.>>"%Install-Path%\GDscan.bat"
echo set HKCR=%%%%A>>"%Install-Path%\GDscan.bat"
echo if /I "!HKCR:~0,4!" == "HKEY" (>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (RegCR.dll) DO if /I "%%%%A" == "%%%%a" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning registry...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo ))>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo set /a "File-Amount=!File-Amount!">>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Preparing Hkey_Current_User...>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo FOR /F "usebackq delims=" %%%%A IN (`reg query "HKCU" /S`) DO (>>"%Install-Path%\GDscan.bat"
echo set HKCU=%%%%A>>"%Install-Path%\GDscan.bat"
echo if /I "!HKCU:~0,4!" == "HKEY" (>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (RegCU.dll) DO if /I "%%%%A" == "%%%%a" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning registry...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo ))>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo set /a "File-Amount=!File-Amount!">>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Preparing Hkey_Local_Machine...>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo FOR /F "usebackq delims=" %%%%A IN (`reg query "HKLM" /S`) DO (>>"%Install-Path%\GDscan.bat"
echo set HKLM=%%%%A>>"%Install-Path%\GDscan.bat"
echo if /I "!HKLM:~0,4!" == "HKEY" (>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (RegLM.dll) DO if /I "%%%%A" == "%%%%a" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set "/a File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning registry...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo ))>>"%Install-Path%\GDscan.bat"
REM ----------------------------------
echo set /a "File-Amount=!File-Amount!">>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (RegV.dll) DO (>>"%Install-Path%\GDscan.bat"
echo reg query %%%%a ^>nul 2^>^&1 >>"%Install-Path%\GDscan.bat"
echo if not errorlevel 1 (echo [VIRUS]^>^>%%Log%%^&echo %%%%a^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat")>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
echo if "%%Scan%%" == "Full" goto :Systemscan>>"%Install-Path%\GDscan.bat"
echo goto :Results>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"


REM ----------------------------------


echo :Systemscan>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Starting systemscan...>>"%Install-Path%\GDscan.bat"
echo mode con lines=6 >>"%Install-Path%\GDscan.bat"
echo echo Starting Systemscan...>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%A IN (`dir /A /B /S "%%homedrive%%\"`) DO (>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Systemscan is running.>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (InfctdFiles.dll) DO if /I "%%%%~nxA" == "%%%%a" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set "/a File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning files...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%A IN (InfctdFolders.dll) DO (>>"%Install-Path%\GDscan.bat"
echo if exist "%%%%A" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo [NOTICE] The whole folder is infected.^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo goto :Results>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"

IF "%Install-Type%" == "1" (
echo :Quick-Systemscan>>"%Install-Path%\GDscan.bat"
echo set "Viruses=0">>"%Install-Path%\GDscan.bat"
echo set "Suspicious=0">>"%Install-Path%\GDscan.bat"
echo set "Notices=0">>"%Install-Path%\GDscan.bat"
echo set "File-Amount=0">>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Starting quick systemscan...>>"%Install-Path%\GDscan.bat"
echo mode con lines=6 >>"%Install-Path%\GDscan.bat"
echo echo Starting quick systemscan...>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%A IN (QFls.dll) DO (>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - Quick systemscan is running.>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (InfctdFiles.dll) DO if /I "%%%%~nxA" == "%%%%a" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set "/a File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning files...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%A IN (InfctdFolders.dll) DO (>>"%Install-Path%\GDscan.bat"
echo if exist "%%%%A" (echo [VIRUS]^>^>%%Log%%^&echo %%%%A^>^>%%Log%%^&echo [NOTICE] The whole folder is infected.^>^>%%Log%%^&echo.^>^>%%Log%%)>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo goto :Results>>"%Install-Path%\GDscan.bat"
echo.>>"%Install-Path%\GDscan.bat"
)

echo :Results>>"%Install-Path%\GDscan.bat"
echo if not exist %%Log%% echo.^>%%Log%%>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Totally scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo type %%Log%%>>"%Install-Path%\GDscan.bat"
echo echo.^>^>%%Log%%>>"%Install-Path%\GDscan.bat"
echo echo.^>^>%%Log%%>>"%Install-Path%\GDscan.bat"
echo if not defined Logfile FOR /F "usebackq delims=" %%%%A IN ("%%Log%%") DO set Logfile=%%%%~sA>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq tokens=1" %%%%A IN (%%Logfile%%) DO (>>"%Install-Path%\GDscan.bat"
echo if "%%%%A" == "[VIRUS]" set /a "Viruses=!Viruses! +1" >>"%Install-Path%\GDscan.bat"
echo if "%%%%A" == "[WARNING]" set /a "Suspicious=!Suspicious! +1" >>"%Install-Path%\GDscan.bat"
echo if "%%%%A" == "[NOTICE]" set /a "Notices=!Notices! +1" >>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo echo Viruses found...: !Viruses!>>"%Install-Path%\GDscan.bat"
echo echo Suspicious files: !Suspicious!>>"%Install-Path%\GDscan.bat"
echo echo Notices.........: !Notices!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo set /p End=Press enter to go back to main menu.>>"%Install-Path%\GDscan.bat"
echo goto :Antivirus-Start>>"%Install-Path%\GDscan.bat"

echo :OwnScan>>"%Install-Path%\GDscan.bat"
echo set "Viruses=0">>"%Install-Path%\GDscan.bat"
echo set "Suspicious=0">>"%Install-Path%\GDscan.bat"
echo set "Notices=0">>"%Install-Path%\GDscan.bat"
echo set "File-Amount=0">>"%Install-Path%\GDscan.bat"
echo set OwnScan=>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Please enter a file or a folder you would like to scan.>>"%Install-Path%\GDscan.bat"
echo set /P OwnScan=>>"%Install-Path%\GDscan.bat"
echo if not defined OwnScan goto :Antivirus-Start>>"%Install-Path%\GDscan.bat"
echo title G-Dawtech - User prompt scan.>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%A IN (`dir /A /B /S "%%OwnScan%%"`) DO (>>"%Install-Path%\GDscan.bat"
echo FOR /F "usebackq delims=" %%%%a IN (InfctdFiles.dll InfctdFolders.dll) DO if /I "%%%%A" == "%%%%a" echo [VIRUS]^&echo %%%%A^&echo.>>"%Install-Path%\GDscan.bat"
echo set /a "File-Amount=!File-Amount! +1" >>"%Install-Path%\GDscan.bat"
echo cls>>"%Install-Path%\GDscan.bat"
echo echo Scanning files...>>"%Install-Path%\GDscan.bat"
echo echo Scanned objects: !File-Amount!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Current object: %%%%A>>"%Install-Path%\GDscan.bat"
echo )>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo echo Viruses found...: !Viruses!>>"%Install-Path%\GDscan.bat"
echo echo Suspicious files: !Suspicious!>>"%Install-Path%\GDscan.bat"
echo echo Notices.........: !Notices!>>"%Install-Path%\GDscan.bat"
echo echo.>>"%Install-Path%\GDscan.bat"
echo set /P End=Press enter to go back to main menu.>>"%Install-Path%\GDscan.bat"
echo goto :Antivirus-Start>>"%Install-Path%\GDscan.bat"

echo :Remove>>"%Install-Path%\GDscan.bat"
echo call Rmv.bat %%Log%%>>"%Install-Path%\GDscan.bat"
echo goto :Antivirus-Start>>"%Install-Path%\GDscan.bat"
echo @echo off>"%Install-Path%\Rmv.bat"
echo echo Do you want to delete every virus given in "%%1">>"%Install-Path%\Rmv.bat"
echo echo irreversibly? Files from Windows which are recognized as infected may damage>>"%Install-Path%\Rmv.bat"
echo echo Windows. (Y / N)>>"%Install-Path%\Rmv.bat"
echo set /P Choice1=>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "y" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "ye" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "ya" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "yes" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "yeah" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "j" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "jo" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "ja" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "joa" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "o" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "oui" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "ouais" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "si" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "sí" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "sì" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "tak" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo if /I "%%Choice1%%" == "evet" goto :Rmv1>>"%Install-Path%\Rmv.bat"
echo echo If you want to enter a specific file or folder, enter it here:>>"%Install-Path%\Rmv.bat"
echo set /p Choice2=>>"%Install-Path%\Rmv.bat"
echo if not defined Choice2 exit /B>>"%Install-Path%\Rmv.bat"
echo FOR /F "usebackq delims=" %%%%A IN (`dir /A /B /S "%%Choice2%%"`) DO (>>"%Install-Path%\Rmv.bat"
echo set Filepath=%%%%A>>"%Install-Path%\Rmv.bat"
echo sc stop "%%%%~nA" ^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo sc delete "%%%%~nA" ^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo taskkill /F /T /IM %%%%~nxA^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo del /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AS /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AH /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AHS /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo echo The file "%%%%A" cannot be removed while running Windows. It will be deleted on>>"%Install-Path%\Rmv.bat"
echo echo reboot.>>"%Install-Path%\Rmv.bat"
echo echo del /F /Q /S "%%%%A"^>^>"C:\AUTOEXEC.BAT">>"%Install-Path%\Rmv.bat"
echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /t REG_SZ /d "%Install-Path%\Rmvd.bat" /F>>"%Install-Path%\Rmv.bat"
echo set "Reboot=1">>"%Install-Path%\Rmv.bat"
echo )))))>>"%Install-Path%\Rmv.bat"
echo if "%%Reboot1%%" == "1" (>>"%Install-Path%\Rmv.bat"
echo Would you like to reboot now? (Y / N)>>"%Install-Path%\Rmv.bat"
echo set /p Reboot=>>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "y" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ye" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ya" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "yes" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "yeah" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "j" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "jo" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ja" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "joa" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "o" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "oui" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ouais" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "si" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "sí" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "sì" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "tak" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "evet" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo )>>"%Install-Path%\Rmv.bat"
echo pause>>"%Install-Path%\Rmv.bat"
echo EXIT>>"%Install-Path%\Rmv.bat"
echo :Rmv1>>"%Install-Path%\Rmv.bat"
echo if not exist %%1 (>>"%Install-Path%\Rmv.bat"
echo echo There are no viruses protocolled in the current logfile.>>"%Install-Path%\Rmv.bat"
echo pause>>"%Install-Path%\Rmv.bat"
echo EXIT>>"%Install-Path%\Rmv.bat"
echo )>>"%Install-Path%\Rmv.bat"
echo SETLOCAL ENABLEDELAYEDEXPANSION>>"%Install-Path%\Rmv.bat"
echo FOR /F "usebackq delims=" %%%%A IN ("%%1") DO set ShortFilePath=%%%%~sA>>"%Install-Path%\Rmv.bat"
echo FOR /F "usebackq delims=" %%%%A IN (%%ShortFilePath%%) DO (>>"%Install-Path%\Rmv.bat"
echo set Filepath=%%%%A>>"%Install-Path%\Rmv.bat"
echo if "!Filepath:~1,2!" == ":\" (>>"%Install-Path%\Rmv.bat"
echo sc stop "%%%%~nA" ^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo sc delete "%%%%~nA" ^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo taskkill /F /T /IM %%%%~nxA^>nul 2^>^&1 >>"%Install-Path%\Rmv.bat"
echo del /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AS /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AH /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo del /AHS /F /Q /S "%%%%A"2^>^&1 >>"%Install-Path%\Rmv.bat"
echo if errorlevel 0 (echo The file "%%%%A" was successfully deleted.>>"%Install-Path%\Rmv.bat") ELSE (>>"%Install-Path%\Rmv.bat"
echo echo The file "%%%%A" cannot be removed while running Windows. It will be deleted on>>"%Install-Path%\Rmv.bat"
echo echo reboot.>>"%Install-Path%\Rmv.bat"
echo echo del /F /Q /S "%%%%A"^>^>"C:\AUTOEXEC.BAT">>"%Install-Path%\Rmv.bat"
echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /t REG_SZ /d "%Install-Path%\Rmvd.bat" /F>>"%Install-Path%\Rmv.bat"
echo set "Reboot=1">>"%Install-Path%\Rmv.bat"
echo ))))))>>"%Install-Path%\Rmv.bat"
echo if "%%Reboot1%%" == "1" (>>"%Install-Path%\Rmv.bat"
echo Would you like to reboot now? (Y / N)>>"%Install-Path%\Rmv.bat"
echo set /p Reboot=>>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "y" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ye" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ya" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "yes" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "yeah" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "j" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "jo" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ja" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "joa" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "o" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "oui" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "ouais" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "si" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "sí" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "sì" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "tak" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo if /I "%%Reboot%%" == "evet" shutdown -r -t 20 -c "The viruses will be deleted after reboot.">>"%Install-Path%\Rmv.bat"
echo )>>"%Install-Path%\Rmv.bat"
echo pause>>"%Install-Path%\Rmv.bat"
echo EXIT>>"%Install-Path%\Rmv.bat"

echo @echo off>"%Install-Path%\Rmvd.bat"
echo echo.^>"C:\AUTOEXEC.BAT">>"%Install-Path%\Rmvd.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /F>>"%Install-Path%\Rmvd.bat"
echo cls>>"%Install-Path%\Rmvd.bat"
echo echo                         ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>>"%Install-Path%\Rmvd.bat"
echo echo                         Û                              Û>>"%Install-Path%\Rmvd.bat"
echo echo                         Û G-DAWTECH ANTI-VIRUS SCANNER Û>>"%Install-Path%\Rmvd.bat"
echo echo                         Û                              Û>>"%Install-Path%\Rmvd.bat"
echo echo                         ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>>"%Install-Path%\Rmvd.bat"
echo echo.>>"%Install-Path%\Rmvd.bat"
echo echo Every virus should now be gone.>>"%Install-Path%\Rmvd.bat"
echo echo ------------------------------->>"%Install-Path%\Rmvd.bat"
echo ping localhost -n 6 >nul>>"%Install-Path%\Rmvd.bat"
echo exit>>"%Install-Path%\Rmvd.bat"

echo :End>>"%Install-Path%\GDscan.bat"
echo call egd.bat>>"%Install-Path%\GDscan.bat"
echo EXIT>>"%Install-Path%\GDscan.bat"

echo @echo off>"%Install-Path%\egd.bat"
echo title G-Dawtech is shutting down.>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û        ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²       ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û      ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²     ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²Û    ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²Û²   ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²Û²Û  ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²Û²Û² ]>>"%Install-Path%\egd.bat"
echo ping localhost -n 2 ^>nul>>"%Install-Path%\egd.bat"
echo cls>>"%Install-Path%\egd.bat"
echo echo Thank you for using G-Dawtech.>>"%Install-Path%\egd.bat"
echo echo.>>"%Install-Path%\egd.bat"
echo echo     [Û²Û²Û²Û²Û]>>"%Install-Path%\egd.bat"
echo ping localhost -n 1 ^>nul>>"%Install-Path%\egd.bat"
echo EXIT>>"%Install-Path%\egd.bat"


echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>"%Install-Path%\Logo.bmp"
echo  Û                                                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û                        G-DAWTECH ANTI-VIRUS SCANNER                        Û>>"%Install-Path%\Logo.bmp"
echo  Û                                                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Û>>"%Install-Path%\Logo.bmp"
echo  Û                                                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û Choose the option you would like to do:                         Durations: Û>>"%Install-Path%\Logo.bmp"
echo  Û                                                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û 0: End G-Dawtech                                                           Û>>"%Install-Path%\Logo.bmp"
echo  Û 1: Registryscan               -                 Start 5min, Progress 10min Û>>"%Install-Path%\Logo.bmp"
echo  Û 2: Systemscan                 -                 Start 2min, Progress 20min Û>>"%Install-Path%\Logo.bmp"
echo  Û 3: Quick systemscan           -                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û 4: Full scan                                                               Û>>"%Install-Path%\Logo.bmp"
echo  Û 5: Choose specific file / folder                                           Û>>"%Install-Path%\Logo.bmp"
echo  Û 6: Results                                                                 Û>>"%Install-Path%\Logo.bmp"
echo  Û 7: Removaltools                                                            Û>>"%Install-Path%\Logo.bmp"
echo  Û                                                                            Û>>"%Install-Path%\Logo.bmp"
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ>>"%Install-Path%\Logo.bmp"

echo @echo off>"%Install-Path%\uninst.bat"
echo title G-Dawtech uninstall>>"%Install-Path%\uninst.bat"
echo color 0E>>"%Install-Path%\uninst.bat"
echo echo Do you really want to uninstall G-Dawtech and all its components?>>"%Install-Path%\uninst.bat"
echo set /P Choice=>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "y" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "ye" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "ya" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "yes" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "yeah" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "j" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "jo" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "ja" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "joa" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "o" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "oui" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "ouais" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "si" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "sí" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "sì" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "tak" goto :Delete>>"%Install-Path%\uninst.bat"
echo if /I "%%Choice%%" == "evet" goto :Delete>>"%Install-Path%\uninst.bat"
echo echo Thank you for still using G-Dawtech.>>"%Install-Path%\uninst.bat"
echo pause>>"%Install-Path%\uninst.bat"
echo EXIT>>"%Install-Path%\uninst.bat"
echo :Delete>>"%Install-Path%\uninst.bat"
echo echo Press any key to start uninstalling...>>"%Install-Path%\uninst.bat"
echo pause ^>nul>>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\egd.bat">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\G-Dawtech.bat">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\GDscan.bat">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\Logo.bmp">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\Rmv.bat">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\Rmvd.bat">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\InfctdFiles.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\InfctdFolders.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\RegV.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\RegCR.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\RegCU.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\RegLM.dll">>"%Install-Path%\uninst.bat"
echo if exist "%Install-Path%\QFls.dll" del /F "%Install-Path%\QFls.dll">>"%Install-Path%\uninst.bat"
echo del /F "%Install-Path%\uninst.bat">>"%Install-Path%\uninst.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v G-Dawtech /F>>"%Install-Path%\uninst.bat"
echo echo.>>"%Install-Path%\uninst.bat"
echo echo G-Dawtech was successfully removed from your PC!>>"%Install-Path%\uninst.bat"
echo pause ^>nul>>"%Install-Path%\uninst.bat"
echo EXIT>>"%Install-Path%\uninst.bat"

if "%Install-Type%" == "1" (
dir /A /B /S "%homedrive%\">"%Install-Path%\QFls.dll"
)

pushd %Install-Path%
echo Installation complete. Would you like to run it now? (Y / N^)
set /P Run=
if /I "%Run%" == "y" start G-Dawtech.bat
if /I "%Run%" == "ye" start G-Dawtech.bat
if /I "%Run%" == "ya" start G-Dawtech.bat
if /I "%Run%" == "yes" start G-Dawtech.bat
if /I "%Run%" == "yeah" start G-Dawtech.bat
if /I "%Run%" == "j" start G-Dawtech.bat
if /I "%Run%" == "jo" start G-Dawtech.bat
if /I "%Run%" == "ja" start G-Dawtech.bat
if /I "%Run%" == "joa" start G-Dawtech.bat
if /I "%Run%" == "o" start G-Dawtech.bat
if /I "%Run%" == "oui" start G-Dawtech.bat
if /I "%Run%" == "ouais" start G-Dawtech.bat
if /I "%Run%" == "si" start G-Dawtech.bat
if /I "%Run%" == "sí" start G-Dawtech.bat
if /I "%Run%" == "sì" start G-Dawtech.bat
if /I "%Run%" == "tak" start G-Dawtech.bat
if /I "%Run%" == "evet" start G-Dawtech.bat
exit

REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************