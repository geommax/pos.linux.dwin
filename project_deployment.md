## Project Deployments

```
mkdir /{backend,frontend}
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