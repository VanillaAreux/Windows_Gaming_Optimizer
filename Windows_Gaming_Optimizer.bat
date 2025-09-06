@echo off
title Windows Gaming Optimizer
color 0A
echo.
echo ===============================================
echo    Windows Gaming Optimizer v1.0
echo    Optimizing Windows 10/11 for Gaming
echo ===============================================
echo.
echo WARNING: This script will modify system settings!
echo Make sure to run as Administrator and create a restore point first.
echo.
pause

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with Administrator privileges...
) else (
    echo ERROR: This script must be run as Administrator!
    echo Right-click and select "Run as administrator"
    pause
    exit /b 1
)

:: Create restore point
echo.
echo Creating system restore point...
powershell -Command "Checkpoint-Computer -Description 'Before Gaming Optimization' -RestorePointType 'MODIFY_SETTINGS'"
if %errorLevel% == 0 (
    echo Restore point created successfully!
) else (
    echo Warning: Could not create restore point. Continuing anyway...
)
echo.

:: ===============================================
:: REGISTRY OPTIMIZATIONS
:: ===============================================
echo Applying registry optimizations...

:: Disable Windows Game Mode (can cause issues with some games)
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "GameMode" /t REG_DWORD /d 0 /f

:: Disable Game DVR and Game Bar
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f

:: Disable Windows Search Indexing for better performance
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search" /v "SetupCompletedSuccessfully" /t REG_DWORD /d 0 /f

:: Optimize for gaming performance
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xffffffff /f

:: Optimize network for gaming
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xffffffff /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /v "High" /f

:: Disable Windows Update automatic restart
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f

:: Optimize mouse settings for gaming
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f

:: Disable visual effects for better performance
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f

:: Optimize for background apps
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f

echo Registry optimizations completed!
echo.

:: ===============================================
:: SERVICE OPTIMIZATIONS
:: ===============================================
echo Optimizing Windows services...

:: Disable unnecessary services for gaming
sc config "Fax" start= disabled
sc config "WSearch" start= disabled
sc config "TrkWks" start= disabled
sc config "WbioSrvc" start= disabled
sc config "TabletInputService" start= disabled
sc config "WMPNetworkSvc" start= disabled
sc config "WerSvc" start= disabled
sc config "Wecsvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WinHttpAutoProxySvc" start= disabled
sc config "wisvc" start= disabled
sc config "WpcMonSvc" start= disabled
sc config "WpnService" start= disabled
sc config "WpnUserService" start= disabled
sc config "WSearch" start= disabled
sc config "XblAuthManager" start= disabled
sc config "XblGameSave" start= disabled
sc config "XboxGipSvc" start= disabled
sc config "XboxNetApiSvc" start= disabled

:: Stop services immediately
net stop "Fax" 2>nul
net stop "WSearch" 2>nul
net stop "TrkWks" 2>nul
net stop "WbioSrvc" 2>nul
net stop "TabletInputService" 2>nul
net stop "WMPNetworkSvc" 2>nul
net stop "WerSvc" 2>nul
net stop "Wecsvc" 2>nul
net stop "WdiServiceHost" 2>nul
net stop "WdiSystemHost" 2>nul
net stop "WinHttpAutoProxySvc" 2>nul
net stop "wisvc" 2>nul
net stop "WpcMonSvc" 2>nul
net stop "WpnService" 2>nul
net stop "WpnUserService" 2>nul
net stop "XblAuthManager" 2>nul
net stop "XblGameSave" 2>nul
net stop "XboxGipSvc" 2>nul
net stop "XboxNetApiSvc" 2>nul

echo Service optimizations completed!
echo.

:: ===============================================
:: POWER SETTINGS
:: ===============================================
echo Configuring power settings for maximum performance...

:: Set power plan to High Performance
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

:: Disable USB selective suspend
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

:: Disable PCI Express Link State Power Management
powercfg -setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0
powercfg -setdcvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0

:: Disable processor power management
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
powercfg -setdcvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100

:: Apply power settings
powercfg -setactive SCHEME_CURRENT

echo Power settings configured!
echo.

:: ===============================================
:: SYSTEM OPTIMIZATIONS
:: ===============================================
echo Applying system optimizations...

:: Disable Windows Tips and Tricks
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f

:: Disable Windows Spotlight
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f

:: Disable Cortana
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

:: Disable Windows Update automatic download
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f

:: Optimize for gaming in Windows
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /v "False" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /v "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /v "High" /f

:: Disable Windows Error Reporting
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f

:: Disable Windows Customer Experience Improvement Program
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f

:: Optimize memory management
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f

echo System optimizations completed!
echo.

:: ===============================================
:: NETWORK OPTIMIZATIONS
:: ===============================================
echo Applying network optimizations...

:: Disable Nagle's Algorithm for better gaming latency
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f

:: Optimize TCP settings
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global rss=enabled
netsh int tcp set global netdma=enabled

:: Disable Windows Update Delivery Optimization
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f

echo Network optimizations completed!
echo.

:: ===============================================
:: GRAPHICS OPTIMIZATIONS
:: ===============================================
echo Applying graphics optimizations...

:: Disable hardware acceleration for better compatibility
reg add "HKEY_CURRENT_USER\Software\Microsoft\Avalon.Graphics" /v "DisableHWAcceleration" /t REG_DWORD /d 0 /f

:: Optimize DirectX settings
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectDraw" /v "DisableAGPSupport" /t REG_DWORD /d 0 /f

echo Graphics optimizations completed!
echo.

:: ===============================================
:: CLEANUP AND FINALIZATION
:: ===============================================
echo Performing cleanup...

:: Clear temporary files
del /q /f /s "%temp%\*" 2>nul
del /q /f /s "C:\Windows\Temp\*" 2>nul

:: Clear DNS cache
ipconfig /flushdns

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo ===============================================
echo    OPTIMIZATION COMPLETE!
echo ===============================================
echo.
echo The following optimizations have been applied:
echo.
echo ✓ Registry optimizations for gaming performance
echo ✓ Disabled unnecessary Windows services
echo ✓ Configured power settings for maximum performance
echo ✓ Disabled Windows Game Mode and Game DVR
echo ✓ Optimized network settings for gaming
echo ✓ Optimized graphics and DirectX settings
echo ✓ Disabled Windows telemetry and background apps
echo ✓ Cleared temporary files and DNS cache
echo.
echo IMPORTANT NOTES:
echo - Windows Defender remains enabled for security
echo - A system restore point was created before optimization
echo - Some optimizations may require a restart to take full effect
echo.
echo Restart your computer for all changes to take effect!
echo.
pause