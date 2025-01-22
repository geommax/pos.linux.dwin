#!/bin/bash

echo "Deployment script started..."
ENTRY1="127.0.0.1       frontend.local"
ENTRY2="127.0.0.1       backend.local"

echo "mariadb install, apache2, php8.4"

sudo apt-get update
sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
sudo curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt-get update
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "The system will install somethings news !"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sudo apt install php8.4 mariadb-server apache2 -y
sudo apt install  php8.4-fpm php8.4-mysql php8.4-curl php8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-tokenizer  php8.4-opcache php8.4-readline php8.4-common -y
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
sudo systemctl start php8.4-fpm
sudo systemctl enable php8.4-fpm
sudo systemctl status php8.4-fpm 
sleep 2;
clear

#To enable PHP 8.4 FPM in Apache2 do:
#NOTICE: a2enmod proxy_fcgi setenvif
#NOTICE: a2enconf php8.4-fpm

cd $HOME/pos.linux.dwin/application
unzip Frontend.zip
unzip Backend.zip
ls Web\ Pos\ API/
ls dist
sleep 4;
echo "About to copy and restarting related service."

sudo rm -rf /var/www/html/{frontend,backend}
sudo mkdir -v /var/www/html/backend
sudo cp -rv Web\ Pos\ API/* /var/www/html/backend/
sudo chmod 755 /var/www/html/backend -R 
sudo chown -R www-data:www-data /var/www/html/backend
ls -l /var/www/html/{frontend,backend}
sleep 2
clear
sudo mkdir -v /var/www/html/frontend
sudo cp -rv dist/* /var/www/html/frontend/
sudo chown -R www-data:www-data /var/www/html/frontend
sudo chmod -R 755 /var/www/html/frontend
ls -l /var/www/html/{frontend,backend}
sleep 2 
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "Configuring Web Servers"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

cd $HOME/pos.linux.dwin
sudo cp -rv apache2_sites-availiable/*.conf /etc/apache2/sites-available/
ls -l /etc/apache2/sites-available/
cat /etc/apache2/sites-available/{frontend.conf,backend.conf}
clear
echo "Linking Storage for Photo !.."
sudo ln -s /var/www/html/backend/storage/app/public /var/www/html/backend/public/storage
ls -l /var/www/html/backend/public/
echo "About to restarting related service and enabling apache2 and php modules !.."
sleep 2
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "Configuring php8 Servers"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
sudo a2enmod php8.4
sudo a2dismod mpm_event
sudo a2dismod php8.4 
sudo a2enmod php8.4 
sudo systemctl restart apache2
sudo systemctl status apache2
sudo systemctl status php8.4-fpm.service
sleep 2;
clear

echo "---------------------------------"
sudo a2ensite frontend.conf
sudo a2ensite backend.conf
sudo systemctl reload apache2
sleep 2

echo "$ENTRY1" | sudo tee -a /etc/hosts > /dev/null
echo "$ENTRY2" | sudo tee -a /etc/hosts > /dev/null
cat /etc/hosts
sleep 2
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "Configuring mariadb-server & Restoring Database SQL ! "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "Set the root password."
echo "Remove anonymous users."
echo "Disallow root login remotely."
echo "Remove test databases."
echo "Reload privilege tables."
echo "."
echo "."
echo "-=-=-=-=-  RUN THIS QUERY -=-=-=-=-=-"
echo "CREATE DATABASE db_web_pos;"
echo "CREATE USER 'TZH'@'localhost' IDENTIFIED BY 'password';"
echo "GRANT ALL PRIVILEGES ON db_web_pos.* TO 'TZH'@'localhost';"
echo "FLUSH PRIVILEGES;"
echo "EXIT"
echo "-=-=-=-=-  RUN THIS QUERY -=-=-=-=-=-"
sleep 5
cd $HOME/pos.linux.dwin
sudo mysql_secure_installation
echo "Finished mysql setup please try to login : "
sudo mysql -u root -p
mysql -u TZH -p db_web_pos < $HOME/pos.linux.dwin/application/db_web_pos.sql
echo "Please check the database is correctly restored or not !"
mysql -u TZH -p 

# test url 

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
# Test Print 

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# network
# configure static ip 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
clear
