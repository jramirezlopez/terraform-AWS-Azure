#!/bin/bash
apt-get update -y
apt-get install -y apache2
echo "¡Hola desde TechDiversa VM en Azure!" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2
