## 🚀 PHP-related modules: (PHP 8.4 and apache 2) 🚀

---

#### Download PHP 8.3 Core and Extensions
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


### **Core PHP Modules**
- **`php8.4-cli`**: Command-line interface for PHP  
- **`php8.4-fpm`**: FastCGI Process Manager for PHP (if using NGINX or FastCGI)  
- **`php8.4-common`**: Base files and libraries for PHP  
- **`php8.4-mysql`**: MySQL database integration  
- **`php8.4-xml`**: Support for XML, SimpleXML, DOM, etc.  
- **`php8.4-curl`**: For data transfer via URLs (cURL library)  
- **`php8.4-zip`**: ZIP archive support  
- **`php8.4-mbstring`**: Multibyte string processing for encoding  
- **`php8.4-intl`**: Internationalization functions (locale support)  
- **`php8.4-bcmath`**: Arbitrary precision mathematics library  
- **`php8.4-gd`**: Image processing library  

---

### **For Web Applications**
- **`php8.4-json`**: JSON support (commonly required for APIs)  
- **`php8.4-opcache`**: Opcode caching to improve performance  
- **`php8.4-redis`**: Redis caching and database module  
- **`php8.4-sqlite3`**: SQLite database support  
- **`php8.4-soap`**: SOAP web services support  
- **`php8.4-imap`**: IMAP email protocol support  
- **`php8.4-ldap`**: LDAP (Lightweight Directory Access Protocol) support  
- **`php8.4-exif`**: Reading metadata (EXIF) from images  

---

### **Development Tools**
- **`php8.4-xdebug`**: Debugging and profiling tool for PHP development  
- **`php8.4-dev`**: PHP development files for compiling extensions  

---

### **Optional Packages for Apache2**
- **`libapache2-mod-php8.4`**: Apache2 module for PHP integration  

---

### **Installing Missing Modules**

```bash
sudo dpkg -i php8.4*
```
```bash
sudo sudo apt install -f
```
```bash
sudo dpkg -i php8.4*
```
---

### **Verify Installed Modules**
To check which PHP modules are active:
```bash
php -m
```

---
