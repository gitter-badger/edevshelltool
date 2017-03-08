::::::::::::::::::::::::::::::::::::::::::::
:: Authors: alex1a, ljmf00
:: Description: Boostrap script for Windows systems.
::::::::::::::::::::::::::::::::::::::::::::

:: Initialization
@echo off
::@echo on
cls
set /p BuildVersion=<%~dp0version.txt
set AppTitle="EDev Shell Tool v%BuildVersion%"
title %AppTitle%
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

:: Elevate Permissions
call %LocalIncludeCmdDir%\shell.cmd "LOG" "%LocalDir%" "Initialization completed."
call %LocalIncludeCmdDir%\shell.cmd "LOG" "%LocalDir%" "Elevating CMD (%LocalSourceCmdDir%\run.cmd)..."
call %LocalIncludeCmdDir%\shell.cmd "ELEVATE" "%LocalDir%" "%LocalSourceCmdDir%\run.cmd" "%AppTitle%"

:: Terminate
::exit
pause >nul
