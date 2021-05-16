# What Is ReVoice?

I noticed a lot that whenever my pc/monitors goes to sleep, it causes VoiceMeeter to crash. I assume this is to do with audio devices disconnecting when the monitor goes to sleep (i.e nVidia HD AUDIO from main monitor or my Corsair Virtuoso when it switches from wireless to cabled). Anyway, as I find it very annoying having to open taskmgr.exe and force shutdown and then manually reload it again, I created a simple batch script that semi-automates that process for you nice and quickly.

# How to use?

Simply download the bat file and place it somewhere convenient. Whenever VoiceMeeter crashes, just double click the bat. It will first check for UAC perms and then restart and prompt for them if needed. If you get prompted with errors saying the path could not be found, right click the bat file and open it with a text editor. Scroll to the bottom of the script where you should see this:

```batch
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
```

Edit the *%ProgramFiles(x86)%\VB\Voicemeeter\voicemeeter8.exe* path to the exe you use. If you aren't sure open taskmgr.exe and sort by name. There should only usually be one VoiceMeeter process running and it will be one of these processes:
* voicemeeter.exe
* voicemeeter8.exe
* voicemeeter8x64.exe
* voicemeeterpro.exe
