# View all listening port occupancy
sudo ss -tulpn

# Get all installed packages
dpkg --get-selections > installed_packages.txt

# See any depencies packages
apt-cache rdepends <package-name>
# e.g apt-cache rdepends tmux

# Update absolute everything available
sudo apt dist-upgrade

# Restart a system service
sudo systemctl restart bind9

# Lookup previous downloaded archive package path
ls -l /var/cache/apt/archives
# E.g.
sudo dpkg -i /var/cache/apt/archives/linux-image-5.15.0-30-generic_5.15.0-30.31_amd64.deb

# Fix all unresolved dependencies
sudo apt -f install

# Secure MariaDB
nano /etc/hosts.allow
nano /etc/hosts.deny

#e.g. host.allow
# Allow a machine with IP address 192.168.1.50 to access server
ALL: 192.168.1.50

# Allows any machine within the 192.168.1.0/24 network to access the server
ALL: 192.168.1.0/255.255.255.0

# Acts as a wildcard, which means that any IP address beginning with 192.168.1 is allowed
ALL: 192.168.1.

# This rule allows everything. Definitely don’t want to do
ALL: ALL

# llowing OpenSSH traffic originating from any IP address beginning with 192.168.1
ssh: 192.168.1.

# E.g. host.deny
# Block any traffic not included in the /etc/hosts.allow
ALL: ALL