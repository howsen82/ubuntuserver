# Install Nginx
sudo apt install -y nginx

# Configuration path for nginx
/etc/nginx
/etc/nginx/sites-available # Site settings

# Create new site
sudo nano /etc/nginx/sites-available/acmesales.com

# Enable site settings set as default
sudo ln -s /etc/nginx/sites-available/acmesales.com /etc/nginx/sites-enabled/acmesales.com
sudo systemctl reload nginx

# Create new site using default template
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/acmesales.com
# Edit
sudo nano /etc/nginx/sites-available/acmesales.com
# Change from
listen 80 default_server;
listen [::]:80 default_server;
# To
listen 80;
listen [::]:80;

root /var/www/acmesales.com;

index index.html index.htm index.nginx-debian.html;

server_name acmesales.com www.acmesales.com;

location / {
    try_files $uri $uri/ =404;
}

# SSL
listen 443 ssl;
listen [::]:443 ssl;

root /var/www/html;

index index.html index.htm index.nginx-debian.html;

server_name acmesales.com www.acmesales.com;
ssl_certificate /etc/certs/cert.pem;
ssl_certificate_key /etc/certs/cert.key;
ssl_session_timeout 5m;

location / {
    try_files $uri $uri/ =404;
}

# Create self-signed certificate
sudo openssl req -x509 -newkey rsa:4096 -keyout cert.key -out cert.pem -sha256 -nodes -days 365

# Edit file /etc/nginx/sites-available/default
sudo nano /etc/nginx/sites-available/default

listen 80 default_server;
listen [::]:80 default_server;

return 301 https://$host$request_uri;

# Remove nginx
sudo apt purge nginx nginx-common nginx-core
sudo apt remove nginx nginx-common nginx-core
sudo apt autoremove
