::::::::::::::::::::::::::::::::::::::::::::
:: Authors: alex1a, ljmf00
:: Description: Boostrap script for Windows systems.
::::::::::::::::::::::::::::::::::::::::::::

:: Pre-Initialization
@echo off
::@echo on
cls

:: Initialization
set /p BuildVersion=<%~dp0version.txt
set AppTitle="EDev Shell Tool v%BuildVersion%"
title %AppTitle%
:: Path Initialization
set LocalDir=%~dp0
:: /src
set LocalSourceDir=%~dp0src\
set LocalSourceCmdDir=%LocalSourceDir%cmd
set LocalSourceBashDir=%LocalSourceDir%bash
set LocalSourcePsDir=%LocalSourceDir%ps
:: /lib
set LocalLibraryDir=%~dp0lib\
set LocalLibraryCmdDir=%LocalLibraryDir%cmd
set LocalLibraryBashDir=%LocalLibraryDir%bash
set LocalLibraryPsDir=%LocalLibraryDir%ps
:: /include
set LocalIncludeDir=%~dp0include\
set LocalIncludeCmdDir=%LocalIncludeDir%cmd
set LocalIncludeBashDir=%LocalIncludeDir%bash
:: Includes Initialization
set IncludeCmdShell=%LocalIncludeCmdDir%\shell.cmd

:: Main Logic
set LogFilePath=%LocalDir%appLog.log
set RunCmdScript=%LocalSourceCmdDir%\run.cmd
call %IncludeCmdShell% "LOGFILE" "%LogFilePath%" "Initialization completed"
call %IncludeCmdShell% "ELEVATESCRIPT" "%RunCmdScript%" %AppTitle% "%LogFilePath%" "test arg 4 with spaces"

:: Debug Console Close
::exit /b
pause >nul