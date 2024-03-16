# Install AD Domain
$Password = Read-Host -Prompt 'SafeModePassword'
$DomainName = "adptest.net"
$DatabasePath = "C:\Windows\NTDS"
$SysVolPath = "C:\Windows\Sysvol"
$LogPath = "C:\Windows\NTDS"
$DomainNetbios = "ADPSTEST"

Install-ADDSForest -DomainName $DomainName -DatabasePath $DatabasePath -SysvolPath $SysVolPath -LogPath $LogPath -SafeModeAdministratorPassword $Password -DomainNetbiosName $DomainNetbios

# Install AD child Sub-Domain
$Password = Read-Host -Prompt 'SafeModePassword' -AsSecureString
$ParentDomainName = "adptest.net"
$NewDomainName = "eu"
$NewDomainNetbiosName = "EU"
$DatabasePath = "C:\Windows\NTDS"
$SysVolPath = "C:\Windows\Sysvol"
$LogPath = "C:\Windows\NTDS"
$DomainNetbios = "ADPSTEST"
$Credential = Get-Credential -Message "Provide Root Domain Admin Credential" -UserName "adpsadmin@adpstest.net"

Install-ADDSDomain -ParentDomainName -DatabasePath $DatabasePath -SafeModeAdministratorPassword $Password -NewDomainName $NewDomainName -NewDomainNetbiosName -Credential $Credential

Install-ADDSDomainController -DomainName $DomainNAme -LogPath $LogPath -SysVolPath $SysVolPath -DatabasePath $DatabasePath -SafeModeAdministratorPassword $Password -InstallDNS:$true -Credential $Credential

$Password = Read-Host -Prompt 'SafeModePassword' -AsSecureString
$ParentDomainName = "adptest.net"
$NewDomainName = "ap"
$NewDomainNetbiosName = "AP"
$DatabasePath = "C:\Windows\NTDS"
$SysVolPath = "C:\Windows\Sysvol"
$LogPath = "C:\Windows\NTDS"
$Credential = Get-Credential -Message "Provide Root Domain Admin Credential" -UserName "adpsadmin@adpstest.net"

Install-ADDSDomain -DatabasePath $DatabasePath -SysvolPath $SysVolPath -LogPath $LogPath -SafeModeAdministratorPassword $Password -NewDomainName $NewDomainName -NewDomainNetbiosName -Credential $Credential -CreateDNSDelegation

