:: Setting UAC launch
@ECHO OFF
REM Checking for admin rights.
>NUL 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM Throws error if no admin rights.
IF '%errorlevel%' NEQ '0' (
    ECHO Requesting administrative privileges...
    GOTO UACPrompt
) ELSE ( 
    GOTO gotAdmin 
)

:UACPrompt
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    SET params = %*:"=""
    ECHO UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    DEL "%temp%\getadmin.vbs"
    EXIT /B

:gotAdmin
    PUSHD "%CD%"
    CD /D "%~dp0"
COLOR A
CLS

ECHO Killing VoiceMeeter process
SET "images=voicemeeter.exe,voicemeeter8.exe,voicemeeter8x64.exe,voicemeeterpro.exe"
FOR %%i IN (%images%) DO (
   FOR /F "tokens=2 delims=," %%a IN ('TASKLIST /FI "imagename eq %%i" /V /FO:csv /NH ^| FINDSTR /R "voice"') DO TASKKILL /F /PID %%a
)


IF NOT EXIST "%ProgramFiles(x86)%\VB\" (
    ECHO Cannot find VoiceMeeter directory.
    ECHO Make sure the path is correct in the bat file
    ECHO and check folder actually exists on computer.
    ECHO Press any key to exit.
    PAUSE >NUL
    EXIT
) ELSE (
    GOTO startVoice
)

:: Replace the exe bellow with the one that
:: corrisponds to the version you use.
:: Also make sure system path is correct.
REM Example versions: voicemeeter.exe, voicemeeter8.exe, voicemeeter8x64.exe, voicemeeterpro.exe
:startVoice
START "VoiceMeeter" /MAX "%ProgramFiles(x86)%\VB\Voicemeeter\voicemeeter8.exe"
IF %errorlevel% EQU 9059 (
    ECHO The program failed to start, please check privileges and if file exists and restart
    PAUSE >nul
) ELSE (
    ECHO VoiceMeeter restarted successfully!
    TIMEOUT /T 2
    EXIT
)
