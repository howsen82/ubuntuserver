# Install Storage Replica
$Servers = 'REBEL-SDC01'
$Servers | ForEach-Object { Install-WindowsFeature -ComputerName $_ -Name Storage-Replica, FS-FileServer -IncludeManagementTools -restart }

Test-SRTopology -SourceComputerName FS01 -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName FS02 -DestinationVolumeName S: -DestinationLogVolumeName L: -DurationInMinutes 10 -ResultPath 'C:\SR_TEST\'

# Configuring Storage Replica
# Any data that is stored on FS01's S: drive is automatically replicated over to FS02:
New-SRPartnership -SourceComputerName FS01 -SourceRGName RepGroup1 -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName FS02 -DestinationRGName RepGroup2 -DestinationVolumeName S: -DestinationLogVolumeName L:
Get-SRGroup

# Shifting the primary server to FS02
Set-SRPartnership -NewSourceComputerName FS02 -SourceRGName RepGroup2 -DestinationComputerName FS01 -DestinationRGName RepGroup1