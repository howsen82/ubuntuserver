# Install Remote Server Administration Tools (RSAT)
Get-WidnowsFeature | Where-Object { $_.Name -like 'RSAT-AD-Tools' } | Install-WindowsFeature