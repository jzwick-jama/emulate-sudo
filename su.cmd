@echo off

@REM First, check if argument was provided
if "%~1"=="" (
    echo Error: No argument provided.
    exit /b 1
)

@REM Help function
if "%~1"=="/?" (
    echo "su.cmd & Sudo.cmd: Sudo for Windows"
    echo "_______________________________________"
    echo "Allows you to easily open a powershell session as Admin at any time from the command line. "
)

rem Check if an argument was provided
if "%~1"=="" (
    echo Error: No argument provided.
    exit /b 1
) 

rem Starting Powershell as Admin in new terminal 
powershell.exe -Command "Start-Process powershell.exe -Verb RunAs"

rem If it fails to start, write an error to errorlog.txt in %%TEMP%\error.log for a record of the error.
set currentTime=%TIME%
rem Sends time and error to errorlog.txt
echo "ERROR: Unable to start PowerShell as Administrator. Failed."
echo "ERROR: Unable to start PowerShell as Administrator, failed. Current system time: %currentTime%" >> sucmd-errorlog.txt"
cmd.exe /c "notepad.exe %TEMP%\error.log"

exit /b 1