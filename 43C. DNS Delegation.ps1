# DNS delegation can also be used to divide the DNS workloads into additional zones
# to improve the performance and create a fault-tolerant setup.
Add-DnsServerPrimaryZone -Name 'dev.reskit.org' -ZoneFile 'dev.reskit.org.dns'
Add-DnsServerResourceRecordA -Name 'app1' -ZoneName 'dev.reskit.org' -AllowUpdateAny -IPv4Address '192.168.0.110'
Add-DnsServerZoneDelegation -Name 'reskit.org' -ChildZoneName 'dev' -NameServer 'REBEL-SDC-01.reskit.org' -IPAddress 192.168.0.110