#!/bin/bash
# Install Apache if it's not already present
if [ ! -f /usr/sbin/apache2 ]; then
    sudo apt install -y apache2
    sudo apt install -y libapache2-mod-php8.1
    sudo a2enmod php8.1
    sudo systemclt restart apache2
fi