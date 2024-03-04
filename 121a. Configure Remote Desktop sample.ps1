# 1. Allow RDP connection
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0

# 2. Configure 'Network Level Authentication'
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'UserAuthentication' -Value 1

 # 3. Add Remote Desktop firewall exception
Set-NetFirewallRule -DisplayGroup 'Remote Desktop' -Enabled True

# 4. Add user to Remote Desktop
> net localgroup "Remote Desktop Users" testuser /add
