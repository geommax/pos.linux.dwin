#!/bin/bash

echo "Deployment script started..."

# printer

sudo dpkg -i dpkg -i xprinter/printer-driver-xprinter_3.13.3_all.deb
sudo apt install -f
sudo systemctl status cups.service
echo "X Printer Setup is successfully installed"
chmod +x ./xprinter/XP-80
sudo ./xprinter/XP-80 
echo "sleeping ...1, 2 ,3 .."
sleep 3;
clear

# Url of socket://192.168.123.1 - 2
#### Step 8.5. Connection From LAN

#> XPrinter : 192.168.123.100

#> Computer : 192.168.123.101 . 1 (gateway)

#> socket://192.168.123.100:9100 နဲ့ cofigure လုပ်တာ အဆင်ပြေပါတယ်။ 


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# network
# configure static ip 

# mariadb install, apache2, php8.4

sudo apt-get update
sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
sudo curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt-get update
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "The system will install somethings news !"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sudo apt install php8.4 mariadb-server apache2 -y
sudo apt install  php8.4-fpm php8.4-mysql php8.4-curlphp8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-tokenizer  php8.4-opcache php8.4-readline php8.4-common -y
clear
#cann't install php
#=-=-=-=
#php8.4-json php8.4-gd 
#=-=-=-
sudo systemctl status apache2
echo "Enabling apache2....."
sudo systemctl enable apache2
echo "Starting apache2....."
sudo systemctl start apache2
sudo systemctl status apache2
sudo systemctl status mariadb
echo "Enabling mariadb....."
sudo systemctl enable mariadb
echo "Starting mariadb....."
sudo systemctl start mariadb
sudo systemctl status mariadb
echo "Entering Next Steps..."
sleep 2;
clear


#To enable PHP 8.4 FPM in Apache2 do:
#NOTICE: a2enmod proxy_fcgi setenvif
#NOTICE: a2enconf php8.4-fpm


# copying and restarting related service.
# Test Print 


