# Install Apache

# SSH to user home directory
wget https://download.nextcloud.com/server/releases/latest.zip
unzip latest.zip # If command cannot execute, run: sudo apt install unzip
sudo mv nextcloud /var/www/html/nextcloud
sudo nano /etc/apache2/sites-available/nextcloud.conf

# nextcloud.conf
Alias /nextcloud "/var/www/html/nextcloud/"

<VirtualHost *:80>
    DocumentRoot "/var/www/html/nextcloud"
    ServerName example.com

    <Directory "/var/www/html/nextcloud/">
        Options MultiViews FollowSymlinks
        AllowOverride All
        Order allow, deny
        Allow from all
    </Directory>

    <IfModule mod_dav.c>
        Dav off
    </IfModule>

    SetEnv HOME /var/www/html/nextcloud
    SetEnv HTTP_HOME /var/www/html/nextcloud

    TransferLog /var/log/apache2/nextcloud_access.log
    ErrorLog /var/log/apache2/nextcloud_error.log
    
</VirtualHost>

<Directory /var/www/html/nextcloud/>
  Options +FollowSymlinks
  AllowOverride All
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
  SetEnv HOME /var/www/html/nextcloud
  SetEnv HTTP_HOME /var/www/html/nextcloud
</Directory>

# Enable the site
cd /etc/apache2/sites-available
sudo a2ensite nextcloud.conf
sudo apt install libapache2-mod-php8.1 php8.1-curl php8.1-gd php8.1-intl php8.1-mbstring php8.1-mysql php8.1-xml php8.1-zip
sudo systemctl restart apache2

# Login to MariaDB
CREATE DATABASE nextcloud;
GRANT ALL ON nextcloud.* to 'nextcloud'@'localhost' IDENTIFIED BY 'super_secret_password';
FLUSH PRIVILEGES;