# Scenario
# Computer A: 10.0.0.6
# DNS Server: 10.0.0.4 with 'A' record of 'portal.reskit.org' that resolves to 10.0.0.7
# > nslookup portal.reskit.org
# To block DNS queries from 10.0.0.6
Add-DnsServerClientSubnet -Name 'blockA' -IPv4Subnet 10.0.0.6/32
Add-DnsServerQueryResolutionPolicy -Name 'blockAPolicy' -Action IGNORE -ClientSubnet 'EQ,blockA'