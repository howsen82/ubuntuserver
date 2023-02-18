# Installation of DHCP Server
# Assign static IP first
sudo apt install isc-dhcp-server

# See the status of the DHCP Server status, will show failed since we haven't configure yet
sudo systemctl status isc-dhcp-server

# Stop the service and configure it
sudo systemctl stop isc-dhcp-server
sudo systemctl stop isc-dhcp-server6
sudo systemctl disable isc-dhcp-server6
sudo mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.orig

sudo nano /etc/dhcp/dhcpd.conf # Create new file

default-lease-time 43200;
max-lease-time 86400;
option subnet-mask 255.255.255.0;
option broadcast-address 192.168.41.255;
option domain-name "local.lan";
authoritative;
subnet 192.168.41.0 netmask 255.255.255.0 {
  range 192.168.41.130 192.168.41.240;
  option routers 192.168.41.2;
  option domain-name-servers 192.168.41.2;
}

# Edit /etc/default/isc-dhcp-server, change to ens33
# Refer to ip a for network name
INTERFACESv4="ens33"

sudo systemctl start isc-dhcp-server
sudo systemctl status isc-dhcp-server