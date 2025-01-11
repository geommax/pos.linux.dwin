## Project Deployments Version 2 (Beta Test on Debian 11 Bulleye)

## 🚀 Step 1. Fronend Deployment

```
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/frontend
    ServerName example.com

    <Directory /var/www/html/frontend>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/backend/public
    ServerName api.example.com

    <Directory /var/www/html/backend/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```


php8.4-mysql
php8.4-fpm

sudo apt install php8.4-cli php8.4-fpm php8.4-mysql php8.4-curl php8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-gd php8.4-json php8.4-tokenizer php8.4-opcache php8.4-readline php8.4-common


bot@bot-Vostro-14-3468:/var/www/html/backend$ sudo ln -s /var/www/html/backend/storage/app/public /var/www/html/backend/public/storage
bot@bot-Vostro-14-3468:/var/www/html/backend$ ls -l /var/www/html/backend/public/
total 8
-rwxr-xr-x 1 www-data www-data    0 Jan 11 11:18 favicon.ico
-rwxr-xr-x 1 www-data www-data 1710 Jan 11 11:18 index.php
-rwxr-xr-x 1 www-data www-data   24 Jan 11 11:18 robots.txt
lrwxrwxrwx 1 root     root       40 Jan 11 13:29 storage -> /var/www/html/backend/storage/app/public
