# Almost refer to /etc/hosts
10.10.96.123 myserver.mydomain.

# Old version of Ubuntu server refer to /etc/resolv.conf
nameserver 10.10.96.1
nameserver 10.10.96.2
# Server will lookup entries on /etc/hosts first, if not found, then it will refer to /etc/resolv.conf

# If DHCP is being used, use command will let you know what DNS nameserver pointing to
resolvectl