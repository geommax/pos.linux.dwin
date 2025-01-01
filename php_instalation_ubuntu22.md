[Debian oldstable and stable packages are provided as well: https://deb.sury.org/#debian-dpa](https://deb.sury.org/#debian-dpa)

```
sudo cp -r /var/www/html/frontend /var/www/html/
sudo chown -R www-data:www-data /var/www/html/frontend
sudo chmod -R 755 /var/www/html/frontend
sudo cp -r /var/www/html/backend /var/www/html/
sudo chown -R www-data:www-data /var/www/html/backend
sudo chmod -R 755 /var/www/html/backend
```

```bash
bot@bot-Vostro-14-3468:/etc/apache2/sites-available$ cat backend.conf 
<VirtualHost *:80>
    ServerName backend.local
    DocumentRoot /var/www/html/backend/public
    <Directory /var/www/html/backend/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
bot@bot-Vostro-14-3468:/etc/apache2/sites-available$ cat frontend.conf 
<VirtualHost *:80>
    ServerName frontend.local
    DocumentRoot /var/www/html/frontend
    <Directory /var/www/html/frontend>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
bot@bot-Vostro-14-3468:/etc/apache2/sites-available$
```

```
sudo a2ensite frontend.conf
sudo a2ensite backend.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo nano /etc/hosts
127.0.0.1   frontend.local
127.0.0.1   backend.local
```

### **2. Update PHP for the Web Server**
Ensure your web server is using PHP 8.4.

#### For Apache:
1. Disable the older PHP version:
   ```bash
   sudo a2dismod php8.1
   ```

2. Enable PHP 8.4:
   ```bash
   sudo a2enmod php8.4
   ```

3. Restart Apache:
   ```bash
   sudo systemctl restart apache2
   ```

#### For Nginx:
1. Update the `fastcgi_pass` directive in your Nginx configuration to point to PHP 8.4:
   ```nginx
   location ~ \.php$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass unix:/run/php/php8.4-fpm.sock;
   }
   ```

2. Restart Nginx and PHP-FPM:
   ```bash
   sudo systemctl restart php8.4-fpm
   sudo systemctl restart nginx
   ```

---

### **3. Ensure Composer Uses PHP 8.4**
Verify the PHP version Composer uses:
```bash
composer -vvv about
```
If it shows an older PHP version, explicitly use PHP 8.4 with Composer:
```bash
php8.4 /usr/local/bin/composer install
```

---

### **4. Update Composer Dependencies**
Once your PHP version is set to 8.4:
1. Clear the Composer cache:
   ```bash
   composer clear-cache
   ```

2. Update Composer dependencies:
   ```bash
   composer update
   ```

---

### **5. Debug the Issue**
If the error persists:
1. Open the `platform_check.php` file mentioned in the error:
   ```bash
   sudo nano /var/www/html/backend/vendor/composer/platform_check.php
   ```

2. Inspect the PHP version check logic. It might look like this:
   ```php
   if (!(PHP_VERSION_ID >= 80200)) {
       fwrite(STDERR, "Your Composer dependencies require a PHP version \">= 8.2.0\". You are running " . PHP_VERSION . ".\n");
       exit(1);
   }
   ```
3. Do not modify this file directly. Instead, resolve the root cause by ensuring the correct PHP version is used.

---

### **6. Restart Services**
After updating PHP and Composer dependencies, restart all relevant services:
```bash
sudo systemctl restart apache2
sudo systemctl restart php8.4-fpm
```

---

### **7. Verify the Setup**
- Recheck `phpinfo.php` in your backend's public directory to ensure PHP 8.4 is active.
- Re-run Composer to ensure no further errors occur:
  ```bash
  php8.4 /usr/local/bin/composer install
  ```

