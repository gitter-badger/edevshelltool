@ECHO off
CLS

:: https://autohotkey.com/docs/misc/CLSID-List.htm

:MENU
CLS
ECHO ================= SIMPLE MENU =================
ECHO      PRESS 1-15 to your task, or 16 to EXIT.
ECHO ===============================================
ECHO 1 - win_controlpanel.appwiz
ECHO 2 - win_controlpanel.netplwiz
ECHO 3 - win_controlpanel.sysdm
ECHO 4 - win_devicemanager
ECHO 5 - win_msconfig
ECHO 6 - win_networkpanel
ECHO 7 - win_policyeditorgroup
ECHO 8 - win_policyeditorsecurity
ECHO 9 - win_shell.AccountPictures
ECHO 10 - win_shell.AppsFolder
ECHO 11 - win_shell.ProgramsFolderFastItems
ECHO 12 - win_shell.RefreshResetPC
ECHO 13 - win_shell.Roaming Tiles
ECHO 14 - win_shell.startup
ECHO 15 - CLSID.RecycleBin
ECHO 16 - EXIT
ECHO ===============================================
SET INPUT=
SET /P INPUT=Type 1-15 then press ENTER:
IF /I '%INPUT%'=='1' GOTO NUM1
IF /I '%INPUT%'=='2' GOTO NUM2
IF /I '%INPUT%'=='3' GOTO NUM3
IF /I '%INPUT%'=='4' GOTO NUM4
IF /I '%INPUT%'=='5' GOTO NUM5
IF /I '%INPUT%'=='6' GOTO NUM6
IF /I '%INPUT%'=='7' GOTO NUM7
IF /I '%INPUT%'=='8' GOTO NUM8
IF /I '%INPUT%'=='9' GOTO NUM9
IF /I '%INPUT%'=='10' GOTO NU10
IF /I '%INPUT%'=='11' GOTO NUM11
IF /I '%INPUT%'=='12' GOTO NUM12
IF /I '%INPUT%'=='13' GOTO NUM13
IF /I '%INPUT%'=='14' GOTO NUM14
IF /I '%INPUT%'=='15' GOTO NUM15
IF /I '%INPUT%'=='16' GOTO QUIT
CLS
ECHO ============INVALID INPUT============
ECHO Please select a number from the Main
ECHO Menu [1-15] or select '16' to quit.
ECHO  ======PRESS ANY KEY TO CONTINUE======
PAUSE > NUL
GOTO MENU

:QUIT
CLS
ECHO ==============THANKYOU===============
ECHO ======PRESS ANY KEY TO CONTINUE======
PAUSE>NUL
EXIT

:NUM1
appwiz.cpl
PAUSE>NUL
and so on
GOTO MENU

:NUM2
netplwiz.exe
PAUSE>NUL
and so on
GOTO MENU

:NUM3
sysdm.cpl
PAUSE>NUL
and so on
GOTO MENU

:NUM4
mmc devmgmt.msc
PAUSE>NUL
and so on
GOTO MENU

:NUM5
MSConfig.exe
PAUSE>NUL
and so on
GOTO MENU

:NUM6
rundll32.exe %SystemRoot%\system32\van.dll, RunVAN
PAUSE>NUL
and so on
GOTO MENU

:NUM7
gpedit.msc
PAUSE>NUL
and so on
GOTO MENU

:NUM8
secpol.msc
PAUSE>NUL
and so on
GOTO MENU

:NUM9
explorer.exe shell:AccountPictures
PAUSE>NUL
and so on
GOTO MENU

:NUM10
explorer.exe shell:AppsFolder
PAUSE>NUL
and so on
GOTO MENU

:NUM11
%WinDir%\explorer.exe shell:::{865e5e76-ad83-4dca-A109-50dc2113ce9a}
PAUSE>NUL
and so on
GOTO MENU

:NUM12
%WinDir%\explorer.exe shell:::{9FE63AFD-59CF-4419-9775-ABCC3849F861}
PAUSE>NUL
and so on
GOTO MENU

:NUM13
explorer.exe shell:Roaming Tiles
PAUSE>NUL
and so on
GOTO MENU

:NUM14
explorer.exe shell:startup
PAUSE>NUL
and so on
GOTO MENU

:NUM15
%WinDir%\explorer.exe shell:::{645FF040-5081-101B-9F08-00AA002F954E}
PAUSE>NUL
and so on
GOTO MENU
