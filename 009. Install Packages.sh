# Install OpenSSH Server
sudo apt install openssh-server

sudo apt install <package1> <package2> <package3>

# Install Apache 2 Server
sudo apt install apache2

# Search for update package list from repository
sudo apt update

# Removal of a package
sudo apt remove <package>

# Remove of package with wipe out its configuration files
# Usually located under /etc directory
sudo apt remove --purge <package>

# Find package
snap find <keyword>

# Find nmap security tools
snap find nmap

# Install nmap
sudo snap install nmap

# Check nmap installation directory path
which nmap

# Removal of nmap package
sudo snap remove nmap

# Update a package
sudo snap refresh <package>

# Update all packages
sudo snap refresh

# Search for packages
apt search <search-term>
# e.g
apt search apache php

# Check for package details
apt-cache show libapache2-mod-php