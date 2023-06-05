@echo off

@REM First, check if argument was provided
if "%~1"=="" (
    echo Error: No argument provided.
    exit /b 1
)

@REM Help function
if "%~1"=="/?" (
    echo "su.cmd & Emulate-Sudo: Sudo for Windows"
    echo "_______________________________________"
    echo "Allows you to run a single command as Administrator without starting a new command prompt."
    echo "Usage: su.cmd 'Get-Date' - runs given Powershell command as Administrator and returns output. Quotes required."
    echo "For anything that won't run in Powershell: su.cmd 'chkdsk' - Runs command with CMD.EXE as admin."
    echo " "
    echo "Arguments: /? - This help menu"
    echo " 'commandhere' - Run this command with Powershell as admin, and CMD if that fails."
)

rem Check if an argument was provided
if "%~1"=="" (
    echo Error: No argument provided.
    exit /b 1
) 

rem Running with Powershell as Admin with argument: %1
powershell -Command "Start-Process powershell.exe -ArgumentList '-Command \"%*\"' -Verb RunAs"

rem if it returns an error, will try again using: runas /user:Administrator (COMMAND_FROM_CLI_ARG); will run CMD %~1 as Administrator
if %errorlevel%" -gtr 0 (
    runas /user:Administrator "%~1"
) else (exit)

rem If neither handlers trigger, return an error. it's an unhandled edge case. Check su.cmd.errorlog.txt in C:\Windows for a record of the error.
set currentTime=%TIME%

rem Sends errors to c:\Windows\su.cmd.errorlog.txt
echo "ERROR: Unable to detect PowerShell or batch script environment; command %~1 failed"
echo "ERROR: Command %~1 failed. Current system time: %currentTime%" >> sucmd-errorlog.txt"
cmd.exe /c "notepad.exe %TEMP%\sucmd-errorlog.txt"

exit /b 1