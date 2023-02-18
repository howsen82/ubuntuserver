# Assign static IP Address
cat /etc/netplan/00-installer-config.yaml
# Look at dhcp4: true

# Backup config file before assign static IP address
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak
# Edit config yaml file
network:
  ethernets:
    ens33:
      addresses: [192.168.100.50/24] # This is actual IP address
      routes:
        - to: default
          via: 192.168.100.1 # Refer to the device your outbound connections are routed through
      nameservers: # Refer to DNS Server entries
        addresses: [192.168.100.1, 192.168.100.2]
  version: 2

# Save it and apply settings
sudo netplan apply

# If OpenSSH is running connected, in order to not drop its connection, try
sudo apt install tmux
tmux
sudo netplan apply
Ctrl + b # Then press d exit the session