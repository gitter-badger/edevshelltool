::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: shell.cmd
:: Include version: 0.0.2
:: Include description: a simple include cmd script that can do shell things.
::::::::::::::::::::::::::::::::::::::::::::

:: Pre-Initialization
@echo off
::@echo on
::cls

:: Debug Batch Script
set /a EnableDebug=0
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( echo Path + Filename + Extension: %0 & echo.Path: %~dp0 & echo.Filename: (%~n0^^^) )
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch End & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( pause )

:: Debug Parameters
set /a EnableDebugParameters=0
if /i "%EnableDebugParameters%" EQU "1" ( echo --------- & echo.  Debug Parameters & echo.--------- )
if /i "%EnableDebugParameters%" EQU "1" ( echo P1=%1 & echo.P~1=%~1 & echo."P1"="%1" & echo."P~1"="%~1" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P2=%2 & echo.P~2=%~2 & echo."P2"="%2" & echo."P~2"="%~2" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P3=%3 & echo.P~3=%~3 & echo."P3"="%3" & echo."P~3"="%~3" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P4=%4 & echo.P~4=%~4 & echo."P4"="%4" & echo."P~4"="%~4" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P5=%5 & echo.P~5=%~5 & echo."P5"="%5" & echo."P~5"="%~5" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P6=%6 & echo.P~6=%~6 & echo."P6"="%6" & echo."P~6"="%~6" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P7=%7 & echo.P~7=%~7 & echo."P7"="%7" & echo."P~7"="%~7" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P8=%8 & echo.P~8=%~8 & echo."P8"="%8" & echo."P~8"="%~8" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P9=%9 & echo.P~9=%~9 & echo."P9"="%9" & echo."P~9"="%~9" )
if /i "%EnableDebugParameters%" EQU "1" ( echo --------- & echo.  Debug Parameters End & echo.--------- )
if /i "%EnableDebugParameters%" EQU "1" ( pause )

:: Initialization
for %%k in (%0) do set batchName=%%~nk

:: Main Logic
if '%1'=='ELEV' (
	goto ELEVATESCRIPT
) else (
	goto %~1
)
echo.ignored

:: label: LOGFILE
:LOGFILE
if exist %~2 (
    echo %DATE%%TIME% - %~3 >>%~2
) else (
    echo %DATE%%TIME% - %~3 >%~2
)
echo %DATE%%TIME% - %~3
goto exitOk

:: label: ELEVATESCRIPT
:ELEVATESCRIPT
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
if not exist %~4 ( echo. >%~4 )
if '%1'=='ELEV' (
	echo %DATE%%TIME% - Running Admin Elevate Shell Script 2nd Time >>%~4
	echo %DATE%%TIME% - Running Admin Elevate Shell Script 2nd Time
) else (
	echo %DATE%%TIME% - Running Admin Elevate Shell Script >>%~4
	echo %DATE%%TIME% - Running Admin Elevate Shell Script
)
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (
	echo %DATE%%TIME% - Privileges Granted >>%~4
	echo %DATE%%TIME% - Privileges Granted
	goto gotPrivileges
) else (
	echo %DATE%%TIME% - Privileges Not Granted >>%~4
	echo %DATE%%TIME% - Privileges Not Granted
	goto getPrivileges
)
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo %DATE%%TIME% - Invoking UAC for Privilege Escalation >>%~4
echo %DATE%%TIME% - Invoking UAC for Privilege Escalation
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
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %~2 %~4 %~4
::exit /b
:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
goto ElevatedStart
:ElevatedStart
call %~2
::call %~3
cmd /k
goto exitOk

:: Terminate Include Subroutine
:exitOk
:: Exit only the script (or subroutine) but not CMD.EXE
exit /b