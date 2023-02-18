# Install DNS Server
sudo apt install bind9

# Edit /etc/bind/named.conf.options
sudo nano /etc/bind/named.conf.options

# Uncomment this line
# // forwarders {
# //   0.0.0.0;
# // };
# 
forwarders {
    8.8.8.8;
    4.4.4.4;
};

sudo systemctl restart bind9
systemctl status bind9

sudo apt install dnsutils

# Setting up internal DNS
# /etc/bind/named.conf.local

zone "local.lan" IN {
  type master;
  file "/etc/bind/net.local.lan";
};

# Create new file
sudo nano /etc/bind/net.local.lan

$TTL 1D
@ IN SOA local.lan. hostmaster.local.lan. ( # hosrmaster@local.lan
202208161; serial
8H ; refresh # These values control how often secondary DNS servers will be instructed to check in for updates
4H ; retry
4W ; expire
1D) ; minimum
IN A 192.168.41.2
;
@ IN NS hermes.local.lan.
fileserv IN A 192.168.41.3
hermes IN A 192.168.41.2
mailserv IN A 192.168.41.5
mail IN CNAME mailserv.
web01 IN A 192.168.41.7

sudo systemctl restart bind9
systemctl status bind9

# If service is not started, check log file
cat /var/log/syslog | grep bind9

# Test DNS Name
dig webserv.local.bin