@echo off
title Windows Gaming Optimizer - Restore Script
color 0C
echo.
echo ===============================================
echo    Windows Gaming Optimizer - RESTORE
echo    Reverting Gaming Optimizations
echo ===============================================
echo.
echo WARNING: This script will revert gaming optimizations!
echo Make sure to run as Administrator.
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
echo Creating system restore point before reverting changes...
powershell -Command "Checkpoint-Computer -Description 'Before Restoring Gaming Optimizations' -RestorePointType 'MODIFY_SETTINGS'"
if %errorLevel% == 0 (
    echo Restore point created successfully!
) else (
    echo Warning: Could not create restore point. Continuing anyway...
)
echo.

:: ===============================================
:: RESTORE REGISTRY SETTINGS
:: ===============================================
echo Restoring registry settings...

:: Re-enable Windows Game Mode
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "GameMode" /t REG_DWORD /d 1 /f

:: Re-enable Game DVR and Game Bar
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f

:: Re-enable Windows Search Indexing
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search" /v "SetupCompletedSuccessfully" /t REG_DWORD /d 1 /f

:: Restore default multimedia system profile
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 20 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f

:: Restore default network settings
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /v "Medium" /f

:: Re-enable Windows Update automatic restart
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 0 /f

:: Restore default mouse settings
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f

:: Restore visual effects
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 0 /f

:: Re-enable background apps
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 0 /f

:: Re-enable Windows Tips and Tricks
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 1 /f

:: Re-enable Windows Spotlight
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 1 /f

:: Re-enable Cortana
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 1 /f

:: Re-enable Windows Update automatic download
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 4 /f

:: Restore default gaming settings
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /v "False" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /v "Medium" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /v "Normal" /f

:: Re-enable Windows Error Reporting
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 0 /f

:: Re-enable Windows Customer Experience Improvement Program
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 1 /f

:: Restore default memory management
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 0 /f

:: Restore default network settings
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 0 /f

:: Re-enable Windows Update Delivery Optimization
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 3 /f

:: Restore default graphics settings
reg add "HKEY_CURRENT_USER\Software\Microsoft\Avalon.Graphics" /v "DisableHWAcceleration" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectDraw" /v "DisableAGPSupport" /t REG_DWORD /d 0 /f

echo Registry settings restored!
echo.

:: ===============================================
:: RESTORE SERVICES
:: ===============================================
echo Restoring Windows services...

:: Re-enable services
sc config "Fax" start= demand
sc config "WSearch" start= auto
sc config "TrkWks" start= auto
sc config "WbioSrvc" start= auto
sc config "TabletInputService" start= auto
sc config "WMPNetworkSvc" start= manual
sc config "WerSvc" start= auto
sc config "Wecsvc" start= auto
sc config "WdiServiceHost" start= auto
sc config "WdiSystemHost" start= auto
sc config "WinHttpAutoProxySvc" start= auto
sc config "wisvc" start= auto
sc config "WpcMonSvc" start= auto
sc config "WpnService" start= auto
sc config "WpnUserService" start= auto
sc config "XblAuthManager" start= auto
sc config "XblGameSave" start= auto
sc config "XboxGipSvc" start= auto
sc config "XboxNetApiSvc" start= auto

:: Start services
net start "WSearch" 2>nul
net start "TrkWks" 2>nul
net start "WbioSrvc" 2>nul
net start "TabletInputService" 2>nul
net start "WerSvc" 2>nul
net start "Wecsvc" 2>nul
net start "WdiServiceHost" 2>nul
net start "WdiSystemHost" 2>nul
net start "WinHttpAutoProxySvc" 2>nul
net start "wisvc" 2>nul
net start "WpcMonSvc" 2>nul
net start "WpnService" 2>nul
net start "WpnUserService" 2>nul
net start "XblAuthManager" 2>nul
net start "XblGameSave" 2>nul
net start "XboxGipSvc" 2>nul
net start "XboxNetApiSvc" 2>nul

echo Services restored!
echo.

:: ===============================================
:: RESTORE POWER SETTINGS
:: ===============================================
echo Restoring power settings...

:: Set power plan to Balanced
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e

:: Re-enable USB selective suspend
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1

:: Re-enable PCI Express Link State Power Management
powercfg -setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1
powercfg -setdcvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1

:: Restore processor power management
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 50
powercfg -setdcvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 50

:: Apply power settings
powercfg -setactive SCHEME_CURRENT

echo Power settings restored!
echo.

:: ===============================================
:: RESTORE NETWORK SETTINGS
:: ===============================================
echo Restoring network settings...

:: Restore default TCP settings
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global netdma=enabled

echo Network settings restored!
echo.

:: ===============================================
:: CLEANUP AND FINALIZATION
:: ===============================================
echo Performing cleanup...

:: Clear DNS cache
ipconfig /flushdns

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo ===============================================
echo    RESTORE COMPLETE!
echo ===============================================
echo.
echo The following settings have been restored:
echo.
echo ✓ Registry settings reverted to defaults
echo ✓ Windows services re-enabled
echo ✓ Power settings restored to Balanced
echo ✓ Windows Game Mode and Game DVR re-enabled
echo ✓ Network settings restored to defaults
echo ✓ Visual effects re-enabled
echo ✓ Windows telemetry and background apps re-enabled
echo ✓ Windows Search indexing re-enabled
echo ✓ Cortana re-enabled
echo ✓ Windows Update settings restored
echo.
echo IMPORTANT NOTES:
echo - All gaming optimizations have been reverted
echo - A system restore point was created before restoration
echo - Some changes may require a restart to take full effect
echo - Your system is now back to default Windows settings
echo.
echo Restart your computer for all changes to take effect!
echo.
pause
