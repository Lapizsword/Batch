@echo off

REM Dies stellt sicher, dass die Datei per CMD geöffnet worden ist und nicht
REM per Doppelklick.
REM -----------------------------------------------------------
if /i "%~0" == "cmdhelp" goto :System32_J
if /i "%~0" == "cmdhelp.bat" goto :System32_J

(
if exist "%SystemRoot%\system32" (
	if exist "%SystemRoot%\system32\cmdhelp.bat" (echo N|comp "%SystemRoot%\system32\cmdhelp.bat" "%~0"| find "unterschiedlich" >nul 2>nul && move /Y "%SystemRoot%\system32\cmdhelp.bat" "%SystemRoot%\system32\cmdhelp.bkf")
	move /Y "%~0" "%SystemRoot%\system32\cmdhelp.bat"
)
if exist "%SystemRoot%\system64" (
	if exist "%SystemRoot%\system64\cmdhelp.bat" (echo N|comp "%SystemRoot%\system64\cmdhelp.bat" "%~0"| find "unterschiedlich" >nul 2>nul &&  move /Y "%SystemRoot%\system64\cmdhelp.bat" "%SystemRoot%\system64\cmdhelp.bkf")
	move /Y "%~0" "%SystemRoot%\system64\cmdhelp.bat"
)
if errorlevel 1 ping localhost -n 2 >nul
start cmd /k cmdhelp
exit
)
REM -----------------------------------------------------------

:System32_J

if "%2" == "Kommandozentrale" (set Exit=goto :Kommandozentrale) ELSE (set Exit=exit /b)
if /i "%2" == "/w" if "%3" == "Kommandozentrale" set Exit=goto :Kommandozentrale

REM Dies ist zur detaillierteren Übersicht.
REM -----------------------------------------------------------
if "%1" == "/?" goto :HELP
if /i "%1" == "Programmpfade" goto :Programmpfade
if /i "%1" == "Argumente" goto :Argumente
if /i "%1" == "Ascii" goto :Ascii
if /i "%1" == "Befehle" goto :Befehle
if /i "%1" == "Errorlevel" goto :Errorlevel
if /i "%1" == "Explorer" goto :Explorer
if /i "%1" == "FTP" goto :FTP
if /i "%1" == "Kurznamen" goto :Kurznamen
if /i "%1" == "Sonderzeichen" goto :Sonderzeichen
if /i "%1" == "Springpunkte" goto :Springpunkte
if /i "%1" == "User" goto :User
if /i "%1" == "User32" goto :User
if /i "%1" == "User/User32" goto :User
if /i "%1" == "Variablen" goto :Variablen
if /i "%1" == "Variabeln" goto :Variablen
if /i "%1" == "Kommandozentrale" goto :Kommandozentrale
if "%1" == "" goto :Lesen
%1 /?
%Exit%
REM -----------------------------------------------------------

:Lesen
echo Geben Sie 'cmdhelp Befehl' ein, um weitere Informationen zu einem bestimmten
echo Befehl anzuzeigen (gilt ab --A--).
echo.
echo %%VAR%%             Variable, die durch "Set" festgelegt wurde.
echo %%VAR:~X,Y%%        Variable, bei der von Zeichen X die folgenden Y Zeichen
echo                   genommen werden.
echo %%VAR:A=B%%         Variable, bei der Zeichenfolge "A" durch "B" ersetzt wird.
echo %%0                Pfad der momentan ge”ffneten Batchdatei.
echo ^>NUL              Versteckt die Ausgabe des Befehls.
echo 2^>NUL             Versteckt Fehlerausgaben des Befehls.
echo 2^>^&1              Versteckt die Ausgabe des Befehls auch bei Fehlern.
echo ------A------
echo [ARGUMENTE]       %%1, %%2... k”nnen ver„ndert werden wie bei "FOR".
echo [ASCII]           Besondere Zeichen, die in CMD anders sind als in Notepad.
echo ASSOC             Bearbeitet die Zuordnung von Dateiendungen.
echo ATTRIB            Bearbeitet die Attribute von Dateien.
echo AT                Legt fest, wann ein Befehl ausgefhrt werden soll.
echo ------B------
echo [BEFEHLE]         Listet nur Befehle ohne Informationen auf.
echo BREAK             Legt fest, ob Strg+C erlaubt werden soll.
echo ------C------
echo CACLS             Bearbeitet den Zugriff auf Dateien.
echo CALL              Ruft Batchdateien oder Sprinkpunkte auf.
echo CD / CHDIR        Wechselt das Verzeichnis.
echo CHCP              Žndert die Codepagenummer.
echo CHKDSK            šberprft den Datentr„ger auf Fehler und zeigt Infos an.
echo CHKNTFS           šberprft den Datentr„ger beim Windowsstart.
echo CLS               S„ubert den Bildschirm.
echo CMD               Startet ein neues CMD-Fenster.
echo COLOR             Wechselt die Farben.
echo COMMAND           Startet Command.com.
echo COMP              Vergleicht zwei Dateien.
echo COMPACT           Zeigt die Komprimierung von Dateien an oder „ndert diese.
echo CONVERT           Konvertiert FAT in NTFS.
echo COPY              Kopiert eine Datei.
echo ------D------
echo DATE              Žndert das Datum.
echo DEFRAG            Defragmentiert eine Partition.
echo DEL / ERASE       L”scht Dateien.
echo DIR               Zeigt Ordner und Dateien an.
echo DOSKEY            Bearbeitet Befehlseingaben und erstellt Makros.
echo DRIVERQUERY       Zeigt installierte Treiber an.
echo ------E------
echo ECHO              Zeigt Nachrichten an.
echo ENDLOCAL          Schlieát den Raum von "Setlocal".
echo [ERRORLEVEL]      Ist der Wert nach einem Befehl bz. Fehlern.
echo EXIT              Schlieát CMD.
echo [EXPLORER]        Startet den Windows Explorer.
echo ------F------
echo FC                Vergleicht mehrere Dateiens„tze.
echo FIND              Sucht nach einer Zeichenfolge in einer Datei.
echo FINDSTR           Sucht nach einer Zeichenfolge in Dateien.
echo FOR               Fhrt Befehle fr mehrere Dateien, einen Befehl oder eine
echo                   Zeichenfolge aus.
echo FORMAT            Formatiert eine Partition.
echo [FTP]             File transfer protocol, Dateitransfer mit anderen Servern.
echo FTYPE             Legt den ™ffnen-Befehl eines Dateityps fest.
echo ------G------
echo GOTO              Geht zu einem Springpunkt.
echo GPRESULT          Zeigt Gruppenrichtlinien an.
echo GRAFTABL          Erm”glicht Windows, Sonderzeichen anzuzeigen.
echo ------H------
echo HELP              Zeigt Hilfe [zu einem Befehl] an.
echo ------I------
echo IF                Setzt Bedingungen.
echo IPCONFIG          Žndert Einstellungen zum Verbinden mit dem Internet.
echo ------K------
echo [KURZNAMEN]       Namen mit max. 8 Zeichen.
echo ------L------
echo LABEL             Erstellt, l”scht oder „ndert einen Volumennamen.
echo ------M------
echo MD / MKDIR        Erstellt einen Ordner.
echo MODE              Ver„ndert Einstellungen des CMD-Fensters.
echo MORE              Zeigt den Inhalt einer Datei an mit Pausen pro Seite.
echo MOVE              Verschiebt eine Datei.
echo MSG *             Zeigt eine Nachricht in einem neuen Fenster an.
echo MSGBOX *          Zeigt eine Nachricht in einem neuen Fenster an.
echo ------N------
echo NET               Arbeitet mit Benutzern oder Diensten.
echo NETSH             Kann z.T. mit der Firewall arbeiten.
echo NETSTAT           Zeigt laufende Verbindungen zum Internet an.
echo ------P------
echo PATH              Zeigt die Umgebungspf„de an oder „ndert sie.
echo PAUSE             Pausiert bis zum Tastendruck.
echo PING              Zeitbedingte Pause // Abfragen von IPs.
echo PRINT             Druckt eine Textdatei.
echo [PROGRAMMPFADE]   Siehe 'cmdhelp Programmpfade'.
echo PROMPT            Žndert die Eingabeaufforderung.
echo PUSHD / POPD      Speichert das aktuelle Verzeichnis und wechselt es.
echo ------R------
echo RD / RMDIR        L”scht ein komplettes Verzeichnis.
echo RECOVER           Stellt Dateien von einem besch„digten Sektor wiederher.
echo REG               Bearbeitet die Registry.
echo REGEDIT           Ruft [einen Pfad in der] Registry auf.
echo REM               Wird nicht beachtet bei der Ausfhrung einer Batchdatei.
echo REN / RENAME      Benennt eine Datei um.
echo REPLACE           Ersetzt Dateien.
echo ------S------
echo SC                Arbeitet mit [den wahren Namen von] Diensten.
echo SET               Setzt Variablen // Rechnet Formeln aus.
echo SETLOCAL          Erlaubt fortgeschrittenes Coden.
echo SHIFT             Žndert die Abfolge von Argumenten.
echo SHUTDOWN          F„hrt den Computer runter.
echo [SONDERZEICHEN]   Manche k”nnen nicht normal geschrieben werden.
echo SORT              Sortiert den Inhalt von Dateien und zeigt diesen an.
echo [SPRINGPUNKTE]    Regeln das Arbeiten in Batchdateien mit separaten Bereichen.
echo START             Startet eine Datei.
echo SUBST             Weist einem Pfad einen Laufwerkbuchstaben zu.
echo SYSTEMINFO        Zeigt viele Systeminformationen an.
echo ------T------
echo TASKKILL          Beendet einen Prozess.
echo TASKLIST          Zeigt eine Prozessliste an.
echo TIME              Zeigt die Zeit an oder „ndert sie.
echo TITLE             Žndert den Fenstertitel von CMD.
echo TREE              Zeigt eine Verzeichnisstruktur graphisch an.
echo TSKILL            Beendet einen Prozess (veraltet).
echo TYPE              Zeigt den Inhalt einer Datei an.
echo ------U------
echo [USER/USER32]     Bearbeitet teilweise Hardwareeinstellungen.
echo ------V------
echo [VARIABLEN]       =%%var%%, festgelegt durch "Set".
echo VER               Zeigt die Windowsversion an.
echo VERIFY            Legt fest, ob das Schreiben von Dateien berprft werden soll
echo VOL               Zeigt die Volumebezeichnung und Seriennummer an.
echo ------W------
echo WMIC              Arbeitet mit nahezu allem.
echo ------X------
echo XCOPY             Kopiert mehrere Dateien.
%Exit%


:Programmpfade
echo.
echo Folgende Befehle ”ffnen Programme unter Windows XP Professional:
echo.
echo --------
echo Calc           Windows Taschenrechner
echo Certmgr.msc    Manager fr Zertifikate
echo Charmap        Windows Zeichentabelle
echo Cleanmgr       Windows Datentr„gerbereinigungsassistent
echo CMD            CMD.exe (siehe CMD /?)
echo Compmgmt.msc   Computerverwaltung
echo --------
echo Devmgmtm.msc   Ger„temanager
echo Dfrg.msc       Windows XP-Defragmentierung
echo Diskmgmt.msc   Datentr„gerverwaltung
echo Drwtsn32       Doktor Watson, Windows Crash Reporter
echo Edit           DOS Editor
echo Eudcedit       Zeichenerstellungsprogramm
echo Eventvwr       Ereignisprotokollierung
echo Start Excel    Microsoft Office Excel
echo Explorer       Windows Explorer
echo --------
echo Start firefox  Mozilla Firefox
echo Freecell       Kartenspiel
echo Fsmgmt.msc     Ordnersicherheit / Freigabe von Ordnern
echo Gpedit.msc     Gruppenrichtlinieneditor
echo Iexplore       Windows Internet Explorer
echo Lusrmgr.msc    Lokale Benutzer- und Gruppenmanager
echo --------
echo Magnify        Windows Bildschirmlupe
echo Start moviemk  Windows Movie Maker
echo Mplay32        Media Player
echo Start mplayer2 Windows Media Player - alte Variante
echo Start msconfig Microsoft Konfigurationsmanager bz. Autostarts/Tools etc.
echo Mshearts       Kartenspiel
echo Start msinfo32 Systeminformationen
echo Mspaint        Zeichenprogramm
echo Narrator       Sprachassistent
echo Notepad        Texteditor
echo Ntbackup       Manager fr Sicherungskopien
echo Ntmsmgr.msc    Wechselmedien-Manager
echo Ntmsoprq.msc   Wechselmedien-Manager
echo --------
echo Start OneNote  Microsoft Office OneNote
echo Osk            On-Screen-Keyboard, Bildschirmtastatur
echo Perfmon.msc    Systemmonitor ber Leistung
echo Start pinball  Pinballspiel
echo Start powerpnt Microsoft Office Powerpoint
echo Regedit        Registry-Editor
echo Regedt32       Registry-Editor
echo Rsop.msc       Gruppenrichtlinienauswertung im Internet
echo Secpol.msc     Lokale Sicherheitsrichtlinien
echo Services.msc   Dienste
echo Sndrec32       Windows Soundrecorder
echo Sndvol32       Manager fr Volumen und Ton
echo Sol            Kartenspiel
echo Spider         Kartenspiel
echo --------
echo Taskmgr        Windows Task-Manager
echo Tourstart      Windows XP-Tour
echo Utilman        Hilfsprogrammmanager
echo Verifier       Treiber-šberprfungsassisten
echo Winhelp        Windows Hilfe
echo Winmine        Spiel
echo Winver         Windows Version
echo Start winword  Microsoft Office Word
echo Start wmplayer Windows Media Player
echo Start wordpad  Texteditor
echo Write          Texteditor
%Exit%


:HELP
echo.
echo Listet s„mtliche Befehle von CMD / Batch auf.
echo.
echo Syntax:
echo.
echo Liste der Befehle: ' cmdhelp '
echo Hilfe zu Befehlen: ' cmdhelp Befehl '
echo Kommandozentrale : ' cmdhelp Kommandozentrale '
%Exit%


:Argumente
echo.
echo Argumente sind vergleichbar mit Variablen, allerdings werden sie beim Starten
echo einer Batchdatei oder beim Aufrufen eines Springpunktes per 'call' verwendet.
echo.
echo Argumente werden wiefolgt geschrieben:
echo %%1
echo %%2
echo %%3
echo ..
echo %%9
echo.
echo %%10 existiert nicht. Um dieses Argument zu verwenden, muss man 'shift'
echo benutzen.
echo Argumente lassen sich ver„ndern wie die Variablen des 'FOR-befehls', wenn es
echo sich um Pfade handelt:
echo.
echo %%~1      = Argument wird ohne Anfhrungszeichen benutzt.
echo %%~d1     = Argument ist nur der Laufwerkbuchstabe     des Pfades.
echo %%~p1     = Argument ist nur der Pfad ohne Dateinamen  des Pfades.
echo %%~f1     = Argument ist nur der komplette Dateiname   des Pfades.
echo %%~n1     = Argument ist nur der Dateiname ohne Endung des Pfades.
echo %%~x1     = Argument ist nur die Dateiendung           des Pfades.
echo %%~s1     = Argument wird in Kurznamen umgewandelt.
echo %%~a1     = Argument ist die Dateiattribute der Datei  des Pfades.
echo %%~t1     = Argument ist Datum und Zeit der Datei      des Pfades.
echo %%~z1     = Argument ist die Dateigr”áe der Datei      des Pfades.
echo.
echo Die Buchstaben k”nnen kombiniert werden zu z.B. %%~nx1 oder %%~dpfs1.
echo.
echo Beispiele fr Argumente:
echo 1. Bei dem eingegebenen Befehl ' cmdhelp Argumente ' ist "Argumente" %%1.
echo 2. Bei dem eingegebenen Befehl ' FOR /? ' ist "/?" %%1.
echo 3. Bei dem eingegebenen Befehl ' netsh firewall show opmode ' ist "firewall"
echo    %%1, "show" ist %%2 und "opmode" ist %%3.
echo.
echo 4. Bei dem Befehl ' call :Sprinpunkt "Pfad" Dateiname "Beschreibung" ist
echo    '"Pfad"' %%1, "Dateiname" %%2 und '"Beschreibung"' %%3.
echo.
echo Enth„lt ein Argument ein Leerzeichen, es soll aber trotzdem nur ein einziges
echo sein, kann man es in Anfhrungszeichen stellen.
%Exit%


:Ascii
echo.
echo Ascii-Zeichen sind Symbole, die in Notepad anders stehen als als sie von CMD
echo gelesen werden.
echo Sie lassen sich schreiben, indem man ' Alt + Nummer vom Ziffernblock ' drckt.
echo Dabei muss Alt solange gedrckt werden, bis alle Nummern eingegeben wurden.
echo.
echo W„hrend ' Alt + 234 ' ein U mit Dach darstellt, ist es in CMD ein Block bzw.
echo ein komplett ausgeflltes Leerzeichen.
echo.
echo Bei Ascii stehen die Nummer 1-256 oder 01-0256 zur Verfgung. Letztere sind
echo im Allgemeinen dieselben wie erstere, allerdings eher geordnet.
%Exit%


:Errorlevel
echo.
echo Der Errorlevel wird nach jedem ausgefhrten Befehl neu festgelegt. Meist ist
echo er 0 oder 1.
echo Ist der Errorlevel 0, wurde der Befehl ohne Fehler ausgefhrt.
echo Ist der Errorlevel 1, wurde der Befehl mit Fehlern ausgefhrt.
echo.
echo Der Errorlevel wird festgelegt in %%ERRORLEVEL%%. Mit ihm lassen sich IF-
echo Bedingungen aufstellen, um zu prfen, ob ein Befehl geglckt ist:
echo.
echo if errorlevel 1 echo Befehl misslungen!
echo.
echo Er wird allerdings auch in Verbindung mit dem Windows-XP-Home-Befehl 'choice'
echo verwendet. Dieser Befehl ist hier nicht aufgefhrt.
%Exit%


:Explorer
echo.
echo 'explorer' ”ffnet den Windows Explorer. Man kann auch Pfade eingeben:
echo.
echo explorer C:\Windows\system32
echo.
echo Wird ber diesen Befehl eine Datei aufgerufen, sendet Windows (unter XP Prof.)
echo vorerst eine Benachrichtigung, dass diese Datei ausgefhrt werden m”chte.
echo.
echo Anstelle von 'explorer' bietet sich 'start' an.
%Exit%


:FTP
echo.
echo FTP steht fr "File Transfer Protocol". Das bedeutet, es k”nnen Dateien
echo ber das Internet versendet werden.
echo Damit dies m”glich wird, ben”tigt man einen FTP-f„higen Server und Login-
echo daten dazu.
echo.
echo Der FTP-Befehl kann entweder automatisiert oder manuell ausgefhrt werden.
echo Parameter fr die automatisierte Form sind folgende:
echo.
echo Syntax: FTP [-v] [-d] [-i] [-n] [-g] [-s:Dateiname] [-A] [Host]
echo îîîîîîî
echo -A	        Meldet den Benutzer als "Anonym" an. 
echo -d         Aktiviert debugging. 
echo -g         Deaktiviert Platzhalter. 
echo -i         L„dt mehrere Dateien ohne Nachfrage hoch. 
echo -n         Keine automatische Anmeldung beim ™ffnen der Seite. 
echo -s:Datei   Gibt eine Datei an, aus der FTP-Befehle gelesen werden sollen.
echo -v         Keine Informationen anzeigen.
echo Host       Website oder IP.
echo.
echo Um die automatisierte Form richtig zu nutzen, sollte man eine Datei haben mit
echo manuellen Befehlen, aus der gelesen wird (-s:Datei).
echo.
echo Fr die manuelle Version gibt es folgende Befehle:
echo.
echo !               delete          literal         prompt          send
echo ?               debug           ls              put             status
echo append          dir             mdelete         pwd             trace
echo ascii           disconnect      mdir            quit            type
echo bell            get             mget            quote           user
echo binary          glob            mkdir           recv            verbose
echo bye             hash            mls             remotehelp
echo cd              help            mput            rename
echo close           lcd             open            rmdir
echo.
echo Zur n„heren Erkl„rung der Befehle geben Sie "FTP" in CMD ein und dann "?".
echo Hier eine ntzliche Befehlsfolge:
echo.
echo open www.ftp-server.com
echo user FTP_001
echo FTP-Tester_001
echo ascii
echo prompt
%EXIT%


:Kurznamen
echo.
echo Kurznamen sind verkrzte Namen von Pfaden oder Dateien, die eine Arbeit
echo erleichtern k”nnen, wenn man z.B. den Befehl 'start' verwendet.
echo.
echo Sie werden auch 8-Punkt-3-Namen genannt, weil die Namen nicht mehr als 8
echo Zeichen enthalten und deren Dateiendung nicht mehr als 3.
echo.
echo Leerzeichen werden bei den Kurznamen gel”scht. Auch wird hier nicht zwischen
echo Groá- und Kleinschreibung unterschieden.
echo.
echo Kurznamen eines Pfades sind leicht herauszufinden:
echo Man nimmt die ersten 6 Zeichen des Pfadabschnittes und fgt ein ~1 hinzu.
echo Sollte es dabei zweimal denselben Namen geben, geht das Programm nach
echo dem Alphabet. Demnach ist der zweite Pfad dann ~2:
echo.
echo C:\Dokumente und Einstellungen\Benutzer\Lokale Einstellungen\Temp
echo C:\DOKUME~1\BENUTZ~1\LOKALE~1\Temp
echo ---^> Die ersten 6 Buchstaben genommen und ~1 angeh„ngt.
echo.
echo C:\Dies ist ein Ordner\Und eine Datei.txt
echo C:\DIESIS~1\UNDEIN~1.TXT
echo ---^> Die Leerzeichen wurden entfernt, die ersten 6 Buchstaben genommen, ein
echo      ~1 angeh„ngt und die Endung hinter die Datei geschrieben.
%Exit%


:Sonderzeichen
echo.
echo Sonderzeichen wie ^&, ^| oder %% werden in Batch als Sttze fr Befehle
echo verwendet.
echo ^&    = Befehlstrennung. Befehl1 ^& Befehl2 werden ausgefhrt.
echo ^&^&   = Befehlstrennung. Befehl2 wird nur ausgefhrt, wenn Befehl1 geglckt
echo        ist.
echo ^|    = Befehlsverbindung. Die Befehle beziehen sich aufeinander. Dabei gibt
echo        es einige Regeln. Mehr dazu unten.
echo ^|^|   = Befehlstrennung. Befehl2 wird nur ausgefhrt, wenn Befehl1 miss-
echo        glckt ist.
echo %%    = Multiple Verwendung: 1. Variablen
echo                             2. Argumente
echo                             3. FOR-Befehl
echo ^>    = Dateierstellung. Erstellt die Datei, die dahinter genannt wird, mit
echo        der Ausgabe des Befehls, der davor geschrieben ist. (echo Hi^>Miep.log)
echo ^>^>   = Dateierstellung. Erweitert die Datei, die dahinter genannt wird, um
echo        der Ausgabe des Befehls, der davor geschrieben ist. (echo Hi^>^>Miep.log)
echo.
echo Bei den meisten Sonderzeichen muss man einfach ein ^^ vorstellen, damit das
echo Zeichen in z.B. echo gedruckt werden kann.
echo Bei Prozentzeichen muss man ein weiteres %% vorstellen, damit es gedruckt
echo werden kann. Bei Variablen  : %%%%var%%%%
echo              Bei Argumenten : %%%%1
echo              Beim FOR-Befehl: %%%%%%%%A
echo.
echo ^| verbindet Befehle. Ein Befehl bezieht sich immer auf die Ausgabe des
echo anderen, dabei muss jedoch 'echo' an vorderer Stelle stehen.
echo 'sort' oder 'more' z.B. steht dabei jedoch an hinterer Stelle.
echo.
echo So bezieht sich bei 'echo.^|date' das 'echo' auf die Frage von 'date', welches
echo neue Datum der Benutzer eingeben m”chte.
echo.
echo Bei 'systeminfo^|sort' sortiert 'sort' jedoch die Ausgabe von 'systeminfo' nach
echo dem Alphabet.
%Exit%


:Springpunkte
echo.
echo Springpunkte sind Markierungen innerhalb einer Batchdatei, die das Arbeiten
echo mit bestimmten Funktionen deutlich erleichtern k”nnen.
echo.
echo Ein Springpunkt beginnt immer mit einem Doppelpunkt.
echo :Springpunkt
echo.
echo Er enth„lt niemals Leerzeichen und auch Groá- und Kleinschreibung ist zu be-
echo achten. Steht hinter einem Springpunkt ein weiteres Wort, ist dies ein Argu-
echo ment (%%1, %%2 usw.).
echo.
echo Springpunkte werden mit 'goto' oder mit 'call' aufgerufen:
echo goto Springpunkt
echo call Springpunkt
echo.
echo Der 'goto-Befehl' ist unwiderruflich im Gegensatz zu dem 'call-Befehl'. Eine
echo Batchdatei fhrt die Befehle unter dem 'call-Befehl' fort, wenn sie sich
echo normalerweise schlieáen wrde.
echo Hier ein kurzes Beispiel:
echo _______________________________________________________________
echo @echo off
echo echo Dies ist definitiv die erste Zeile, die angezeigt wird.
echo call :Ende
echo echo Diese Zeile wird als allerletztes angezeigt.
echo pause ^>nul
echo :Ende
echo echo Diese Zeile steht an zweiter Stelle.
echo exit /b
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo.
echo 'exit /b' schlieát eine Batchdatei, nicht aber das CMD-Fenster.
%Exit%



:User
echo.
echo Zu User/User32 stehen nicht gengend Informationen zu Verfgung, um eine
echo detaillierte Erkl„rung geben zu k”nnen. Wir bitten um Entschuldigung.
%Exit%


:Variablen
echo.
echo Variablen sind Werte, die auf Zeichenfolgen festgelegt wurden. Sie werden mit
echo dem Befehl 'SET' gesetzt.
echo.
echo Variablen werden mit Prozentzeichen umschlossen oder, unter Verwendung von
echo 'setlocal enabledelayedexpansion' auch mit Ausrufezeichen:
echo.
echo %%Variable%%
echo !Variable!
echo.
echo Dabei werden die Zeichenfolgen aufgerufen. Es lassen sich somit Benutzer-
echo eingaben auswerten, man kann das Programm z„hlen lassen oder man kann
echo ein Spiel schreiben, indem man fr jeden Platz eine Variable setzt.
echo.
echo Letzteres ist jedoch fr erfahrene Schreiber.
echo.
echo Beispiel:
echo set Autostart=C:\Dokumente und Einstellungen\Benutzer\Startmen\Programme
echo set Autostart=%%Autostart%%\Autostart
echo echo Der Autostartordner ist %%Autostart%%.
echo.
echo Ausgegeben werden wrde:
echo Der Autostartordner ist C:\Dokumente und Einstellungen\Benutzer\Startmen\Programme\Autostart.
%Exit%


:Befehle
echo.
REM 98 / 4 = 25
if not "%2" == "/w" (
echo Unter der Verwendung von /w k”nnen Sie die Befehle im Breitformat anzeigen.
echo.
	FOR /F "skip=23 tokens=1-3" %%A IN ('"cmdhelp|sort"') DO (
		if not "%%A" == "Befehl" (
			if not "%%A" == "Geben" (
				if not "%%B" == "/" (
					echo %%A
				) ELSE (
					echo %%A %%B %%C
				)
			)
		)
	)
) ELSE (
REM  1                  2                  3                  4
echo %%0                 CHKNTFS            GPRESULT           REN / RENAME
echo %%var%%              CLS                GFRATABL           REPLACE
echo %%var:~X,Y%%         CMD                HELP               SC
echo [ARGUMENTE]        COLOR              IF                 SET
echo [ASCII]            COMMAND            LABEL              SETLOCAL
echo [BEFEHLE]          COMP               MD / MKDIR         SHIFT
echo [ERRORLEVEL]       COMPACT            MODE               SHUTDOWN
echo [EXPLORER]         CONVERT            MORE               SORT
echo [KURZNAMEN]        COPY               MOVE               START
echo [PROGRAMMPFADE]    DATE               MSG                SUBST
echo [SONDERZEICHEN]    DEFRAG             MSGBOX             SYSTEMINFO
echo [SPRINGPUNKTE]     DEL / ERASE        NET                TASKKILL
echo [USER/USER32]      DIR                NETSH              TASKLIST
echo [VARIABLEN]        DOSKEY             NETSTAT            TIME
echo ^>NUL               DRIVERQUERY        PATH               TITLE
echo 2^>^&1               ECHO               PAUSE              TREE
echo ASSOC              ENDLOCAL           PING               TSKILL
echo AT                 EXIT               PRINT              TYPE
echo ATTRIB             FC                 PROMPT             VER
echo BREAK              FIND               PUSHD / POPD       VERIFY
echo CACLS              FINDSTR            RD / RMDIR         VOL
echo CALL               FOR                RECOVER            WMIC
echo CD / CHDIR         FORMAT             REG                XCOPY
echo CHCP               FTYPE              REGEDIT
echo CHKDSK             GOTO               REM
)
%Exit%


:Kommandozentrale
echo.
set Befehl=
set /p Befehl=%cd% ^| cmdhelp ^> 
if /i "%Befehl%" == "q" exit /b
if /i "%Befehl%" == "quit" exit /b
if /i "%Befehl%" == "stop" exit /b
if "%Befehl%" == "" (goto :Lesen) ELSE (cmdhelp %Befehl% Kommandozentrale)
goto :Kommandozentrale


REM ***************** Test:Wie weit kann CMD die Eingabe anzeigen? *****************