#!/bin/bash
# Actualizar paquetes del sistema
yum update -y

# Instalar Apache
yum install -y httpd

# Crear la página HTML de bienvenida
echo "<h1>Bienvenido a TechDiversa</h1>" > /var/www/html/index.html

# Habilitar y arrancar el servicio de Apache
systemctl enable httpd
systemctl start httpd
