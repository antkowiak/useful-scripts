$reg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
Set-ItemProperty -Path $reg -Name ProxyServer -Value "socks=127.0.0.1:9999"
Set-ItemProperty -Path $reg -Name ProxyEnable -Value 1