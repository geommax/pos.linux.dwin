#!/bin/bash

clear
ENTRY1="127.0.0.1 frontend.local"
ENTRY2="127.0.0.1 backend.local"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "Deployment script started..."

echo "$ENTRY1" | sudo tee -a /etc/hosts > /dev/null
echo "$ENTRY2" | sudo tee -a /etc/hosts > /dev/null
cat /etc/hosts
sleep 2
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "1. Installation of mariadb install, apache2, php8.4"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sudo apt-get update
sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
sudo curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt-get update
sudo apt install libglib2.0 -y
#sudo reboot
sudo apt install php8.4 mariadb-server apache2 -y
sudo apt install  php8.4-fpm php8.4-mysql php8.4-curl php8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-tokenizer  php8.4-opcache php8.4-readline php8.4-common -y
clear
dpkg -l | grep php8.4
sleep 3
clear
sudo systemctl status apache2
sudo systemctl status mariadb 
sudo systemctl status mariadb 
echo "Entering Next Steps..."
sleep 2;
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "2. Copying Web & API Packages to /var/www/html/"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

cd $HOME/pos.linux.dwin/application
unzip Frontend.zip
unzip Backend.zip
ls -la Web\ Pos\ API/
ls -la dist/
sleep 4;

echo "About to copy and restarting related service."
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sudo rm -rf /var/www/html/{frontend,backend}
#sudo mkdir -v /var/www/html/backend
sudo cp -rv Web\ Pos\ API /var/www/html/backend
sudo chmod 755 /var/www/html/backend -R 
sudo chown -R www-data:www-data /var/www/html/backend
ls -l /var/www/html/{frontend,backend}
sleep 2
clear
#sudo mkdir -v /var/www/html/frontend
sudo cp -rv dist /var/www/html/frontend
sudo chown -R www-data:www-data /var/www/html/frontend
sudo chmod -R 755 /var/www/html/frontend
ls -l /var/www/html/{frontend,backend}
sleep 2 
clear
echo "Linking Storage for Photo !.."
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sudo ln -s /var/www/html/backend/storage/app/public /var/www/html/backend/public/storage
ls -l /var/www/html/backend/public/
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "3. Configuring Web Servers"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

cd $HOME/pos.linux.dwin
sudo cp -rv apache2_sites-availiable/frontend.conf /etc/apache2/sites-available/
sudo cp -rv apache2_sites-availiable/backend.conf.v1 /etc/apache2/sites-available/backend.conf
ls -l /etc/apache2/sites-available/
cat /etc/apache2/sites-available/{frontend.conf,backend.conf}
echo "---------------------------------"
sudo a2ensite frontend.conf
sudo a2ensite backend.conf
sudo systemctl reload apache2
sleep 2
clear

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "4. Configuring mariadb-server & Restoring Database SQL ! "
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
#sudo mysql_secure_installation
echo "Finished mysql setup please try to login : "
sudo mysql -u root -p
mysql -u TZH -p db_web_pos < $HOME/pos.linux.dwin/application/db_web_pos.sql
echo "Please check the database is correctly restored or not !"
mysql -u TZH -p 
echo "-=-=-=-=-=-=-==-=-=-==-=-"
echo "Beyond Deployment......"

sudo a2enmod rewrite
sudo a2enmod headers
sudo systemctl restart apache2
sudo apachectl configtest

echo "BYE BYE !......"
clear
