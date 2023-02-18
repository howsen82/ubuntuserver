echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo nano /etc/sysctl.conf

# Look for the following line:
#net.ipv4.ip_forward=1
# Uncomment it

