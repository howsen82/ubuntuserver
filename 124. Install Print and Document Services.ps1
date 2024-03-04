# Print and Document Services installation
Install-WindowsFeature Print-Services -IncludeManagementTools

# Install printer to print server
Add-Printer -Name 'Microsoft_Print' -DriverName 'Microsoft Print To PDF' -Port LPT1:

# Share printer
Set-Printer -Name 'Microsoft_Print' -Shared $True -Published $True -ShareName 'MicrosoftPrint'

# Add printer driver
Add-PrinterDriver -Name 'Driver Name' -ComputerName "PrintServer" -InfPath 'C:\Drivers'