#!/bin/bash

#--------------------------------------------------------------------
echo "API , Web Version release အသစ်ချိန်းချင်တယ်ဆိုရင် ဒီ အဆင့်များကိုလုပ်ဆောင်ပါ။" 
#--------------------------------------------------------------------
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "2. Copying Web & API Packages to /var/www/html/"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
sleep 2;
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
ls -la /var/www/html/{frontend,backend}
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