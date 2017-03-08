::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: elevate.cmd
:: Include version: 0.0.2
:: Include description: automatically check & get admin rights
::::::::::::::::::::::::::::::::::::::::::::

:: Main Logic
@echo off
::@echo on
::cls
set /a EnableDebug=1
if /i "%EnableDebug%" EQU "1" echo --------- & echo.  Debug & echo.---------
if /i "%EnableDebug%" EQU "1" echo Script: %~n0.cmd & echo.
if /i "%EnableDebug%" EQU "1" echo P1=%1 & echo.P~1=%~1 & echo."P1"="%1" & echo."P~1"="%~1"
if /i "%EnableDebug%" EQU "1" echo P2=%2 & echo.P~2=%~2 & echo."P2"="%2" & echo."P~2"="%~2"
if /i "%EnableDebug%" EQU "1" echo P3=%3 & echo.P~3=%~3 & echo."P3"="%3" & echo."P~3"="%~3"
if /i "%EnableDebug%" EQU "1" echo P4=%4 & echo.P~4=%~4 & echo."P4"="%4" & echo."P~4"="%~4"
if /i "%EnableDebug%" EQU "1" echo P5=%5 & echo.P~5=%~5 & echo."P5"="%5" & echo."P~5"="%~5"
if /i "%EnableDebug%" EQU "1" echo P6=%6 & echo.P~6=%~6 & echo."P6"="%6" & echo."P~6"="%~6"
if /i "%EnableDebug%" EQU "1" echo P7=%7 & echo.P~7=%~7 & echo."P7"="%7" & echo."P~7"="%~7"
if /i "%EnableDebug%" EQU "1" echo P8=%8 & echo.P~8=%~8 & echo."P8"="%8" & echo."P~8"="%~8"
if /i "%EnableDebug%" EQU "1" echo P9=%9 & echo.P~9=%~9 & echo."P9"="%9" & echo."P~9"="%~9"
if /i "%EnableDebug%" EQU "1" echo --------- & echo.  Debug & echo.---------
if /i "%EnableDebug%" EQU "1" pause
::goto %~1
echo ignored
title %~4

:: label: ELEVATE
:ELEVATE
echo Running Admin shell
:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
:: %0 - You can get the pathname of the batch script itself with %0
set "batchPath=%~0"
:: %~n Expand %%k to a file Name without file extension C:\utils\MyFile or if only a path is present (with no trailing backslash\) - the last folder in that path.
:: batchName - this script filename without extension
for %%k in (%0) do set batchName=%%~nk
:: vbsGetPrivileges - full path for vbs script
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
:: Check Privileges (Display all the open shared files on a server and the lock-id)
:: and Redirect to NUL (hide errors): STDOUT (1) - Text output and STDERR (2) - Error text output
NET FILE 1>NUL 2>NUL
:: If errorlevel = 0 goto gotPrivileges
:: If errorlevel =/ 0 goto getPrivileges
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
:: ???????????????
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Invoking UAC for Privilege Escalation
:: Creating VBScript by file redirection.
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
:: If cmdInvoke = 1 goto InvokeCmd
:: If cmdInvoke =/ 1 continues 
if '%cmdInvoke%'=='1' goto InvokeCmd
:: Writing in VBScript the shell execution without invoking cmd
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
:: Avoid InvokeCmd
goto ExecElevation
:InvokeCmd
:: Writing in VBScript the shell execution with invoking cmd
echo args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"
:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
::"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %2 %3
exit /B
:gotPrivileges
:: %~dp0 - Return the Drive and Path to the batch script.
setlocal & cd /d %~dp0
:: ?????????????????????????????
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:: Elevated Starting Point
:: test
call %~3 "%~2"
cmd /k ""%~3" "%~2" "%~2""