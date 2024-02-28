# 100. Import using CSV file [Create Bulk Users]
Import-Csv "C:\ADUsers.csv" | ForEach-Object {
    $upn = $_.SamAccountName + "@rebeladmin.com"
    New-ADUser -Name $_.Name `
    -GivenName $_."GivenName" `
    -Surname $_."Surname" `
    -SamAccountName $_."samAccountName" `
    -UserPrincipalName $upn `
    -Path $_."Path" `
    -AccountPassword (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -force) `
    -Enabled $true
}

# 100a. Set AD user's attributes
Set-ADUser tidris -OfficePhone "0912291120" -City "London"
Set-ADUser tidris -OfficePhone "0112291120"

# 100b. Search AD Users
Get-ADUser -Filter * -SearchBase 'OU=Users,OU=Europe,DC=rebeladmin,DC=com' | Set-ADUser -City "London"
Get-ADUser -Filter {City -like "London"} | Set-ADUser -City "Kingston" # Search and update

# 100c. Remove AD Users
Remove-ADUser -Identity "dzhang"
# Search and Remove
Get-ADUser -Filter {Name -like "Test1*"} | Remove-ADUser
# View User Attributes
Get-ADUser -Identity 'Steven' -Properties *

# Filter User based on attibutes
Get-ADUser -Filter * -Properties Name,UserPrincipalName,Modified | Format-Table Name,UserPrincipalName,Modified
Get-ADUser -Filter {City -like "Kingston"} -Properties Name,UserPrincipalName,Modified | Format-Table Name,UserPrincipalName,Modified

# Export search results
Get-ADUser -Filter {City -like "Kingston"} -Properties Name,UserPrincipalName,Modified | select-object Name,UserPrincipalName,Modified | Export-csv -path C:\ADUSerList.csv

# Create New User Template
# The preceding command creates a user account called _TechSupport_Template. It also
# sets the new user account as a disabled account.
New-ADUser -Name "_TechSupport_Template" -GivenName "_TechSupport" -Surname "_Template" -SamAccountName "techtemplate" -UserPrincipalName "techtemplate@rebeladmin.com" -Path "OU=Users,OU=Europe Office,DC=rebeladmin,DC=com" -AccountPassword(Read-Host -AsSecureString "Type Password for User") -Enabled $false
# Add Template to Group
Add-ADGroupMember "Technical Department" "techtemplate"

#---------------
# Create Managed Service Account
# Service accounts are usually used when installing applications or services. A
# service account is a dedicated account with specific privileges that is used to run
# services, batch jobs, and management tasks.
New-ADServiceAccount -Name "MyAcc1" -RestrictToSingleComputer
# Associate MSA with Host
Add-ADComputerServiceAccount -Identity REBEL-SRV01 -ServiceAccount "MyAcc1"
# Install MSA
Install-ADServiceAccount -Identity "MyAcc1"
# Test MSA
Test-ADServiceAccount "MyAcc1"
# View MSA Account Properties
Get-ADServiceAccount "MyAcc1"

#---------------
# Create Group Managed Service Accounts (gMSA)
# KDS Root Key
Add-KdsRootKey -EffectiveImmediately
# Remove 10 Hours Replication Time
Add-KdsRootKey -EffectiveTime ((Get-Date).addhours(-10))
# Create gMSA
New-ADServiceAccount "Mygmsa1" -DNSHostName "web.rebeladmin.com" -PrincipalsAllowedToRetrieveManagedPassword "IISFARM"
# View gMSA Properties 
Get-ADServiceAccount "Mygmsa1"
# Install gMSA
Install-ADServiceAccount -Identity "Mygmsa1"
# Test gMSA
Test-ADServiceAccount "Mygmsa1"
# Uninstall MSA
Remove-ADServiceAccount -Identity "Mygmsa1"

#---------------
# Create New AD Group
New-ADGroup -Name "Sales Team" -GroupCategory Security -GroupScope Global -Path "OU=Users,OU=Europe,DC=rebeladmin,DC=com"

# Protect Group From Accedental Deletion
Get-ADGroup "Sales Team" | Set-ADObject -ProtectedFromAccidentalDeletion:$true

# Add members to group
Add-ADGroupMember "Sales Team" tuser3,tuser4,tuser5

# Remove member from group
Remove-ADGroupMember "Sales Team" tuser4

# View group properties
Get-ADGroup "Sales Team"

# Filter data in group
Get-ADGroup "Sales Team" -Properties DistinguishedName,Members | Format-List DistinguishedName,Members

# Change group scope
Set-ADGroup "Sales Team" -GroupScope Universal

# Remove AD group
Remove-ADGroup "Sales Team"

#---------------
# Create Devices and other objects (Printer)
New-ADUser -Name "Inet User1" -GivenName "Inet" -Surname "User1" -SamAccountName "inetuser1" -UserPrincipalName "isuer1@rebeladmin.com" -AccountPassword (Read-Host -AsSecureString "Type Password for User") -Enabled $true -Path "OU=Users,OU=Europe,DC=rebeladmin,DC=com" -Type iNetOrgPerson
# Convert iNetOrgPerson object to user object
Set-ADUser "inetuser1" -Remove @{objectClass='inetOrgPerson'}

# -------------------
# User Group
# Add [Development01] group
New-ADGroup 'Development01' -GroupScope Global -GroupCategory Security -Description "Database Admin Group"
Get-ADGroup -Identity 'Development01'

# Add a member to a group
Add-ADGroupMember -Identity Development01 -Members Serverworld
Get-ADGroupMember -Identity Development01

# Delete a member from a group, run like follows
Remove-ADGroupMember -Identity Development01 -Members Serverworld

# Delete a group, run like follows
Remove-ADGroup -Identity Development01

# -------------------
# Organizational Unit
# show current Organizational Unit list
Get-ADOrganizationalUnit -Filter * | Format-Table DistinguishedName

# for example, add [Development01] under the [Hiroshima]
New-ADOrganizationalUnit Development01 -Path "OU=Hiroshima,DC=srv,DC=world" -ProtectedFromAccidentalDeletion $true

# Delete OU
Remove-ADOrganizationalUnit -Identity "OU=Development01,OU=Hiroshima,DC=srv,DC=world"

# -------------------
# Add Computer Accounts
Get-ADComputer -Filter * | Format-Table DistinguishedName

New-ADComputer -Name 'RX-0'

# to specify OU
New-ADComputer -Name 'RX-7' -Path "OU=Computers,OU=Hiroshima,DC=srv,DC=world"

# if you'd like to add a specific user who can authenticate to AD when computer joins, set like follows
> dsacls "CN=RX-0,CN=Computers,DC=srv,DC=world" /G FD3S01\Serverworld:CALCGRSDDTRC;

# Delete computer accounts
Remove-ADComputer -Identity "CN=RX-9,CN=Computers,DC=srv,DC=world"