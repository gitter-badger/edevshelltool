@echo off
cls
echo IFEXIST
echo.
:: C:\MinGW\bin
set BaseDir=C:\MinGW\bin
echo %BaseDir%
if exist "%BaseDir%\c++.exe" (
	echo C++ OK
) else (
	echo C++ NO
)
if exist "%BaseDir%\gcc.exe" (
	echo GCC OK
) else (
	echo GCC NO
)
if exist "%BaseDir%\gdb.exe" (
	echo GDB OK
) else (
	echo GDB NO
)
if exist "%BaseDir%\make.exe" (
	echo MAKE OK
) else (
	echo MAKE NO
)
if exist "%BaseDir%\mingw32-c++.exe" (
	echo MINGW-C++ OK
) else (
	echo MINGW-C++ NO
)
if exist "%BaseDir%\mingw32-gcc.exe" (
	echo MINGW-GCC OK
) else (
	echo MINGW-GCC NO
)
if exist "%BaseDir%\mingw32-make.exe" (
	echo MINGW-MAKE OK
) else (
	echo MINGW-MAKE NO
)
echo.
:: C:\Program Files\mingw-w64\x86_64-6.3.0-posix-seh-rt_v5-rev1\mingw64\bin
set BaseDir=C:\Program Files\mingw-w64\x86_64-6.3.0-posix-seh-rt_v5-rev1\mingw64\bin
echo %BaseDir%
if exist "%BaseDir%\gcc.exe" (
	echo GCC OK
) else (
	echo GCC NO
)
if exist "%BaseDir%\gdb.exe" (
	echo GDB OK
) else (
	echo GDB NO
)
if exist "%BaseDir%\make.exe" (
	echo MAKE OK
) else (
	echo MAKE NO
)
if exist "%BaseDir%\c++.exe" (
	echo C++ OK
) else (
	echo C++ NO
)
echo.
:: C:\cygwin64\bin
set BaseDir=C:\cygwin64\bin
echo %BaseDir%
if exist "%BaseDir%\c++.exe" (
	echo C++ OK
) else (
	echo C++ NO
)
if exist "%BaseDir%\gcc.exe" (
	echo GCC OK
) else (
	echo GCC NO
)
if exist "%BaseDir%\gdb.exe" (
	echo GDB OK
) else (
	echo GDB NO
)
if exist "%BaseDir%\make.exe" (
	echo MAKE OK
) else (
	echo MAKE NO
)
echo.
:: C:\Qt\Qt5.8.0\5.8\mingw53_32\bin
set BaseDir=C:\Qt\Qt5.8.0\5.8\mingw53_32\bin
echo %BaseDir%
if exist "%BaseDir%\qmake.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
echo.
:: C:\msys64\usr\bin
set BaseDir=C:\msys64\usr\bin
echo %BaseDir%
if exist "%BaseDir%\bash.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
echo.
:: C:\Program Files\Git
set BaseDir=C:\Program Files\Git
echo %BaseDir%
if exist "%BaseDir%\cmd\git.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
if exist "%BaseDir%\usr\bin\grep.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
echo.
:: C:\Program Files (x86)\PuTTY
set BaseDir=C:\Program Files (x86)\PuTTY
echo %BaseDir%
if exist "%BaseDir%\putty.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
echo.
:: C:\Program Files\ConEmu
set BaseDir=C:\Program Files\ConEmu
echo %BaseDir%
if exist "%BaseDir%\ConEmu64.exe" (
	echo OKOKOK
) else (
	echo NONONO
)
pause
echo.
echo WHERE
echo.
where.exe where.exe 1>NUL 2>NUL
if %errorlevel% NEQ 0 (
	echo NO where.exe
) else (
	echo OK where.exe
)
where.exe ptara.exe 1>NUL 2>NUL
if %errorlevel% NEQ 0 (
	echo NO ptara.exe
) else (
	echo OK ptara.exe
)
pause
echo.
echo System
echo.
:: C:\Windows\System32\wbem
where.exe WMIC
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe WinMgmt
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Windows\System32\WindowsPowerShell\v1.0
where.exe powershell
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Windows
where.exe explorer
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe notepad
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe regedit
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Windows\System32
where.exe cmd
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe regedit
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe
where.exe WebpiCmd-x64
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
pause
echo.
echo Shell
echo.
:: C:\Program Files\Git\cmd\git.exe
:: C:\Program Files\Git\usr\bin\grep.exe
where.exe git
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe grep
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\msys64\usr\bin
where.exe bash
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\ProgramData\chocolatey\bin\choco.exe
:: C:\ProgramData\chocolatey\bin\chocolatey.exe
where.exe choco
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\MinGW\bin
:: C:\Program Files\mingw-w64\x86_64-6.3.0-posix-seh-rt_v5-rev1\mingw64\bin
:: C:\cygwin64\bin
where.exe gcc
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe gdb
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe c++
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Program Files (x86)\PuTTY\putty.exe
:: C:\Program Files (x86)\PuTTY\puttygen.exe
:: C:\Program Files (x86)\PuTTY\plink.exe
where.exe putty
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe puttygen
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe plink
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
pause
echo.
echo Apps
echo.
:: C:\Program Files\nodejs\node.exe
where.exe node
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\php\php.exe
where.exe php
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Users\batat\AppData\Local\Android\sdk\platform-tools\adb.exe
:: C:\Users\batat\AppData\Local\Android\sdk\platform-tools\fastboot.exe
where.exe adb
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe fastboot
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Program Files\Java\jdk1.8.0_102\bin\java.exe
where.exe java
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\tools\ruby23\bin
where.exe ruby
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\HashiCorp\Vagrant\bin;
where.exe vagrant
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Program Files (x86)\Calibre2
where.exe calibre
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Program Files\Oracle\VirtualBox
where.exe VirtualBox
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Users\batat\AppData\Local\.meteor\
:: ??????? bat
where.exe meteor
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: C:\Users\batat\AppData\Local\atom\bin
where.exe atom
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
where.exe apm
if %errorlevel% NEQ 0 (
	echo NONONO
) else (
	echo OKOKOK
)
:: ficheiro cmd que le um texto com lista de exes e retorna o output se existirem
pause
exit /b