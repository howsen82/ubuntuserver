# Get IP Information
Get-NetIPConfiguration
Get-NetIPAddress
Get-NetIPInterface

# Configure IP Address
Set-NetIPAddress
> route print
New-NetIPAddress -InterfaceIndex 4 -IPAddress 10.10.10.12 -PrefixLength 24 -DefaultGateway 10.10.10.1
Set-DNSClientServerAddress -InterfaceIndex 4 -ServerAddresses 10.10.10.10, 10.10.10.11
Get-NetIPConfiguration

# Set PC Name
> hostname
Rename-Computer WEB4
Restart-Computer

# Join domain
Add-Computer

# Remote Powershell Access
Enter-PSSession -ComputerName 'WEB4' -Credential 'administrator'

# Install Active Directory
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature DNS

# Promote this server to a domain controller
Install-ADDSDomainController -InstallDns -DomainName "contoso.local"
> repadmin /showrepl

# Query user
> quser
> quser /server:WEB1

# Get current password policy
Get-ADDefaultDomainPasswordPolicy

# Export Event Log to CSV file
Get-EventLog -LogName System | Export-Csv C:\Logs\SysLog.csv

# Filter windows services
Get-Service -DisplayName hyper*
# Stop services
Get-Service -DisplayName hyper* | Stop-Service