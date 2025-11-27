#!/bin/bash
set -xe

# Update system packages
sudo apt update

# Install Nginx if it's not already installed
if ! command -v nginx &> /dev/null
then
    sudo apt install nginx -y
fi

# Install Certbot if it's not already installed
if ! command -v certbot &> /dev/null
then
    sudo apt install certbot python3-certbot-nginx -y
fi

# Create a new user 'www' and set /www as its home directory
sudo useradd -m -d /www www

# Set permissions for the /www directory
sudo chown www:www /www
sudo chmod 755 /www

# Check if there's an existing Nginx config file
if [ -f /etc/nginx/sites-available/default ]; then
    # Backup the original config file
    sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

    # Write the new configuration for static file redirect
    cat <<EOT | sudo tee /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /www;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOT

    # Reload Nginx to apply the new configuration
    sudo nginx -t && sudo systemctl reload nginx
fi

# Setup Certbot for automatic SSL certificate generation and renewal
# Replace 'your_domain.com' with your actual domain name
sudo certbot --nginx -d laizn.cc

# Restart Nginx to apply SSL changes
sudo systemctl restart nginx
