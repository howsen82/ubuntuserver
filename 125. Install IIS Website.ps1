# Add new website to IIS
New-Website -Name 'Intranet' -PhysicalPath 'C:\Intranet'

# Stop an IIS website
Get-Website -Name 'Default Web Site' | Stop-Website

# Start IIS website
Get-Website -Name 'Intranet' | Start-Website