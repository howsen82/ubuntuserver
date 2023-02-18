# 1. Finding the Get-NetView module on the PS Gallery
Find-Module -Name Get-NetView | ft -auto

# 2. Installing the latest version of Get-NetView
Install-Module -Name Get-NetView -Force -AllowClobber

# 3. Checking installed version of Get-NetView
Get-Module -Name Get-NetView -ListAvailable | ft -au

# 4. Importing Get-NetView
Import-Module -Name Get-NetView -Force

# 5. Creating a new folder for NetView output
$FolderName = 'C:\NetViewOutput'
New-Item -Path $FolderName -ItemType Directory | Out-Null

# 6. Running Get-NetView
Get-NetView -OutputDirectory $FolderName

# 7. Viewing the output folder using Get-ChildItem
$OutputDetails = Get-ChildItem -Path $FolderName
$OutputDetails

# 8. Viewing the output folder contents using Get-ChildItem
$Results = $OutputDetails | Select-Object -First 1
Get-ChildItem -Path $Results

# 9. Viewing IP configuration
Get-Content -Path $Results\_ipconfig.txt