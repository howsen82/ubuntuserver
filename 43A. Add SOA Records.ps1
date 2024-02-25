# Add an 'A' record
Add-DnsServerResourceRecordA -Name 'blog' -ZoneName 'Reskit.Org' -IPv4Address '192.168.0.200'

# Remove an 'A' record
Remove-DnsServerResourceRecord -ZoneName 'Reskit.Org' -RRType 'A' -Name 'blog'

# List 'A' records in a zone
Get-DnsServerResourceRecord -ZoneName 'Reskit.Org' -RRType 'A'

# List the 'NS' for a zone
Get-DnsServerResourceRecord -ZoneName 'Reskit.Org' -RRType 'NS'

# List the 'SVR' records for a zone
Get-DnsServerResourceRecord -ZoneName 'Reskit.Org' -RRType 'SRV'
# Details
Get-DnsServerResourceRecord -ZoneName 'Reskit.Org' -RRType 'SRV' | Select-Object -ExpandProperty RecordData

# DNS records file locate under directory 'c:\windows\system32\DNS'

# In an AD-integrated DNS setup, a primary zone can be created using the following command
Add-DnsServerPrimaryZone -Name 'Reskit.Org' -ReplicationScope 'Forest' -PassThru

# Secondary Zone
Set-DnsServerPrimaryZone -Name 'Reskit.Org' -SecureSecondaries TransferToSecureServers -SecondaryServers 192.168.0.106
# In the following command, -MasterServers defines the IP address of the master
# server. The -ZoneFile parameter is there, but only for file-backed DNS servers
Add-DnsServerSecondaryZone -Name 'Reskit.Org' -ZoneFile "Reskit.Org.dns" -MasterServers 192.168.0.105

# Add a Reverse lookup zones
Add-DnsServerPrimaryZone -NetworkID '10.10.10.0/24' -ReplicationScope 'Domain'
# Add Conditional forwarders zone
Add-DnsServerConditionalForwarderZone -Name 'Reskit.Org' -ReplicationScope 'Forest' -MasterServers 10.0.0.5