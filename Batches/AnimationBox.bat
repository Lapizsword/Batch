@echo off
setlocal enabledelayedexpansion
set Counter=0
set Schalter=2
set Width=0


:: The weird symbols are replaced by lines in the CMD-window
:: All options that are marked by a little point are finite
:: --- All the others are unfinite, the program has to be closed by X to
::     view another animation
::     --- "c4: Star Wars" is not infinite, but it takes quite a lot time

:Start
call :ResetVariables
title Animation Box
mode con cols=80 lines=25
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo ºú1: Installation  ³ú 9: Arrow left      ºúc1: 1min          º
echo º 2: Slow loading  ³ú10: Arrow right     ºúc2: 2009          º
echo º 3: Fast loading  ³ 11: Skull           º c3: Bat disco     º
echo º 4: Big loading   ³ú12: Dos Techno Virusº c4: Star Wars     º
echo ÌÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÎÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¹
echo º 5: Matrix        ³ú13: Winhound        ºúm1: Matrix part 1 º
echo º 6: Epilepsy      ³ú14: Expand window   ºúm2: Matrix part 2 º
echo ºú7: Naked woman   ³                     ºúm3: Matrix part 3 º
echo º 8: Fill window   ³                     ºúm4: Matrix part 4 º
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /p choice=--^>  
cls
if "%choice%" == "5" set Schalter=
call :%choice%
goto :Start






:: "Counter" is the amount of finished %, yet (at last 100%)
:: "Display" is the progress bar
:: --- This bar consists of the half of the %-amount (at last 50)
:: --- The bar moves from left to right

:1
title Animation Box - Installation
set /a Counter=%Counter% + 1
set /a Display=%Counter% / 2
FOR /L %%A IN (1,1,%Display%) DO (
	set Display=!Display!²
)
cls
echo            New files are copied...                  %Counter%%%
echo     ²!Display:~2,47!
ping localhost -n 1 >nul
if "%Counter%" == "100" goto :1-End
goto :1
:1-End
echo.
echo Installation complete.
pause >nul
EXIT /B




:2
cls
title Animation Box - Slow loading
echo Opening file.
echo.
echo I             I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I²            I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I ²           I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I² ²          I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I ² ²         I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I² ² ²        I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I ² ² ²       I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I  ² ² ²      I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I   ² ² ²     I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I    ² ² ²    I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I     ² ² ²   I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I      ² ² ²  I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I       ² ² ² I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I        ² ² ²I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I         ² ² I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I          ² ²I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I           ² I
ping localhost -n 1 >nul
cls
echo Opening file.
echo.
echo I            ²I
ping localhost -n 1 >nul
cls
goto :2



:: "Counter" determines the length of the row
:: "Display" is the row
:: "Schalter 1" = From left to right
:: "Schalter 2" = From right to left

:3
title Animation Box - Fast loading
cls
echo [!Display!]
set Display=
if "%Counter%" == "0" set Schalter=1
if "!Schalter!" == "1" set /a Counter=%Counter% + 1
if "%Counter%" == "41" set Schalter=2
if "!Schalter!" == "2" set /a Counter=%Counter% - 1
if "!Schalter!" == "1" FOR /L %%A IN (1,1,%Counter%) DO set Display=!Display!±
if "!Schalter!" == "1" FOR /L %%A IN (%Counter%,1,40) DO set Display=!Display! 
if "!Schalter!" == "2" FOR /L %%A IN (1,1,%Counter%) DO set Display=!Display! 
if "!Schalter!" == "2" FOR /L %%A IN (%Counter%,1,40) DO set Display=!Display!±
goto :3









:: The subpoint "4_DisplaySpace" is used to compress the animation's size in the file.
:: The FOR-part in the middle of the animation is used for the same reason.
:: --- It counts the amount of spaces between the left stars and the loadbar, and
::     between the right stars and the loadbar.
::     --- There are at last 65 spaces.
::         --- The entire animation counts 79 columns. The loadbar is 11 columns wide.
::             From the left 68 columns, 2 are the stars at the left and the right.
::             66 columns left, 65 of them spaces (79 - 11 - 2 = 66)

:: The variable "line" is used to compress the animation's size in the file, too.

:4
title Animation Box - Big loading
mode con lines=15
goto :4_DisplayBars

:4_DisplaySpace
echo *******************************************************************************
ping localhost -n 1 >nul
cls 
echo.
echo.
echo.
echo.
echo *******************************************************************************
exit /b

:4_DisplayBars
call :4_DisplaySpace
echo *                                                                             *
echo *                                                                             *
echo *                                                                             *
call :4_DisplaySpace
echo *8                                                                            *
echo *8                                                                            *
echo *8                                                                            *
call :4_DisplaySpace
echo *88                                                                           *
echo *88                                                                           *
echo *88                                                                           *
call :4_DisplaySpace
echo *888                                                                          *
echo *888                                                                          *
echo *888                                                                          *
call :4_DisplaySpace
echo * 888                                                                         *
echo * 888                                                                         *
echo * 888                                                                         *
call :4_DisplaySpace
echo *8 888                                                                        *
echo *8 888                                                                        *
echo *8 888                                                                        *
call :4_DisplaySpace
echo *88 888                                                                       *
echo *88 888                                                                       *
echo *88 888                                                                       *
call :4_DisplaySpace
echo *888 888                                                                      *
echo *888 888                                                                      *
echo *888 888                                                                      *
call :4_DisplaySpace
echo * 888 888                                                                     *
echo * 888 888                                                                     *
echo * 888 888                                                                     *
call :4_DisplaySpace
echo *8 888 888                                                                    *
echo *8 888 888                                                                    *
echo *8 888 888                                                                    *
call :4_DisplaySpace
echo *88 888 888                                                                   *
echo *88 888 888                                                                   *
echo *88 888 888                                                                   *
call :4_DisplaySpace
FOR /L %%A IN (0,1,66) DO (
	set Length=
	set Width=
	FOR /L %%D IN (1,1,%%A) DO set Length=!Length! 
	FOR /L %%E IN (%%A,1,65) DO set Width=!Width! 
	set Line=*!Length!888 888 888!Width!*
	FOR /L %%R IN (1,1,3) DO echo !Line!
	call :4_DisplaySpace
)
echo *                                                                   888 888 88*
echo *                                                                   888 888 88*
echo *                                                                   888 888 88*
call :4_DisplaySpace
echo *                                                                    888 888 8*
echo *                                                                    888 888 8*
echo *                                                                    888 888 8*
call :4_DisplaySpace
echo *                                                                     888 888 *
echo *                                                                     888 888 *
echo *                                                                     888 888 *
call :4_DisplaySpace
echo *                                                                      888 888*
echo *                                                                      888 888*
echo *                                                                      888 888*
call :4_DisplaySpace
echo *                                                                       888 88*
echo *                                                                       888 88*
echo *                                                                       888 88*
call :4_DisplaySpace
echo *                                                                        888 8*
echo *                                                                        888 8*
echo *                                                                        888 8*
call :4_DisplaySpace
echo *                                                                         888 *
echo *                                                                         888 *
echo *                                                                         888 *
call :4_DisplaySpace
echo *                                                                          888*
echo *                                                                          888*
echo *                                                                          888*
call :4_DisplaySpace
echo *                                                                           88*
echo *                                                                           88*
echo *                                                                           88*
call :4_DisplaySpace
echo *                                                                            8*
echo *                                                                            8*
echo *                                                                            8*
goto :4_DisplayBars










:: Matrix effect coming from below
:: 
:: If "Schalter" equals a space (" "), then the figures are moved one space to the right
:: If "Schalter" equals nothing (""), then the figures aren't moved.
:: 
:: %%A equals the last line, yet (the one at the top)
:: %%B equals the new line (%%A moved one line towards the top)
:: --- %%B equals the last %%A
:: 
:: In the last FOR-command, all lines are displayed. In case if the screen isn't filled, yet,
:: the program will put a blank (echo.)

:5
title Animation Box - Matrix
color 0a
ping localhost -n 1 >nul
cls
if "%Schalter%" == "" (set Schalter= ) ELSE (set Schalter=)
FOR /L %%A IN (1,1,23) DO (
	set /a B=%%A + 1
	FOR %%B IN (!B!) DO set Line%%A=!Line%%B!
)
set Line24=%Schalter%%random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1% %random:~0,1%
FOR /L %%A IN (1,1,24) DO if defined Line%%A (echo !Line%%A!) ELSE (echo.)
goto :5






:: Flickering CMD-window in "white-black" "black-white" (background-font)

:6
title Animation Box - Epilepsy
ping localhost -n 1 >nul
cls
if "%color%" == "0f" (set color=f0) ELSE (set color=0f)
color %color%
FOR /L %%A IN (1,1,9) DO echo.
echo    88888888  88                        88                     88  88
echo       88     88                        88                     88  88
echo       88                             888888                   88    
echo       88     88  88888888  888888      88      888888     888888  88  888888
echo       88     88  88 88 88  88__88      88      88  88     88  88  88  88__88
echo       88     88  88 88 88  88____      888888  888888     888888  88  88____
FOR /L %%A IN (1,1,8) DO echo.
goto :6









:7
title Animation Box - Naked woman
color 05
mode con lines=180
echo                                     .,,,,,.. 
echo                          _.zJ??c,J$hhhhh:::::??c, 
echo                        ,J?:::::J99?????h::?h:::::?h 
echo                      z”::::::$9999??h::::??h:?h:::?$. 
echo                     J:::J$?::6;hh:::::??i:::?h::$::::$ 
echo                    J::9F::hhh6T??h:??h:::?$:::?h::$:::$ 
echo                   J::9?h?:::$:?$C:??h:??h:::9h::?h:?$::$ 
echo                  ;F:JF9?:J?:$h::?h:::?h::?h::?h::?$::h::h 
echo                  $::C:CjF:j?$9h::?h:::?h:::9h::?h::$::9:9? 
echo                  $:$:$9?:C9?$:$:::?h::::$:::?h:::$::$::$:$. 
echo                  CJ?9:C:$:$:9::$:::?h::::?h:::$:::$::9::$:$ 
echo                  $$:$J:9:9J$:$::$:::?h::::?h:::?h::$::$:?h:, 
echo                   C:F$:9:$$’”?$::$:::?h::::?h:::?h::$::h:?:9 
echo                  :9:C::C?$’.`.$::h:::?h::::9::::$::9::?h::: 
echo                  J:$:C::$:$’.`.`”"”?:::?h::::$::::$::$::$:::$ 
echo                  $:9:C:::$’`.`.`.`.“hjj?h::::$:::?h::h::::$ 
echo                  $:9::::hc?Jccc`.`.`.`z$??h:::h:::$::9::9::9 
echo                  ?:9:9:::i’,cccJ”`.`.`J’Plcc$h::::::$:?C:::9 
echo                   $:C:$:9'J$?$$$FP’.`jF3F`$$$ 3?h::::?:h::$:J 
echo                   :$::$”‘”?c?$CJ`.`.$’.`?+??”`.`h::::$::X::: 
echo                    h?C:9`.`.`.`.`.`.`$’.`.`.`.`.“h:::9h:C::: 
echo                    `h$:9`.`.`.`.`.`.`??`.`.`.`.`.`?h:::C:C:J 
echo                     `hh?h.`.`.`.`.`.`.`L’`.`.`.`.`.3::hC:F:F 
echo                      3:$$,`.`.`.`.`.`;3`.`.`.`.`.:C:9:9:$ 
echo                       ?h:?c`.`.`.`”"??”`.`.`.`.`.`.3::$:$:F 
echo                         ??h`.`.`.`.`.`.`.`.`.`.`.`.$??:$:P 
echo                           ?,.`.`.cJ?????QI$?.`.`.`.$::$:$ 
echo                            $,`.`.3?hc,c??$’`.`.`.`$:::P 
echo                            $9,.`.`?hCCCJ”`.`.`.`.z?9:J” 
echo                            ?h?h`.`.`.`.`.`.`.`.,$;;;, 
echo                              ”"?,`.`.`.`.`.`.,$?;;;;9. 
echo                                 ?i.`.`.`.`.,J?;;;;;;;?c_ 
echo                                  $h,.`.`,cc?;;;;;;;;;;;;?c, 
echo                                  $;;???;;;;;;;;;;;;;;;;;;;;?hc, 
echo                                  3;;;;;;’`.`.`.`.`.`;;;;;;;;;;;???hhhccc,,_ 
echo                                  ;;;;’`.`.`.`.`.`.`;;;;;;;;;;;’.`.`.`.`.`”?h . 
echo                                  ;;;’.`.`.`.`.`.`;;;;;’.`.`.`.`.`;;;’.`.`.`.`? 
echo                                  $;;’`.`.;.`.,;;;;;’.`.`.`.`.,;;;;;’.`.`.`.`.`.
echo                                  C;;’`.`,;;;;;;;’`.`.`.,;;;;;;’`.`.`.`.`.`.`.`.
echo                                ,$?;;’`.`;;;;;’.`.`.`;;;;;’.`.`.`.`.`.`.`.`.`.`.
echo                          ,,cJ??;$;;;’`.;;’.`.`.`,;;;;’.`.`.`.`.`.`.`.`.`.`.`.`.
echo                       ,=”`.`.;;;;;;’.`.;;’.`.`,;;;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                     ,P’`.`.`.`.`.`.`.`.;;;;;;;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                   ,P’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                  J”`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 J’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 F`.`.`?`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 $’.`,J.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`ccc,.`.`.
echo                 $’.`J’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`;;;;;;;?$,.`.
echo                 ?`.;F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.;;;;;;;;;;?i`.
echo                 `L.P’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.;;;;;;;;;;;?h.
echo                  hP’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`:;;;;;;;;;;;;;$
echo                  P’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`;;;;;;;;;;;;;$’
echo                ,P’.`.`.`.`.`.`.`.`.;;`.`.`.`.`.`.`.`.`.`.`.`.`.`j;;;;;;;;;;;” 
echo               ,P’`.`.`.`.`.`.`.`.`;;;:’`.`.`.`.`.`.`.`.`.`.`.`.`;;;;;;;;;;F 
echo              J”`.`.`.`.`.`.`.`.`.;;;;:’`.`.`.`.`.`.`.`.`.`.`.`.`3;;;;;;;;;$ 
echo             d’.`.`.`.`.`.`.`.`.`.;;;;:’`.,J??hc`.`.`.`.`.`.`.`.`9;;;;;;;;;F 
echo            d?h.`.`.`.`.`.`.`.`.`;;9;;:’`;$;jj;?h.`.`.`.`.`.`.`.;$;;;;;;;;9' 
echo           Jj;9,`.`.`.`.`.`.`.`.`;j$;;’.`3CJ;$;;$.`.`.`.`.`.`.;C;;;;;;;;$ 
echo           C$;9'`.`.`.`.`.`.`.`.;3C;;’.`?C;T;;;$’.`.`.`.`.`.`.;j;;;;;;;;F 
echo           ?;;$.`.`.`.`.`.`.`..;;;3C;;’.`.?hjjUP’.`.`.`.`.`.`.;;3;;;;;;;;$ 
echo            ?9F;’.`.`.`.`.`.`.;;j;9C;;’.`.`.`.`.`.`.`.`.`.`.`;;;F;;;;;;;;; 
echo             h;;;.`.`.`.`.`..;;;$`;h;;;’`.`.`.`.`.`.`.`.`.`.;;;F;;;;;;;;$ 
echo              $;;;;.`.`.`.,;;;;9':;9;;;;`.`.`.`.`.`.`.`.`.;;;;F;;;;;’.`;F 
echo               $;;;;,.`.`;;;;;9F`.;;$;;;;,`.`.`.`.`.`.,;;;;j$;;’`.`.`.`$ 
echo                ?;;;;;;;;;;;;JF.`.;;;?h;;;;;;;;;;;;;;;;;;j?;;;`.`.`.`.,F 
echo                  ?;;;;;;;;;$”`.`.`;;;;$i;;;;;;;;;;;;;jj??;;;.`.`.`.“J 
echo                   `?h;;;;J?`.`.`.`.`;;;;???Jjjjjjjj??;;;;`.`.`.`.`.“F 
echo                      ”3?‘`.`.`.`.;;’.`.`.;;;;;;;;;;;;’.`.`.`.`.`.`.`;F 
echo                       3`.`.`.`.`.;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$’ 
echo                       3`.`.`.`.`.;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.,F 
echo                       ?`.`.`.`.`.;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.$’ 
echo                       `h.`.`.`.`.;;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.F 
echo                        h.`.`.`.`.;;;.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`3' 
echo                        $.`.`.`.`.;;;’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$ 
echo                        $.`.`.`.`.;;;’`.`.`.`.`.`.`.`.`.`.`.`.`.`.,F 
echo                       .F.`.`.`.`.`;’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.3' 
echo                       j`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.3 
echo                       F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`,;cc????ci,3, 
echo                      J.`.`.`.`.`.`.`.`.`.`.`.`.`.`.,J?`.`.`.`.`.`.?L 
echo                     J’.`.`.`.`.`.`.`.`.`.`.`.`.`.`3?`.`.`__…`.`.`?c 
echo                  .,jF`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.?c??”"“”"h,.` .`.?? 
echo                 .F’`h`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.uc??????.`.`.`?h 
echo                  F`.$’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`zP’.`.`.`.`.`.`.`.`?c 
echo                  3?`$’.`.`.`.`.`.`.`.`.`.`.`.`.`.c=”`.`.`.`.`.`.`.`.`.`.`?c_,
echo               J?’”‘”.`.`.`.`.`.`.`$h.`.`.`.`.`.J?`.`._uc=”"” `.`.`.`.`.`.`.`.`.
echo               ?`.`3?.`.`.`.`.`.`.`$$:`.`.`.`.`?h_.,;P”`.`.`.`.`.`.`.`.`.`.`.`.`
echo                $’.`?,`.`.`.`.`.`.:$$’`.`.`.`.`.`;P”`.`.`.`.`._,zJ?`.`.`.`.`.`.`
echo              J??$’.`h`.`.`.`.`.`.`?P’`.`.`.`.`.`$’.`.,,ccc+?”"`.`.`.`.`.`.`.`.`
echo              $’.`?J?.`.`.`.`.`.`.`.`.`.`.`.`.`.`.”=”3?`.`.`.`.`.`.`.`. `.`.`.`.
echo              .$i`.`h.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`??`.`.`.,uc”"cu,_.`.`.` .`.
echo              $’??”"`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`”????”`.`.` .`.`?h_`.`.`.
echo              h`.3,.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`”??$P 
echo              `?cP’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.?, 
echo                 C`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`h 
echo                 C`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`3,
echo                 F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.“h
echo                 F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.$
echo                 F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.3,
echo                 h`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`h
echo                 h`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$
echo                 $’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`,/.`.`.`.`.`.`.`.`.`.`.`.`3
echo                 $’.`.`.`.`.\.`.`.`.`.`.`.`.`.`.`.`.j”`.`.`.`.`.`.`.`.`.`.`.`.`?
echo                 $’.`.`.`.`.`?,.`.`.`.`,,,;;;;;;;;;J’.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 3`.`.`.`.`.`.?’;;;;;;;;;;;;;;;;;;J’`.`.`.`.`.`.`.`.`.`.`.`.`.`.
echo                 3`.`.`.`.`.`.`?;;;;;;;;;;;;;;;;;$’.`.`.`.`.`.`.`.`.`.`.`.`.`.`,
echo                 ?`.`.`.`.`.`.`.?;;;;;;;;;;;;;;;P’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`j
echo                 ?,.`.`.`.`.`.`.`?;;;;;;;;;;;;j?`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`3
echo                 `h.`.`.`.`.`.`.`.L;;;;;;;;;;J’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$
echo                  $’`.`.`.`.`.`.`.`L;;;;;;;;J’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$
echo                  $’`.`.`.`.`.`.`.`.$;;;;;;;F.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$
echo                  $’`.`.`.`.`.`.`.`.`?L;;;;P’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.,F
echo                  $’`.`.`.`.`.`.`.`.`.`?L;$’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.$’
echo                  3.`.`.`.`.`.`.`.`.`.`.`?F.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`,F 
echo                  ?.`.`.`.`.`.`.`.`.`.`.,F`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$’ 
echo                  `h`.`.`.`.`.`.`.`.`.`,P’`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`$ 
echo                   h`.`.`.`.`.`.`.`.`.`J`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`F 
echo                   $’.`.`.`.`.`.`.`.`.,P’.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.,F 
echo                   ?`.`.`.`.`.`.`.`.`.J.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.j’ 
echo                   `h.`.`.`.`.`.`.`.`.F.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.$ 
echo                    h.`.`.`.`.`.`.`.`,F.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.`.` 
echo.
pause >nul
color 07
exit /b









:: "Counter" determines the heigth of the last row (no matter if from below or above)
:: "Width" determines the width of each line (from left to right)
:: "Line%%A" are the lines 1 to 24, undepending from their length or width
:: "Schalter1" = From above to below
:: "Schalter2" = From below to above

:: :: ----Line1-------------------------------------
:: :: -C--Line2----------W-i-d-t-h------------------
:: :: -o--Line3-------------------------------------
:: :: -u--Line4---------|---------Schalter 2--------
:: :: -n--Line5---------|---------------------------
:: :: -t--Line...-------V-------------A-------------
:: :: -e--Line23----------------------|-------------
:: :: -r--Line24----Schalter 1--------|-------------
:: :: ----Line25------------------------------------

:8
title Animation Box - Fill window
cls
if "%Counter%" == "0" (
	set Schalter=1
	set /a Width=!Width! + 1
)
if "!Schalter!" == "1" set /a Counter=%Counter% + 1
if "%Counter%" == "25" (
	set Schalter=2
	set /a Width=!Width! + 1
)
if "!Schalter!" == "2" set /a Counter=%Counter% - 1
if "!Schalter!" == "1" FOR /L %%A IN (1,1,%Counter%) DO set Line%%A=
if "!Schalter!" == "1" FOR /L %%A IN (1,1,%Counter%) DO FOR /L %%B IN (1,1,!Width!) DO set Line%%A=!Line%%A!±
if "!Schalter!" == "2" FOR /L %%A IN (24,-1,%Counter%) DO set Line%%A=
if "!Schalter!" == "2" FOR /L %%A IN (24,-1,%Counter%) DO FOR /L %%B IN (1,1,!Width!) DO set Line%%A=!Line%%A!±
FOR /L %%A IN (1,1,24) DO if defined Line%%A echo !Line%%A!
ping localhost -n 1 >nul
goto :8











:9
title Animation Box - Arrow left
mode con lines=25
echo.
echo.
echo.
echo.
echo                     8888
echo                   8888
echo                 8888
echo               8888
echo             8888
echo           8888
echo          8888888888888888888888888888888888888888888888
echo        _88888888888888888888888888888888888888888888888
echo         88888888888888888888888888888888888888888888888
echo          8888888888888888888888888888888888888888888888
echo            8888
echo              8888
echo                8888
echo                  8888
echo                    8888
echo                      8888
pause >nul
exit /b





:10
title Animation Box - Arrow right 
mode con lines=25
echo.
echo.
echo.
echo.
echo                                                       8888
echo                                                         8888
echo                                                           8888
echo                                                             8888
echo                                                               8888
echo                                                                 8888
echo                         8888888888888888888888888888888888888888888888
echo                         88888888888888888888888888888888888888888888888_
echo                         88888888888888888888888888888888888888888888888
echo                         8888888888888888888888888888888888888888888888
echo                                                                 8888
echo                                                               8888
echo                                                             8888
echo                                                           8888
echo                                                         8888
echo                                                       8888
pause >nul
exit /b








:: Blinking skull in "black-red" "darkred-grey" (background-font)

:11
title Animation Box - Skull
mode con lines=54
echo.
echo          _________                                       _________
echo         /         \                                     /         \
echo        /           \                                   /           \
echo        I    OOO    I                                   I    OOO    I
echo        I    OOO    I                                   I    OOO    I
echo        \           /                                   \           /
echo         \__     __/                                     \__     __/
echo            \    \                                         /    /
echo             \    \          ___________________          /    /
echo              \    \       _/                   \_       /    /
echo               \    \    _/                       \_    /    /
echo                \    \ _/                           \_ /    /
echo                 \    /     ,adPba,       ,adPba,     \    /
echo                  \  /     a8"""""8a     a8"""""8a     \  /
echo                   \/      Y8888888Y     Y8888888Y      \/
echo                   /       \@@@@@@@/     \@@@@@@@/       \
echo                   I         @@@@@         @@@@@         I
echo                   I                ,aAa,                I
echo                   I               a"""""a               I
echo                   I               8YYYYY8               I
echo                   I               9888887               I
echo                   I                @@@@@                I
echo                   I                                     I
echo                   \         ___________________         /
echo                  / \         ²       ²                 / \
echo                 /   \       _____²_________²___       /   \
echo                /    /\_                             _/\    \
echo               /    /   \_                         _/   \    \
echo              /    /      \_                     _/      \    \
echo             /    /         \___________________/         \    \
echo            /    /                                         \    \
echo         __/    (_                                         _)    \__
echo        /         \                                       /         \ 
echo       /           \                                     /           \
echo       I    OOO    I                                     I    OOO    I
echo       I    OOO    I                                     I    OOO    I
echo       \           /                                     \           /
echo        \_________/                                       \_________/
echo.
echo.
echo            888888                            88        88          88
echo            8888888                           88        88          88
echo            88    88                          88        88          88
echo            88     88                       aa88aa      88          88
echo            88      88                      YY88PY      88          88
echo            88      88  88888888  88888888    88        88888888    88
echo            88     88   88    88  88PYYY88    88        88888888    88
echo            88    88    88888888  88    88    88        88    88
echo            8888888     88        88aaaa88    88aaaaa   88    88    88
echo            888888      88888888  888888888   88888888  88    88    88

:11_Colour
color 0c
FOR /L %%A IN (1,1,6) DO ping localhost -n 1 >nul
color 47
FOR /L %%A IN (1,1,6) DO ping localhost -n 1 >nul
goto :11_Colour











:: Dos Techno Virus from the MS-DOS-times. It displays "TECHNO" all over again.
:: This animation stops after 25 lines (25 * 80 = 2000)
:: --- 25 = total amount of visible lines in one CMD-window
:: --- 80 = total amount of columns in one CMD-window

:: It sets the variable "M" to the entire code
:: There are 3 spaces between each "TECHNO"

:: When "C" equals 2,3 or 4, "L" is always a space
:: --- Else if "C" equals "0", the next letter is added to "M"
::     --- Either T,E,C,H,N or O (= TECHNO)

:: L = Letter
:: C = Changed
:: M = Message

:12
title Animation Box - Dos Techno Virus
set L= 
set M= 
set C=0
FOR /L %%A IN (1,1,2000) DO (
	if "!C!" == "1" set C=0
	if "!C!" == "2" (
		set L= 
		set C=1
	)
	if "!C!" == "3" (
		set L= 
		set C=2
	)
	if "!C!" == "4" (
		set L= 
		set C=3
	)
	if "!C!" == "0" if "!L!" == "N" (
		set L=O
		set C=4
	)
	if "!C!" == "0" if "!L!" == "H" (
		set L=N
		set C=1
	)
	if "!C!" == "0" if "!L!" == "C" (
		set L=H
		set C=1
	)
	if "!C!" == "0" if "!L!" == "E" (
		set L=C
		set C=1
	)
	if "!C!" == "0" if "!L!" == "T" (
		set L=E
		set C=1
	)
	if "!C!" == "0" if "!L!" == " " (
		set L=T
		set C=1
	)
	if "!Cursor!" == "ß" (set Cursor=Ü) ELSE (set Cursor=ß)
	set M=!M:~0,-1!!L!!Cursor!
	echo !M!
	ping localhost -n 1 >nul
	cls
)
pause >nul
exit /b







:: Animation of a tiger's head
:: ^ are used to allow | in the animation

:13
title Animation Box - Winhound
color 0c
echo $$$$                     $$$$$$'
echo  $$$$.$$$                 $$$$$$$$.
echo  $$$$$$'$$$$$$$$$$$$$$$$$$$$$$$$$
echo  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
echo    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
echo   $$$$$$$$$$....0ø)`$$;$$$$$....0ø)  , ,
echo  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ / /
echo  $$$$$$$$$$_$$$$$$$$$$$$$$$$$$$$$$./ /
echo  $$$$$$$$$_$$$$$'$$$$$$$$.$$.$$$`$$./
echo  $$$$$$$$$_$$$$$$$'$$$$$.$$$$.$$$`$$---"
echo $$$$$$$$$$_$$$$$$$$$$$$$$____$$$$$$`
echo $$$$$$$$$$$$_$$$$$$$$$$$$$_$$$$$$
echo $$$$$$$$$$$$$$$$___^|  /'___^|  /$
echo $$$$$$$$$$$$$$_____^| /_____^| /$
echo $$$$$$$$$$$$$__eeee^|/____$$^|/
echo $$$$$$$$$$$$$__,___,____$$
echo $$$$$$$$$$$$$$__,___,____$$
echo $$$$$$$$$$$$ $$___/^|___,__$/^|
echo $$$$$$$$$$$   $$_/ ^|,_____/ ^| 
echo $$$$$$$$$$     $/  ^|_____/  ^|$
echo $$$$$$$$$       $$$$$$$$$$$$$
echo $$$$$$$$         $$$$$$$$$$$
pause >nul
color 07
exit /b







:: Expands the window
:: "Lines" is always 55 less than "columns"

:14
FOR /L %%A IN (81,1,160) DO (
	set /a lines=%%A - 55
	mode con cols=%%A lines=!lines!
	ping localhost -n 1 >nul
)
pause
exit /b

















:: "(60,-1,0)" counts backwards

:C1
title Animation Box - 1 min
FOR /L %%A IN (60, -1,0) DO (
	echo %%A
	ping localhost -n 2 >nul
) 
msg %username% One minute is over. 2>nul || pause >nul
exit /b






:: The "2009" written in zeros is shown longer than the others
:: --- Still no reasonable explanation for that

:C2
title Animation Box - 2009
echo __//////____///////____///////_____///////__
echo _////////__/////////__/////////___//_____//_
echo _//____//__//_____//__//_____//___//_____//_
echo ______//___//_____//__//_____//____////////_
echo _____//____//_____//__//_____//__________//_
echo ____//_____//_____//__//_____//__________//_
echo ___//______//_____//__//_____//___//_____//_
echo _////////__/////////__/////////___//_____//_
echo //////////__///////____///////_____///////__
ping localhost -n 2 >nul
cls
echo __000000____0000000____0000000_____0000000__
echo _00000000__000000000__000000000___00_____00_
echo _00____00__00_____00__00_____00___00_____00_
echo ______00___00_____00__00_____00____00000000_
echo _____00____00_____00__00_____00__________00_
echo ____00_____00_____00__00_____00__________00_
echo ___00______00_____00__00_____00___00_____00_
echo _00000000__000000000__000000000___00_____00_
echo 0000000000__0000000____0000000_____0000000__
ping localhost-n 2 >nul
cls
echo __888888____8888888____8888888_____8888888__
echo _88888888__888888888__888888888___88_____88_
echo _88____88__88_____88__88_____88___88_____88_
echo ______88___88_____88__88_____88____88888888_
echo _____88____88_____88__88_____88__________88_
echo ____88_____88_____88__88_____88__________88_
echo ___88______88_____88__88_____88___88_____88_
echo _88888888__888888888__888888888___88_____88_
echo 8888888888__8888888____8888888_____8888888__
ping localhost -n 2 >nul
cls
echo __@@@@@@____@@@@@@@____@@@@@@@_____@@@@@@@__
echo _@@@@@@@@__@@@@@@@@@__@@@@@@@@@___@@_____@@_
echo _@@____@@__@@_____@@__@@_____@@___@@_____@@_
echo ______@@___@@_____@@__@@_____@@____@@@@@@@@_
echo _____@@____@@_____@@__@@_____@@__________@@_
echo ____@@_____@@_____@@__@@_____@@__________@@_
echo ___@@______@@_____@@__@@_____@@___@@_____@@_
echo _@@@@@@@@__@@@@@@@@@__@@@@@@@@@___@@_____@@_
echo @@@@@@@@@@__@@@@@@@____@@@@@@@_____@@@@@@@__
ping localhost -n 2 >nul
exit /b






:: Background and font changing their colors

:C3
color 6a
ping localhost -n 1 >nul
color 8f
ping localhost -n 1 >nul
color 3e
ping localhost -n 1 >nul
color f9
ping localhost -n 1 >nul
color 01
ping localhost -n 1 >nul
color 09
ping localhost -n 1 >nul
color 67
ping localhost -n 1 >nul
color 43
ping localhost -n 1 >nul
color d4
ping localhost -n 1 >nul
color a7
ping localhost -n 1 >nul
color c1
ping localhost -n 1 >nul
color f0
ping localhost -n 1 >nul
color b0
ping localhost -n 1 >nul
color ab
ping localhost -n 1 >nul
color ce
ping localhost -n 1 >nul
color 9e
ping localhost -n 1 >nul
color a3
ping localhost -n 1 >nul
color 1e
ping localhost -n 1 >nul
color fd
ping localhost -n 1 >nul
color c7
ping localhost -n 1 >nul
color c4
ping localhost -n 1 >nul
color 91
ping localhost -n 1 >nul
color 61
ping localhost -n 1 >nul
color 6f
ping localhost -n 1 >nul
color 01
ping localhost -n 1 >nul
goto :C3







:: Using "telnet" to connect to a website that shows Star Wars 3 in batch

:C4
telnet towel.blinkenlights.nl
exit /b








:: Matrix animations from a random picture found in google
:: --- There are 7 animations, 4 have been finished, yet
:: --- The animations are from the Linux command prompt 

:M1
title File System - File Manager
color 0a
mode con cols=110 lines=50
echo File  Edit  View  Go  Help
echo î     î     î     î   î
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ÉÍÍÍ»ÚÄÄÄÄ¿ÚÄÄÄÄÄÄÄ¿
echo ³   ÜÜÜ                      ³ ºÛÛ º³home³³Û shaun³
echo ³   [ ]    shaun             ³ ÈÍÍÍ¼ÀÄÄÄÄÙÀÄÄÄÄÄÄÄÙ
echo ³   ßßß                      ³
echo ³                            ³ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³   -^>                       ³ ³                                                                           ³
echo ³        Trash             ³ ³                                                                           ³
echo ³   Ä                       ³ ³    ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ        ³
echo ³                            ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ        ³
echo ³ ÚÄÄÄÄÄ¿                    ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ        ³
echo ³ ³     ³  Desktop           ³ ³    ÛÛß       ÛÛß       ÛÛß       ÛÛß       ÛÛß       ÛÛß      ÛÛß       ³
echo ³ ÀÄÄÄÄÄÙ                    ³ ³                                                                           ³
echo ³                            ³ ³    bin      boot       dev       etc      home       lib    lost+found    ³
echo ³úúúÛÛÜúúúúúúúúúúúúúúúúúúúúúú³ ³                                                                           ³
echo ³úúúÛÛÛúúúúFileúsystemúúúúúúú³ ³                                                                           ³
echo ³úúúÛÛßúúúúúúúúúúúúúúúúúúúúúú³ ³    ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ        ³
echo ³                            ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ        ³
echo ³                            ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ        ³
echo ³                            ³ ³    ÛÛß       ÛÛß       ÛÛß       ÛÛß      ÛÛß      ÛÛß       ÛÛß        ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³   media      mnt       opt      proc      root      sbin       srv        ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³    ÛÛÜ       ÛÛÜ       ÛÛÜ       ÛÛÜ                                      ³
echo ³                            ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ                                      ³
echo ³                            ³ ³    ÛÛÛ       ÛÛÛ       ÛÛÛ       ÛÛÛ                                      ³
echo ³                            ³ ³    ÛÛß       ÛÛß       ÛÛß       ÛÛß                                      ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³    sys       tmp       usr       var                                      ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ³                            ³ ³                                                                           ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pause >nul
color 07
exit /b







:M2
title Animation Box - Matrix part 2 - shaun@hacktop: cmatrix
color 0a
mode con cols=89 lines=33
echo   e       Y     ^|   -   g     ' ^|     ?   x 9     3 : $ S         Q     7         /   i
echo   s I     $   3 !   o   2     } 7     L   E 2     H I n 0   G     ^(     n         ^^
echo   Q :     ;   : 9   +   {     " 3     A   R 8     + A > >   y   ] u     j         %%
echo   + A     ^)   7 B   v M /       \     "   6 /     # Z 5 t   j   F #     s         0
echo   F ?     _   { Z   + N y       K     ^&   C ?   n l   b Y   l \ X T     c   Y     ^|
echo   B @     r I m [   E C ?       I     Q   5 ,   { h   W p   y 7 @ B     .   6     c
echo   Z _   e X 3 "     V A V `     T           h   G     r :   s f 0 `     *   ,     U
echo   H Z   I ^) x $       5 1 q     @           S   =     J R   9 B c ^&     +   r     S
echo   $ S   # $ E d       D ] Y       \         h   t     0 S   " i y N     Q   ^|     J
echo   s P   , C G h       R = 7 W     \         ^>   M     ^&     9 %% m x     q   `     b
echo   ^> j   s s Q )       _ e C :     \         \   ! .   b   X ^< z - V         w     '
echo   $ R U ! D b J       t ^> P ^|     '         ^^   ^> ^&   P   i K k f         _ N     0
echo   : Y 1 A # e !       ^( , / C     4         h   , ?   P   P   v n z       ? 2     b 0
echo   u q z $   v s       p ; ; 2     w         '   ] R   \   4 M o _         ? %%     z H
echo   r $ N #   g S j     K ; D z     J         C   z 5   9   \ 4   A     {   c y   * X p
echo   _ S 0 k   K = c     B ^^ : J     V         P   A {       2 ^(   '     :   I q   R u 8
echo   C . 2 j   = X \     . l L Y f   $             q 3       C =   D     t   g D   _ b /
echo     { ^< %%   9 i -     y a { F V   u             j X       _ 3   v   ^( 2   ^& 9   - \ 3
echo       e 7   n v I           " V   F             5         Q ?   B   + k   , 5   e 4 _
echo       S :   t ?   D         W 8 y D                       K `   @   U =   @ 6   5 4 -
echo       J ?   t '   )         I ^^ n $ f               *     D c   k   r L   Q J   x e b
echo       q ^^   u Q   b         3 " 0   \               x     0 6   %%   ` n   [ c   8 - m
echo       + $   i L   ?         L Y P   q           Z   Z     f i   8   b w W   f   c t q
echo       @ Z   L d   q           ` V   a           [   ;     S c   p   6 o X   1   4 F i
echo       / 4   ^> :   v           ! q   "         P "   d     M c   X   2 - ^>   t   5 i R
echo :     ? o   9 c   B           / ?   *         0 ^^   e     S 1   r   O N ^(   x   ? * E
echo 8     D #   ^| L   q           8 V   /   i     9 a   k     { ^)   n   A y 8   o   {   `
echo 3     ? \ V t Y   {           ^< G   ^&   #     } 5   c     J e h p   t Y =   X   $   \
echo N     ; @ ] 2 e   ^(       u   U +   y 7 v     S Z   k     S   { p   x C ^&   ?   T   c 3
echo K     1 z ^& a     F       n   0 '   H m v     F ;   .         b     k   b   g   o   V ^|
echo "       F ( d     k {     -   I r   # D T     ( ;   T         N     3   {     G Q   * H
pause >nul
color 07
exit /b






:M3
title Animation Box - Matrix part 2 - shaun@hacktop: scrot -c -d 3
mode con cols=89 lines=33
color 0a
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ packer -Syu
echo Password:
echo :: Synchronizing package databases...
echo  core is up to date
echo  extra is up to date
echo  community is up to date
echo :: Starting full system upgrade...
echo  local database is up to date
echo :: Synchronizing aur database...
echo  aur                                           6  6 [#############################] 100%%
echo :: Starting full aur upgrade...
echo  local database is up to date
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ uptime
echo  03:16:23 up  5:10,  1 user,  load average: 0.02, 0.08, 0.08
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ acpi
echo Battery 0: Full, 100%%
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ uname -a
echo Linux hacktop 2.6.32-ARCH #1 SMP REEMPT Tue Feb 9 14:46:08 UTC 2010 i686 Intel(R) Pentium(R) M processor 1.73GHz Genuine Intel GNU /Linux
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ scrot -c -d 3
echo Taking shot in 3.. 2.. 1.. Û
pause >nul
color 07
exit /b








:M4
title Animation Box - Matrix part 2 - shaun@hacktop: ~
mode con cols=89 lines=33
color 0a
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ archey
echo.
echo                +
echo                #                OS: Arch Linux i686
echo               ###               Hostname: hacktop
echo              #####              Kernel: 2.6.32-ARCH
echo             #######             Uptime: 5:10
echo            ;#######;            Window Manager: wmii
echo            #########            Desktop Environment: None found
echo           ###########           Packaged: 364
echo          #############          RAM: 274 MB / 2017 MB
echo         ###############         CPU: Intel(R) Pentium(R) M Processor 1,73 GHz
echo        #######   #######        Shell: Zsh
echo      .######;     ;######.      Root FS: 1.9G / 70G (ext3)
echo     .#######;     ;#######.
echo     #########.   .#########
echo    ######'           '######
echo   ;####                 ####;
echo   ##'                     '##
echo  #'                         '#
echo.
echo ÚÄ[shaun@hacktop][~]
echo ÀÄþ []
pause >nul
color 07
exit /b

















:: Reset variables from all animations to prevent missexecution
:: "exit /b" quits the last used CALL-command

:ResetVariables
set choice=
set Color=
set Counter=0
set Height=
set Length=
set Line=
FOR /L %%A IN (1,1,25) DO set Line%%A=
set Schalter=2
set Weight=
exit /b