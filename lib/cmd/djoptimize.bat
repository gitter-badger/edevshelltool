::::::::::::::::::::::::::::::::::::::::::::
:: Filename: djoptimize.bat
:: Version: -
:: Authors: https://github.com/seankmchenry
:: References: https://github.com/seankmchenry/dj-optimize/blob/master/dj-optimize.bat
:: Updated: No
:: Description: DJ Optimizer
::::::::::::::::::::::::::::::::::::::::::::

@echo off

rem Set environment variable for TEMP path
set USERTEMP=C:\TEMP

rem Delete old log file if it exists
del /F C:\TEMP\dj-optimize-log.txt

rem Stopping and disable Automatic Update service
net stop wuauserv /yes 2> %USERTEMP%\dj-optimize-log.txt
sc config wuauserv start= disabled 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping avast! Antivirus
net stop "avast! Antivirus" 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping Wireless Zero Configuration service
net stop WZCSVC 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping Print Spooler service
net stop Spooler 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping ATI Hotkey Poller service
net stop "Ati HotKey Poller" 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping Windows Firewall/ICS service
net stop SharedAccess 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping browser executables
taskkill /im chrome.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /im firefox.exe 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping development tools
taskkill /f /im httpd.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im mysqld.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im sublime_text.exe 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping web services
taskkill /f /im BoxSync.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im BoxSyncHelper.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im spotify.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im SpotifyWebHelper.exe 2> %USERTEMP%\dj-optimize-log.txt

rem Stopping miscellaneous programs
taskkill /f /im "Everything-*" 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im peerblock.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im procexp.exe 2> %USERTEMP%\dj-optimize-log.txt
taskkill /f /im SoulseekQt.exe 2> %USERTEMP%\dj-optimize-log.txt

rem Remove environment variable
set USERTEMP=

echo.
echo DJ optimizations are complete.
echo.

pause