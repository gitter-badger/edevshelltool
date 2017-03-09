::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: elevate.cmd
:: Include version: 0.0.2
:: Include description: automatically check & get admin rights
::::::::::::::::::::::::::::::::::::::::::::

:: Pre-Initialization
@echo off
::@echo on
::cls

:: Log Initialization
set /a EnableLog=1
set "logFile=%~dp0%~n0_output.log"
set "errorFile=%~dp0%~n0_error.log"

:: Debug Batch Script
set /a EnableDebug=0
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( echo Path + Filename + Extension: %0 & echo.Path: %~dp0 & echo.Filename: (%~n0^^^) )
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch End & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( pause )

:: Debug Parameters
set /a EnableDebugParameters=1
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
:: Delayed Expansion will cause variables to be expanded at execution time rather than at parse time, this option is turned on with the SETLOCAL command.
:: When delayed expansion is in effect variables can be referenced using !variable_name! (in addition to the normal %variable_name% )
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
:: %0 - You can get the pathname of the batch script itself with %0
set "batchPath=%~0"
:: %%~n Expand %%k to a file Name without file extension C:\utils\MyFile or if only a path is present (with no trailing backslash\) - the last folder in that path.
:: batchName - this script filename without extension
for %%k in (%0) do set batchName=%%~nk
:: why batchName ??????????????????????????????????????????
::echo.Filename: %~n0
::echo.Filename: %batchName%
:: vbsGetPrivileges - full path for vbs script
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:: Main Logic
if '%1'=='ELEV' (
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Running Admin Elevate Shell Script 2nd Time >>%logFile% 2>>%errorFile% )
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Running Admin Elevate Shell Script 2nd Time )
	goto ELEVATE
) else (
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Running Admin Elevate Shell Script >>%logFile% 2>>%errorFile% )
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Running Admin Elevate Shell Script )
	goto %~1
)
echo ignored

:: label: ELEVATE
:ELEVATE
:checkPrivileges
:: Check Privileges (Display all the open shared files on a server and the lock-id)
:: and Redirect to NUL (hide errors): STDOUT (1) - Text output and STDERR (2) - Error text output
NET FILE 1>NUL 2>NUL
:: If errorlevel = 0 goto gotPrivileges
:: If errorlevel =/ 0 goto getPrivileges
if '%errorlevel%' == '0' (
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Privileges Granted >>%logFile% 2>>%errorFile% )
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Privileges Granted )
	goto gotPrivileges
) else (
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Privileges Not Granted >>%logFile% 2>>%errorFile% )
	if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Privileges Not Granted )
	goto getPrivileges
)
:getPrivileges
:: If 
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Invoking UAC for Privilege Escalation >>%logFile% 2>>%errorFile% )
if /i "%EnableLog%" EQU "1" ( echo %DATE%%TIME% - Invoking UAC for Privilege Escalation )
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
exit /b
:gotPrivileges
:: %~dp0 - Return the Drive and Path to the batch script.
setlocal & cd /d %~dp0
:: If %1 = ELEV, Delete vbsGetPrivileges and Shift (Change the position of command line arguments passed to a batch file (Start at the 1th argument))
:: If %0 = ELEV, continues
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:: Goto Elevated Starting Point
goto ElevatedStart

:: Elevated Starting Point
:ElevatedStart
call %~3
cmd /k
::cmd /k ""%~3" "%~2" "%~2""

:: Terminate Include Subroutine
:EXIT
:: Exit only the script (or subroutine) but not CMD.EXE
exit /b