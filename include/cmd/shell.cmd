::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: shell.cmd
:: Include version: 0.0.2
:: Include description: a simple include cmd script that can do shell things.
::::::::::::::::::::::::::::::::::::::::::::

@echo off
::@echo on
::cls

:: Debug (Turn On/Off)
::echo (%~n0.cmd) P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9 >>%~2appLog.txt 2>>%~2errorLog.txt

:: Function: Main
:: Syntax: shell.cmd "[label]" ...
:: %~1 - label
::echo %DATE%%TIME% (%~n0.cmd) GOTO %~1 >>%~2appLog.txt 2>>%~2errorLog.txt
goto %~1
echo ignored

:: Function: LOG
:: Syntax: call shell.cmd "LOG" "[rootPath]" "[stringToLog]"
:: %~2 - rootPath
:: %~3 - stringToLog
:LOG
echo %DATE%%TIME% - %~3 >>%~2appLog.txt 2>>%~2errorLog.txt
echo %DATE%%TIME% - %~3
goto EXIT

:: Function: ELEVATE
:: Syntax: call shell.cmd "ELEVATE" "[rootPath]" "[scriptRunPath]" "[title]"
:: %~2 - rootPath
:: %~3 - scriptRunPath
:: %~4 - title
:ELEVATE
:: Start /c or /k
set ElevateCmdScriptPath=%~2include\cmd\elevate.cmd
call %ElevateCmdScriptPath% %~2 %~3 %~4 "test arg4"
goto EXIT

:: Function: EXIT
:EXIT
exit /b
