## 🚀 PHP-related modules: (PHP 8.4 and apache 2) 🚀

To install PHP 8.4 on Debian 11 (Bullseye) for the ARM64 architecture, you can use the repository maintained by Ondřej Surý, which provides up-to-date PHP packages for Debian systems. Here's how to set it up:

1. **Add the SURY Repository**:

   First, ensure your system is updated and that necessary packages for adding repositories are installed:

   ```bash
   sudo apt-get update
   sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
   ```

   Next, import the repository's GPG key and add the repository to your system:

   ```bash
   sudo curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
   echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
   ```

   After adding the repository, update your package list:

   ```bash
   sudo apt-get update
   ```

   

2. **Install PHP 8.4**:

   With the repository added, you can install PHP 8.4 along with commonly used extensions. Replace `[extension]` with any specific extensions you require:

   ```bash
   sudo apt-get install php8.4 php8.4-[extension]
   ```

   For example, to install PHP 8.4 with the `cli`, `mbstring`, `xml`, `common`, and `curl` extensions:

   ```bash
   sudo apt-get install php8.4-cli php8.4-mbstring php8.4-xml php8.4-common php8.4-curl
   ```

   

3. **Verify the Installation**:

   After installation, confirm that PHP 8.4 is installed by checking its version:

   ```bash
   php -v
   ```

   You should see output indicating that PHP 8.4 is installed.

   

4. **Configure PHP-FPM (Optional)**:

   If you're using PHP with a web server like Nginx or Apache, consider installing and configuring PHP-FPM:

   ```bash
   sudo apt-get install php8.4-fpm
   ```

   Ensure the PHP-FPM service is running:

   ```bash
   sudo systemctl start php8.4-fpm
   sudo systemctl enable php8.4-fpm
   ```

   Configure your web server to use PHP 8.4-FPM by updating its configuration files accordingly.

   

**Note**: While the SURY repository is widely used and trusted, it's maintained by a third party. Always ensure that adding external repositories aligns with your system's security policies.

By following these steps, you should have PHP 8.4 installed on your Debian 11 ARM64 system. 