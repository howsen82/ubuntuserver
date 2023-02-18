# Install Apache Web Server
sudo apt install apache2

# Check the Apache status
systemctl status apache2

# Enable URL acmeconsulting.com
# Symbolic link to path /etc/apache2/sites-enabled
sudo a2ensite acmeconsulting.com.conf
sudo systemctl reload apache2

# Disable URL acmeconsulting.com
sudo a2dissite acmeconsulting.com.conf
sudo systemctl reload apache2

# To create a new host in /etc/apache2/sites-available/acmeconsulting.com.conf
<VirtualHost 192.168.1.104:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/acmeconsulting

    ErrorLog ${APACHE_LOG_DIR}/acmeconsulting.com-error.log
    CustomLog ${APACHE_LOG_DIR}/acmeconsulting.com-access.log combined
</VirtualHost>

sudo a2ensite acmeconsulting.com.conf # Execute this command will create a symbolic link to a file stores in /etc/apache2/sites-enabled directory.
sudo systemctl reload apache2

# Installing additional Apache modules
apt search libapache2-mod
sudo apt install libapache2-mod-php8.1

# List all apache modules
apache2 -l
a2enmod

# Enable php8.1 modules in Apache
sudo a2enmod php8.1
sudo systemctl restart apache2

# Disable php8.1 modules in Apache
sudo a2dismod php8.1

# If need support for Python
sudo apt install libapache2-mod-python

# Check for Apache running port 80 (http) | 443 (https)
sudo ss -tulpn | grep apache

# Enable HTTPS traffic
sudo a2enmod ssl
sudo systemctl restart apache2

# Enable default SSL TLS certificate configuration file,
# It was not activated by default
sudo a2ensite default-ssl.conf

# Create self-signed SSL
sudo mkdir /etc/apache2/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/certs/mysite.key -out /etc/apache2/certs/mysite.crt
# Edit this file /etc/apache2/sites-available/default-ssl.conf
# Change to
# SSLCertificateFile /etc/apache2/certs/mysite.crt
# SSLCertificateKeyFile /etc/apache2/certs/mysite.key
sudo systemctl reload apache2

# Edit /etc/apache2/sites-available/acmeconsulting.conf
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerName acmeconsulting.com:443
        ServerAdmin webmaster@localhost

        DocumentRoot /var/www/acmeconsulting
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        SSLEngine on
        SSLCertificateFile /etc/apache2/certs/mysite.crt
        SSLCertificateKeyFile /etc/apache2/certs/mysite.key

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>
        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>
    </VirtualHost>
</IfModule>

sudo a2ensite acmeconsulting.conf
sudo a2dissite default-ssl.conf
sudo systemctl reload apache2

# Turn off and disable its services
sudo systemctl stop apache2
sudo systemctl disable apache2

# Remove Apache2 completely
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get autoremove
whereis apache2
sudo rm -rf /etc/apache2