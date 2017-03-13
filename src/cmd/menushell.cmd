@echo off
cls

:MENU
cls
ECHO ================= SIMPLE MENU =================
ECHO      PRESS 1-2 to your task, or 3 to EXIT.
ECHO ===============================================
echo 1 -
echo 2 -
echo 3 - EXIT
ECHO ===============================================
SET INPUT=
SET /P INPUT=Type 1-3 then press ENTER:
IF /I '%INPUT%'=='1' GOTO NUM1
IF /I '%INPUT%'=='2' GOTO NUM2
IF /I '%INPUT%'=='3' GOTO QUIT
CLS
ECHO ============INVALID INPUT============
ECHO Please select a number from the Main
ECHO Menu [1-2] or select '3' to quit.
ECHO  ======PRESS ANY KEY TO CONTINUE======
PAUSE > NUL
GOTO MENU

:QUIT
CLS
ECHO ==============THANKYOU===============
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======
PAUSE>NUL
EXIT

:NUM1
PAUSE>NUL
and so on
GOTO MENU

:NUM2
PAUSE>NUL
and so on
GOTO MENU
