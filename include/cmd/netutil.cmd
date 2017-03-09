::::::::::::::::::::::::::::::::::::::::::::
:: filename: util.cmd
:: version: 0.0.1
:: Authors: alex1a
:: References: -
:: Updated: No
:: description: windows cmd utils.
::::::::::::::::::::::::::::::::::::::::::::

@echo off
::@echo on
::cls

:: Debug (Turn On/Off)
::echo (%~n0.cmd) P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9

:: Function: Main
:: Syntax: util.cmd "[label]" ...
:: %~1 - label
goto %~1
echo ignored

:: Function: DownloadFile
:: Syntax: call util.cmd "DOWNFILE" "[rootPath]" "[urlPath]" "[destinationPath]"
:: %~2 - rootPath
:DOWNFILE
bitsadmin.exe /transfer "TestFirst" https://raw.githubusercontent.com/alex1a/dotfiles/master/hardware.md C:\hardware.md
:: With PowerShell 2.0 (Windows 7 preinstalled) you can use:
::(New-Object Net.WebClient).DownloadFile('http://www.foo.com/package.zip', 'package.zip')
:: Starting with PowerShell 3.0 (Windows 8 preinstalled) you can use Invoke-WebRequest:
::Invoke-WebRequest http://www.foo.com/package.zip -OutFile package.zip
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.foo.com/package.zip', 'package.zip')"
powershell -Command "Invoke-WebRequest http://www.foo.com/package.zip -OutFile package.zip"