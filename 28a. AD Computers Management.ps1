# Update Computer Object
Set-ADComputer 'REBEL-PC-01' -Description 'Sales Computer'

# Search and Update
Get-ADComputer -Filter {Name -like "REBEL-PC-*"} | Set-ADComputer -Location "M35 Building"

# Remove computers
Remove-ADComputer -Identity "REBEL-PC-01"

# Search and Remove
Get-ADComputer -Filter * -SearchBase 'OU=Computers,OU=Europe,DC=Reskit,DC=Org' | Remove-ADComputer

# Search for lockedout accounts
Search-ADAccount -LockedOut | Format-Table Name,UserPrincipalName

# Prevent accedental deletion
Set-ADObject -Identity 'CN=Dishan Francis,DC=rebeladmin,DC=com' -ProtectedFromAccidentalDeletion $true

# -----
# Enable AD Recycle Bin
Enable-ADOptionalFeature 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target Reskit.Org

# Deleted Objects
Get-ADObject -filter 'isdeleted -eq $true' -includeDeletedObjects

# Restore Deleted Object
Get-ADObject -Filter 'samaccountname -eq "dfrancis"' -IncludeDeletedObjects | Restore-ADObject