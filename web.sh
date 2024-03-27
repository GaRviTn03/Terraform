#!/bin/bash
sudo yum install httpd -y
sudo systemctl enable --now httpd
sudo touch /var/www/html/index.html
sudo chmod o+w /var/www/html/index.html
sudo echo '<h1> My first terraform project </h1>' > /var/www/html/index.html