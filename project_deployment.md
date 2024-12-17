## Project Deployments

```
mkdir /{backend,frontend}
```

## RAW


###### Download PHP 8.3 Core and Extensions
https://packages.sury.org/php/dists/bullseye/

https://packages.sury.org/php/pool/main/p/php8.3/

> core packages for php backend.

```
Extension   Purpose Download URL Pattern
php8.3-cli  Run PHP scripts from the command line.  https://packages.sury.org/php/pool/main/p/php8.3/php8.3-cli_<version>_arm64.deb
php8.3-mysql    MySQL database support. https://packages.sury.org/php/pool/main/p/php8.3/php8.3-mysql_<version>_arm64.deb
php8.3-common   Common files for PHP.   https://packages.sury.org/php/pool/main/p/php8.3/php8.3-common_<version>_arm64.deb
php8.3-fpm  FastCGI Process Manager for PHP.    https://packages.sury.org/php/pool/main/p/php8.3/php8.3-fpm_<version>_arm64.deb
php8.3-xml  XML support.    https://packages.sury.org/php/pool/main/p/php8.3/php8.3-xml_<version>_arm64.deb
php8.3-curl CURL support for API integrations.  https://packages.sury.org/php/pool/main/p/php8.3/php8.3-curl_<version>_arm64.deb
php8.3-zip  ZIP handling for file compression.  https://packages.sury.org/php/pool/main/p/php8.3/php8.3-zip_<version>_arm64.deb
php8.3-mbstring Multibyte string functions. https://packages.sury.org/php/pool/main/p/php8.3/php8.3-mbstring_<version>_arm64.deb
php8.3-bcmath   For arithmetic calculations in Laravel. https://packages.sury.org/php/pool/main/p/php8.3/php8.3-bcmath_<version>_arm64.deb
php8.3-tokenizer    Required for Laravel blade templates.   https://packages.sury.org/php/pool/main/p/php8.3/php8.3-tokenizer_<version>_arm64.deb
php8.3-intl Internationalization functions. https://packages.sury.org/php/pool/main/p/php8.3/php8.3-intl_<version>_arm64.deb
```


htacess

assets folder ရဲ့ permission စစ်ရန်။


To configure web applications for your POS (Point of Sale) system, here's a general approach based on the directory structure you've shown (with `backend` and `frontend`).

---

### 1. **Backend Configuration (Assuming Laravel or Node.js API)**  
   - **Verify Backend Setup**: 
     - Ensure the `composer.json` file is correctly configured for Laravel or PHP dependencies.
     - Run:
       ```bash
       cd backend
       composer install
       ```
   - **Database Setup**:
     - Check `config/database.php` or equivalent for the database credentials.
     - Run database migrations if Laravel:
       ```bash
       php artisan migrate
       ```
   - **Set Up `.env`** (if Laravel):
     - Copy the `.env.example` file:
       ```bash
       cp .env.example .env
       ```
     - Update database, app key, and other configurations:
       ```bash
       php artisan key:generate
       ```

   - **Test Backend**:
     - Start the backend server:
       ```bash
       php artisan serve
       ```
       If Node.js:
       ```bash
       npm install
       npm start
       ```

---

### 2. **Frontend Configuration (Assuming a Vite/React App)**  
   - **Install Dependencies**:
     ```bash
     cd frontend
     npm install
     ```
   - **Verify Vite Configuration**:
     - Ensure `vite.config.js` points to the correct backend API URL (update `proxy` or `base` options).
   - **Test Frontend Locally**:
     ```bash
     npm run dev
     ```

---

### 3. **Web Server Setup for Production**  
#### **Option 1: Apache (If using LAMP stack)**  
   - Configure `web.config` or `.htaccess` for both `backend` and `frontend`:
     ```bash
     sudo nano /etc/apache2/sites-available/pos-app.conf
     ```
     Sample Apache virtual host config:
     ```apache
     <VirtualHost *:80>
         ServerName yourdomain.com
         DocumentRoot /var/www/html/frontend

         <Directory /var/www/html/frontend>
             AllowOverride All
             Require all granted
         </Directory>

         ProxyPass /api http://127.0.0.1:8000
         ProxyPassReverse /api http://127.0.0.1:8000
     </VirtualHost>
     ```
   - Enable the site and restart Apache:
     ```bash
     sudo a2ensite pos-app
     sudo systemctl restart apache2
     ```

#### **Option 2: Nginx (Preferred for Speed)**  
   - Configure a reverse proxy to handle frontend/backend:
     ```bash
     sudo nano /etc/nginx/sites-available/pos-app
     ```
     Sample Nginx configuration:
     ```nginx
     server {
         listen 80;
         server_name yourdomain.com;

         location / {
             root /var/www/html/frontend;
             try_files $uri /index.html;
         }

         location /api/ {
             proxy_pass http://127.0.0.1:8000;
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
         }
     }
     ```
   - Enable and restart Nginx:
     ```bash
     sudo ln -s /etc/nginx/sites-available/pos-app /etc/nginx/sites-enabled/
     sudo systemctl restart nginx
     ```

---

### 4. **Deployment Checklist**
   - Ensure the following:
     - Backend runs on a separate port or via PHP-FPM.
     - Frontend points to the backend API endpoint.
     - Secure your server with SSL (Let's Encrypt) if in production.
     - Optimize frontend build:
       ```bash
       npm run build
       ```

Let me know if you need further details for your POS application setup!



> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Here’s the streamlined setup tailored for **Apache2** and **MySQL** on your AArch64 Debian Linux system:

---

## **1. Install Apache2, MySQL, and PHP**  
### Update System Packages:
```bash
sudo apt update && sudo apt upgrade -y
```

### Install Apache2:
```bash
sudo apt install -y apache2
```
Verify Apache is running:
```bash
sudo systemctl status apache2
```
Access `http://<server-ip>` to confirm the default Apache page.

### Install MySQL Server:
```bash
sudo apt install -y mysql-server
```
Secure your MySQL installation:
```bash
sudo mysql_secure_installation
```
- Set a root password.
- Remove test databases and anonymous users.
- Disable remote root login.

### Install PHP and MySQL Extensions:
```bash
sudo apt install -y php php-mysql php-cli php-xml php-curl php-mbstring php-zip libapache2-mod-php
```

Verify PHP:
```bash
php -v
```

---

## **2. Configure MySQL Database**  
1. Log in to MySQL:
   ```bash
   sudo mysql -u root -p
   ```
2. Create a database and user for the POS app:
   ```sql
   CREATE DATABASE pos_app;
   CREATE USER 'pos_user'@'localhost' IDENTIFIED BY 'secure_password';
   GRANT ALL PRIVILEGES ON pos_app.* TO 'pos_user'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

---

## **3. Configure Backend (Laravel/PHP)**  
### Setup the Backend Files:
Assuming your backend code is at `/var/www/html/backend`:
```bash
cd /var/www/html/backend
composer install
```

### Set File Permissions:
```bash
sudo chown -R www-data:www-data /var/www/html/backend
sudo chmod -R 775 /var/www/html/backend/storage
```

### Configure `.env`:
Edit the `.env` file:
```bash
cp .env.example .env
nano .env
```
Update these values:
```plaintext
APP_URL=http://<your-server-ip>
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=pos_app
DB_USERNAME=pos_user
DB_PASSWORD=secure_password
```

### Run Migrations:
```bash
php artisan key:generate
php artisan migrate
```

---

## **4. Configure Apache2 for Backend and Frontend**  
1. Create a new Apache virtual host:
   ```bash
   sudo nano /etc/apache2/sites-available/pos-app.conf
   ```

2. Add the following configuration:
   ```apache
   <VirtualHost *:80>
       ServerName your-domain.com
       DocumentRoot /var/www/html/frontend

       <Directory /var/www/html/frontend>
           AllowOverride All
           Require all granted
       </Directory>

       # Backend API
       Alias /api /var/www/html/backend/public
       <Directory /var/www/html/backend/public>
           AllowOverride All
           Require all granted
       </Directory>

       ErrorLog ${APACHE_LOG_DIR}/pos-error.log
       CustomLog ${APACHE_LOG_DIR}/pos-access.log combined
   </VirtualHost>
   ```

3. Enable the site and required modules:
   ```bash
   sudo a2ensite pos-app.conf
   sudo a2enmod rewrite
   sudo systemctl restart apache2
   ```

---

## **5. Configure Frontend**  
Assuming the frontend is built using Vite/React:  
1. Build the production files:
   ```bash
   cd /var/www/html/frontend
   npm install
   npm run build
   ```

2. Ensure the `index.html` is in `/var/www/html/frontend`.

---

## **6. Test the Setup**  
- Visit `http://<server-ip>` for the frontend.  
- Backend API should be accessible at `http://<server-ip>/api`.  
- Verify database connection and API responses.

Let me know if you need help debugging or fine-tuning this setup! 🚀