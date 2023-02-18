# Install firewall package
sudo apt install ufw

# Check firewall status
sudo ufw status

# Enable firewall from IP address 192.168.1.156 to OpenSSH 22 via TCP and UDP
sudo ufw allow from 192.168.1.156 to any port 22

# Allow traffic by subnet
sudo ufw allow from 192.168.1.0/24 to any port 22

# Allow traffic from a specific IP to access anything (Not recommend)
sudo ufw allow from 192.168.1.50

# Allow traffic for HTTP and HTTPS
sudo ufw allow 80
sudo ufw allow 443

# Enable firewall
sudo ufw enable
