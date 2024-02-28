# Test connection
Test-Connection REBEL-SDC01
Test-Connection -Source REBEL-SDC01, REBEL-SDC02 -ComputerName WEB1, BACK1
Test-Connection -Quiet -ComputerName WEB1, BACK1, DC2, CA1

# Test connection with Port
Test-NetConnection REBEL-SDC01 -Port 80

# Adding a route with PowerShell
> route add -p 192.168.16.0 mask 255.255.255.0 10.10.10.1 if 5
New-NetRoute -DestinationPrefix "192.168.17.0/24" -InterfaceIndex 5 -NextHop 10.10.10.1