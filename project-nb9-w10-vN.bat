@echo off
title Project NB9 - Windows 10 vN (Notebook)
color 0A
chcp 65001 >nul

echo.
echo  +==========================================+
echo  |     Project NB9 - Win10 vN (Notebook)   |
echo  |         Run as Administrator!           |
echo  +==========================================+
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] Please Run as Administrator!
    pause
    exit
)

echo  Optimizing... Please wait...
echo  ------------------------------------------------
echo.

:: 1. Power Plan
echo  [1/25] Power Plan - High Performance (Plugged In)...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -change -standby-timeout-ac 0 >nul 2>&1
powercfg -change -hibernate-timeout-ac 0 >nul 2>&1
powercfg -change -standby-timeout-dc 5 >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1
echo        Done!

:: 2. Visual Effects
echo  [2/25] Visual Effects - Best Performance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
echo        Done!

:: 3. Xbox Game Bar
echo  [3/25] Disable Xbox Game Bar and Game DVR...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
echo        Done!

:: 4. Background Apps
echo  [4/25] Disable Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>&1
echo        Done!

:: 5. Cortana
echo  [5/25] Disable Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
echo        Done!

:: 6. Adaptive Brightness
echo  [6/25] Disable Adaptive Brightness...
powercfg -setacvalueindex SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 0 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 0 >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1
echo        Done!

:: 7. Battery Saver
echo  [7/25] Disable Auto Battery Saver...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v BatterySaverActivationThreshold /t REG_DWORD /d 0 /f >nul 2>&1
echo        Done!

:: 8. USB Power Saving
echo  [8/25] Disable USB Power Saving...
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1
echo        Done!

:: 9. HPET
echo  [9/25] Disable HPET Dynamic Tick...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TimerResolution" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
echo        Done!

:: 10. Discord
echo  [10/25] Disable Discord Hardware Acceleration...
set DISCORD_SETTINGS=%APPDATA%\discord\settings.json
if exist "%DISCORD_SETTINGS%" (
    powershell -Command "(Get-Content '%DISCORD_SETTINGS%') -replace '\"enableHardwareAcceleration\": true','\"enableHardwareAcceleration\": false' | Set-Content '%DISCORD_SETTINGS%'" >nul 2>&1
)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Discord /f >nul 2>&1
echo        Done!

:: 11. Registry Tweaks
echo  [11/25] Registry Tweaks...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f >nul 2>&1
echo        Done!

:: 12. Nagle Algorithm
echo  [12/25] Disable Nagle Algorithm...
powershell -Command "$ifPath='HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces'; $activeIP=(Get-NetIPAddress -AddressFamily IPv4|Where-Object{$_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1'}|Select-Object -First 1).IPAddress; Get-ChildItem $ifPath|ForEach-Object{$props=Get-ItemProperty $_.PSPath; if($props.DhcpIPAddress -eq $activeIP -or ($props.IPAddress -and $props.IPAddress -contains $activeIP)){Set-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -Value 1 -Type DWord -Force; Set-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -Value 1 -Type DWord -Force}}"
echo        Done!

:: 13. Memory Compression
echo  [13/25] Disable Memory Compression...
powershell -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1
echo        Done!

:: 14. SysMain
echo  [14/25] Disable SysMain...
sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
echo        Done!

:: 15. Paging File ?????????
echo  [15/25] Set Paging File Auto...
powershell -Command "$cs=Get-WmiObject Win32_ComputerSystem; $cs.AutomaticManagedPagefile=$true; $cs.Put()" >nul 2>&1
echo        Done!

:: 16. Process Priority + Fullscreen
echo  [16/25] FiveM Priority and Fullscreen Optimizations...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 3 /f >nul 2>&1
set FIVEM_EXE=%LOCALAPPDATA%\FiveM\FiveM.exe
if exist "%FIVEM_EXE%" (
    reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%FIVEM_EXE%" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f >nul 2>&1
)
echo        Done!

:: 17. Windows Services
echo  [17/25] Disable Unnecessary Windows Services...
sc stop "PrintSpooler" >nul 2>&1 & sc config "PrintSpooler" start=disabled >nul 2>&1
sc stop "Fax" >nul 2>&1 & sc config "Fax" start=disabled >nul 2>&1
sc stop "RemoteRegistry" >nul 2>&1 & sc config "RemoteRegistry" start=disabled >nul 2>&1
sc stop "WSearch" >nul 2>&1 & sc config "WSearch" start=disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1 & sc config "DiagTrack" start=disabled >nul 2>&1
sc stop "dmwappushservice" >nul 2>&1 & sc config "dmwappushservice" start=disabled >nul 2>&1
sc stop "MapsBroker" >nul 2>&1 & sc config "MapsBroker" start=disabled >nul 2>&1
sc stop "TabletInputService" >nul 2>&1 & sc config "TabletInputService" start=disabled >nul 2>&1
echo        Done!

:: 18. Startup Programs
echo  [18/25] Remove Unnecessary Startup Programs...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "EpicGamesLauncher" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Steam" /f >nul 2>&1
echo        Done!

:: 19. DNS - Cloudflare
echo  [19/25] Set DNS to Cloudflare...
powershell -Command "Get-NetAdapter -Physical|Where-Object{$_.Status -eq 'Up'}|ForEach-Object{Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses ('1.1.1.1','1.0.0.1')}" >nul 2>&1
ipconfig /flushdns >nul 2>&1
echo        Done!

:: 20. MTU Optimization
echo  [20/25] Set MTU...
powershell -Command "Get-NetAdapter -Physical|Where-Object{$_.Status -eq 'Up'}|ForEach-Object{Set-NetIPInterface -InterfaceIndex $_.ifIndex -NlMtuBytes 1500 -ErrorAction SilentlyContinue}" >nul 2>&1
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global chimney=disabled >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1
netsh interface tcp set global netdma=disabled >nul 2>&1
echo        Done!

:: 21. GPU Scheduling
echo  [21/25] Enable Hardware Accelerated GPU Scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
echo        Done!

:: 22. ??? Telemetry
echo  [22/25] Disable Windows Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo        Done!

:: 23. CPU Scheduler
echo  [23/25] Optimize CPU Scheduler...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f >nul 2>&1
echo        Done!

:: 24. FiveM Config - ???????????? Notebook
echo  [24/25] Optimize FiveM Config (Notebook Mode)...
set VIDEOCFG=%LOCALAPPDATA%\FiveM\FiveM.app\citizen\cfg\videocard.cfg
if exist "%VIDEOCFG%" (
    powershell -Command "(Get-Content '%VIDEOCFG%') -replace 'smaaQuality \d+','smaaQuality 0' -replace 'msaaSamples \d+','msaaSamples 0' -replace 'fxaaEnabled \d+','fxaaEnabled 0' -replace 'motionblur \d+','motionblur 0' -replace 'extendedDistance \d+','extendedDistance 0' -replace 'extendedTextureBudget \d+','extendedTextureBudget 0' | Set-Content '%VIDEOCFG%'" >nul 2>&1
)
set GTACFG=%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml
if exist "%GTACFG%" (
    powershell -Command "(Get-Content '%GTACFG%') -replace 'VSync=""true""','VSync=""false""' -replace 'ShadowQuality value=""\d+""','ShadowQuality value=""0""' -replace 'GrassQuality value=""\d+""','GrassQuality value=""0""' -replace 'ReflectionQuality value=""\d+""','ReflectionQuality value=""0""' -replace 'ParticleQuality value=""\d+""','ParticleQuality value=""0""' | Set-Content '%GTACFG%'" >nul 2>&1
)
set CITIZENCFG=%APPDATA%\CitizenFX\CitizenFX.ini
if not exist "%APPDATA%\CitizenFX" mkdir "%APPDATA%\CitizenFX" >nul 2>&1
if not exist "%CITIZENCFG%" (
    echo [Game] > "%CITIZENCFG%"
    echo SkipBenchmark=true >> "%CITIZENCFG%"
    echo DisableNVSP=true >> "%CITIZENCFG%"
)
echo        Done!

:: 25. Network Adapter
echo  [25/25] Network Adapter Settings...
powershell -Command "Get-NetAdapter -Physical|Where-Object{$_.Status -eq 'Up'}|ForEach-Object{$n=$_.Name; Set-NetAdapterAdvancedProperty -Name $n -DisplayName 'Energy Efficient Ethernet' -DisplayValue 'Disabled' -ErrorAction SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -DisplayName 'Interrupt Moderation' -DisplayValue 'Disabled' -ErrorAction SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -DisplayName 'Receive Buffers' -DisplayValue '512' -ErrorAction SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -DisplayName 'Transmit Buffers' -DisplayValue '512' -ErrorAction SilentlyContinue}"
echo        Done!

echo.
echo  ------------------------------------------------
echo  ? Win10 vN (Notebook) Done!
echo  ! Always plug in charger when gaming
echo  - Polling Rate  : Adjust in mouse software
echo  - FiveM In-Game : Check Graphics settings
echo  - BIOS          : Enable XMP/EXPO for RAM
echo  ------------------------------------------------
echo.
pause
shutdown /r /t 5 /c "Restarting for Project NB9 vN..."
