## App Deployment Staging Version 

##

### 1. Web & API Deployments

1.1
> copy apache2_sites-availiable/*.conf directory /etc/apache2/site-saviliable/

1.2
> copy frontend.zip and extract with www-data:www-data ownership with 755 permissions including recursive items.

1.3
> copy backend.zip and extract as the same step with frontend.zip.

1.4 : restore db_web_pos.sql


```bash
sudo mariadb -u root -p
```

```bash
sudo mysql_secure_installation

...bash
Set the root password.
Remove anonymous users.
Disallow root login remotely.
Remove test databases.
Reload privilege tables.
....
...
..
.

```

```bash
sudo mysql -u root -p
```

```bash
CREATE DATABASE db_web_pos;
```

```query
CREATE USER 'TZH'@'localhost' IDENTIFIED BY 'password';
```
```bash
GRANT ALL PRIVILEGES ON db_web_pos.* TO 'TZH'@'localhost';
```
```bash
FLUSH PRIVILEGES;
```
```bash
EXIT;
```

```bash
mysql -u TZH -p db_web_pos < db_web_pos.sql
```
---


##

### 2. System Setup (reference to README.md) 
##

### 3. apache related commands

```bash
sudo apt install php8.4-cli php8.4-fpm php8.4-mysql php8.4-curl php8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-gd php8.4-json php8.4-tokenizer php8.4-opcache php8.4-readline php8.4-common mariadb-server apache2 
```


```bash
sudo a2ensite frontend.conf
```
```bash
sudo a2ensite backend.conf
```
```bash
sudo a2enmod rewrite
```
```bash
sudo systemctl restart apache2
```
```bash
sudo nano /etc/hosts
```
```bash
127.0.0.1   frontend.local
```
```bash
127.0.0.1   backend.local
```
```bash
sudo ln -s /var/www/html/backend/storage/app/public /var/www/html/backend/public/storage
```
```bash
ls -l /var/www/html/backend/public/
```

### 4. php related commands

```
sudo a2enmod php8.4
```

```
sudo systemctl restart apache2
```

### 🚀 5. Installation of Required Dependencies 


PHP 8.4 on Debian 11 (Bullseye) for the ARM64 architecture, the repository maintained by Ondřej Surý, 

1. **Add the SURY Repository**:


   ```bash
   sudo apt-get update
   sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
   ```


   ```bash
   sudo curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
   echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
   ```
   ```bash
   sudo apt-get update
   ```
   
   ```bash
   sudo apt-get install php8.4-fpm
   ```

   Ensure the PHP-FPM service is running:

   ```bash
   sudo systemctl start php8.4-fpm
   sudo systemctl enable php8.4-fpm
   ```


### 6. Loggin and Monitoring



