
:: Debug
::echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9

where bash
where cmd
where powershell
where bitsadmin.exe
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%LocalDir%lib\ps\elevate.ps1""' -Verb RunAs}";