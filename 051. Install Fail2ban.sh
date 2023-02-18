# Install fail2ban
sudo apt install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# Edit /etc/fail2ban/jail.conf
Ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24 192.168.1.245/24
bantime = 10m
maxretry = 5
[sshd]
port = 65532

sudo systemctl restart fail2ban
sudo systemctl status -l fail2ban

# Check Fail2ban status
sudo fail2ban-client status

# Edit configuration
sudo cat /etc/fail2ban/jail.local
enabled = true

[apache-auth]
enabled = true
port = http,https
logpath = %(apache_error_log)

sudo systemctl restart fail2ban
sudo systemctl status -l fail2ban
sudo fail2ban-client status