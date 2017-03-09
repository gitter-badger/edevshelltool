::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: elevate.cmd
:: Include version: 0.0.2
:: Include description: automatically check & get admin rights
::::::::::::::::::::::::::::::::::::::::::::

:: Main Logic
@echo off
::@echo on
::cls

echo Running Admin shell
:init
:: Delayed Expansion will cause variables to be expanded at execution time rather than at parse time, this option is turned on with the SETLOCAL command.
:: When delayed expansion is in effect variables can be referenced using !variable_name! (in addition to the normal %variable_name% )
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
:: If 
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
:: If %1 = ELEV, Delete vbsGetPrivileges and Shift (Change the position of command line arguments passed to a batch file (Start at the 1th argument))
:: If %0 = ELEV, continues
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:: >>>Elevated Starting Point
cmd /k
::call %~3 "%~2"
::cmd /k ""%~3" "%~2" "%~2""