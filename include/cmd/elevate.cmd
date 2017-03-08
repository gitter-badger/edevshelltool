::::::::::::::::::::::::::::::::::::::::::::
:: Filename: elevate.cmd
:: Version: 4
:: Authors: 
:: References: http://stackoverflow.com/a/12264592
:: Updated: Yes (alex1a)
:: Description: Automatically check & get admin rights
::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: elevate.cmd
:: Include version: 0.0.2
:: Include description: automatically check & get admin rights
::::::::::::::::::::::::::::::::::::::::::::


@echo off
::CLS

:: Main Logic
:: Syntax: call elevate.cmd "[rootPath]" "[scriptRunPath]" "[title]"
:: %1 - rootPath
:: %2 - scriptRunPath
:: %3 - title
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"

if '%cmdInvoke%'=='1' goto InvokeCmd

ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
:: /B - When used in a batch script, this option will exit only the script (or subroutine) but not CMD.EXE
exit /B
::exit

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

:: START

:: Debug
:: Test if script here have permissions to write
::systeminfo >sysinfo_output.txt 2>sysinfo_error.txt

call %1include\cmd\shell.cmd "LOG" "%1" "Script (%batchName%.cmd) was successfully elevated"
call %1include\cmd\shell.cmd "LOG" "%1" "Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9"

:: Run
title %~3
call %1include\cmd\shell.cmd "LOG" "%1" "Starting Admin CMD - %2"
call %2 "%1"

cmd /k
