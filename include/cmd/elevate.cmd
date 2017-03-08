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
if /i "%EnableDebug%" EQU "1" echo P1=%1 & echo.P2=%2 & echo.P3=%3 & echo.P4=%4 & echo.P5=%5 & echo.P6=%6 & echo.P7=%7 & echo.P8=%8 & echo.P9=%9
if /i "%EnableDebug%" EQU "1" echo P~1=%~1 & echo.P~2=%~2 & echo.P~3=%~3 & echo.P~4=%~4 & echo.P~5=%~5 & echo.P~6=%~6 & echo.P~7=%~7 & echo.P~8=%~8 & echo.P~9=%~9
if /i "%EnableDebug%" EQU "1" echo %~n0.cmd
if /i "%EnableDebug%" EQU "1" pause
goto %~1
echo ignored
title %~4

:: label: ELEVATE
:ELEVATE
echo Running Admin shell
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
echo Invoking UAC for Privilege Escalation
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
if '%cmdInvoke%'=='1' goto InvokeCmd
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation
:InvokeCmd
echo args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"
:ExecElevation
::"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" ""%2" "%3""
exit /B
:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:: Elevated Starting Point
:: test
::if /i "%EnableDebug%" EQU "1" systeminfo >sysinfo_output.txt 2>sysinfo_error.txt
call %~3 "%~2"
cmd /k ""%~3" "%~2" "%~2""