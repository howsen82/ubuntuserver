# Test connection
Test-Connection REBEL-SDC01
Test-Connection -Source REBEL-SDC01, REBEL-SDC02 -ComputerName WEB1, BACK1
Test-Connection -Quiet -ComputerName WEB1, BACK1, DC2, CA1

# Test connection with Port
Test-NetConnection REBEL-SDC01 -Port 80

# Adding a route with PowerShell
> route add -p 192.168.16.0 mask 255.255.255.0 10.10.10.1 if 5
New-NetRoute -DestinationPrefix "192.168.17.0/24" -InterfaceIndex 5 -NextHop 10.10.10.1

# Get all connection profiles
Get-NetIPInterface -AddressFamily IPv4

# Turn off DHCP
Set-NetIPInterface -InterfaceIndex 6 -Dhcp Disabled

# Set IP address [10.0.0.101/24], gateway [10.0.0.1]
New-NetIPAddress -InterfaceIndex 11 -AddressFamily IPv4 -IPAddress "10.0.0.101" -PrefixLength 24 -DefaultGateway "10.0.0.1"

# Set DNS [10.0.0.10]
Set-DnsClientServerAddress -InterfaceIndex 11 -ServerAddresses "10.0.0.10" -PassThru

# confirm settings
> ipconfig /all

# Allow Ping ICMP
New-NetFirewallRule `
-Name 'ICMPv4' `
-DisplayName 'ICMPv4' `
-Description 'Allow ICMPv4' `
-Profile Any `
-Direction Inbound `
-Action Allow `
-Protocol ICMPv4 `
-Program Any `
-LocalAddress Any `
-RemoteAddress Any