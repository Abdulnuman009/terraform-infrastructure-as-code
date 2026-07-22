#!/bin/bash

# This script is used to set up a server with Nginx installed and a custom index.html page.

set -e
echo "Starting server setup..."

apt-get update
apt-get install -y nginx

echo "<h1>Terraform Provisioner Practice by Numan</h1>" > /var/www/html/index.html
echo "<p>Nginx was installed using a file and remote-exec provisioner.</p>" >> /var/www/html/index.html

systemctl enable nginx
systemctl restart nginx

echo "Server setup completed successfully."