# Initialize my common preferences on a Windows 10 installation

# Set PowerShell execution policy to be able to make registry changes
Set-ExecutionPolicy RemoteSigned

# Disable startup delay
if (!(Get-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force

# Show "My Computer" on the desktop
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Type DWord -Force

# Force Icon View in Control Panel
if (!(Get-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies"
}
if (!(Get-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ForceClassicControlPanel" -Value 1 -Type DWord -Force

# Always show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -Force

# Always show all files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type DWord -Force

# Alwas show all icons in notification area
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -Type DWord -Force

# Remove "People" icon from task bar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0 -Type DWord -Force

# Disable Ads
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0 -Type DWord -Force

# Disable App Suggestions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -Force
if (!(Get-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent"
}
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -Force

# Uninstall and disable One Drive
taskkill /f /im OneDrive.exe
if (Test-Path -Path "$Env:SystemRoot\System32\OneDriveSetup.exe" -PathType Leaf)
{
  "$Env:SystemRoot\System32\OneDriveSetup.exe /uninstall"
}
if (Test-Path -Path "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" -PathType Leaf)
{
  "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe /uninstall"
}
if (Test-Path -Path "$Env:UserProfile\OneDrive")
{
  Remove-Item -Path "$Env:UserProfile\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path -Path "$Env:LocalAppData\Microsoft\OneDrive")
{
  Remove-Item -Path "$Env:LocalAppData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path -Path "$Env:ProgramData\Microsoft\OneDrive")
{
  Remove-Item -Path "$Env:ProgramData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path -Path "C:\OneDriveTemp")
{
  Remove-Item -Path "C:\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Get-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ErrorAction SilentlyContinue)
{
  REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F
}
if (Get-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ErrorAction SilentlyContinue)
{
  REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F
}
if (!(Get-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive"
}
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Value 1 -Type DWord -Force

# Disable automatic reboot on BSOD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "AutoReboot" -Value 0 -Type DWord -Force

# Disable remote assistance connections
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fAllowToGetHelp" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowFullControl" -Value 0 -Type DWord -Force

# Disable windows indexing service
"$Env:SystemRoot\System32\sc.exe stop 'WSearch'"
"$Env:SystemRoot\System32\sc.exe config 'WSearch' start= DISABLED"

# Turn off indexing on all files
ATTRIB /S /D C:\*.* -I


