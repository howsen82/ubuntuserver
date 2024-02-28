# Installing a feature using PowerShell
Get-WindowsFeature

# Filtering Windows Feature
Get-WindowsFeature -Name TEL*

# Installation of Telnet Client
Add-WindowsFeature Telnet-Client

# Lists all installed windows features
Get-WindowsFeature | Where-Object Installed

# Get Installed OS Name
Get-ComputerInfo | Select-Object OSName

# Uninstall Windows Defender
Uninstall-WindowsFeature -Name Windows-Defender