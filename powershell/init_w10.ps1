# Initialize my common preferences on a Windows 10 installation


# Disable startup delay
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "Startupdelayinmsec" -Value 0 -Type DWord

