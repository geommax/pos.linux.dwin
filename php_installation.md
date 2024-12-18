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
> Debian 11 နဲ့ 12 ကိုပဲ php 8.4 က support ပေးတာဖြစ်ပါတယ်။ ကိုယ့်ဟာ Debian 10 ဖြစ်နေတော့ လိုက်ညှိရဦးမယ်ပေါ့။ dependencies တွေ သဘောထားကွဲလွှဲချက် ၊ (သူမ ကိုတောင် သတိရသွားတယ်ဗျာ။) နားလိုက်ဦးမယ်။ 

```bash
linaro@linaro-alip:~/php8.4$ ls
php8.4-bcmath_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb  php8.4-intl_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb
php8.4-cli_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb     php8.4-mbstring_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb
php8.4-common_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb  php8.4-mysql_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb
php8.4-curl_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb    php8.4-xml_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb
php8.4-fpm_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb     php8.4-zip_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb
linaro@linaro-alip:~/php8.4$ sudo dpkg -i php8.4-*
Selecting previously unselected package php8.4-bcmath.
(Reading database ... 82983 files and directories currently installed.)
Preparing to unpack php8.4-bcmath_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-bcmath (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-cli.
Preparing to unpack php8.4-cli_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-cli (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-common.
Preparing to unpack php8.4-common_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-common (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-curl.
Preparing to unpack php8.4-curl_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-curl (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-fpm.
Preparing to unpack php8.4-fpm_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-fpm (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-intl.
Preparing to unpack php8.4-intl_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-intl (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-mbstring.
Preparing to unpack php8.4-mbstring_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-mbstring (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-mysql.
Preparing to unpack php8.4-mysql_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-mysql (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-xml.
Preparing to unpack php8.4-xml_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-xml (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Selecting previously unselected package php8.4-zip.
Preparing to unpack php8.4-zip_8.4.1-3+0~20241125.19+debian11~1.gbpda2c03_arm64.deb ...
Unpacking php8.4-zip (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
dpkg: dependency problems prevent configuration of php8.4-cli:
 php8.4-cli depends on php8.4-opcache; however:
  Package php8.4-opcache is not installed.
 php8.4-cli depends on php8.4-readline; however:
  Package php8.4-readline is not installed.
 php8.4-cli depends on libc6 (>= 2.30); however:
  Version of libc6:arm64 on system is 2.28-10+deb10u4.
 php8.4-cli depends on libpcre2-8-0 (>= 10.38); however:
  Version of libpcre2-8-0:arm64 on system is 10.32-5+deb10u1.
 php8.4-cli depends on libsodium23 (>= 1.0.18); however:
  Version of libsodium23:arm64 on system is 1.0.17-1.

dpkg: error processing package php8.4-cli (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-common:
 php8.4-common depends on libffi7 (>= 3.3~20180313); however:
  Package libffi7 is not installed.

dpkg: error processing package php8.4-common (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-curl:
 php8.4-curl depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.

dpkg: error processing package php8.4-curl (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-fpm:
 php8.4-fpm depends on php8.4-cli; however:
  Package php8.4-cli is not configured yet.
 php8.4-fpm depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.
 php8.4-fpm depends on php8.4-opcache; however:
  Package php8.4-opcache is not installed.
 php8.4-fpm depends on libc6 (>= 2.30); however:
  Version of libc6:arm64 on system is 2.28-10+deb10u4.
 php8.4-fpm depends on libpcre2-8-0 (>= 10.38); however:
  Version of libpcre2-8-0:arm64 on system is 10.32-5+deb10u1.
 php8.4-fpm depends on libsodium23 (>= 1.0.18); however:
  Version of libsodium23:arm64 on system is 1.0.17-1.

dpkg: error processing package php8.4-fpm (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-intl:
 php8.4-intl depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.
 php8.4-intl depends on libgcc-s1 (>= 3.0); however:
  Package libgcc-s1 is not installed.
 php8.4-intl depends on libicu67 (>= 67.1-1~); however:
  Package libicu67 is not installed.

dpkg: error processing package php8.4-intl (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-mbstring:
 php8.4-mbstring depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.
 php8.4-mbstring depends on libonig5 (>= 6.8.1); however:
  Package libonig5 is not installed.

dpkg: error processing package php8.4-mbstring (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-mysql:
 php8.4-mysql depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.

dpkg: error processing package php8.4-mysql (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-xml:
 php8.4-xml depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.

dpkg: error processing package php8.4-xml (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-zip:
 php8.4-zip depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.
 php8.4-zip depends on libzip4 (>= 1.7.0); however:
  Version of libzip4:arm64 on system is 1.5.1-4.

dpkg: error processing package php8.4-zip (--install):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of php8.4-bcmath:
 php8.4-bcmath depends on php8.4-common (= 8.4.1-3+0~20241125.19+debian11~1.gbpda2c03); however:
  Package php8.4-common is not configured yet.

dpkg: error processing package php8.4-bcmath (--install):
 dependency problems - leaving unconfigured
Processing triggers for systemd (241-7~deb10u10) ...
Errors were encountered while processing:
 php8.4-cli
 php8.4-common
 php8.4-curl
 php8.4-fpm
 php8.4-intl
 php8.4-mbstring
 php8.4-mysql
 php8.4-xml
 php8.4-zip
 php8.4-bcmath
linaro@linaro-alip:~/php8.4$ sudo apt install -f
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Correcting dependencies... Done
The following packages will be REMOVED:
  php8.4-bcmath php8.4-cli php8.4-common php8.4-curl php8.4-fpm php8.4-intl php8.4-mbstring php8.4-mysql php8.4-xml php8.4-zip
0 upgraded, 0 newly installed, 10 to remove and 48 not upgraded.
10 not fully installed or removed.
After this operation, 28.5 MB disk space will be freed.
Do you want to continue? [Y/n] Y
(Reading database ... 83148 files and directories currently installed.)
Removing php8.4-bcmath (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
WARNING: Module bcmath ini file doesn't exist under /etc/php/8.4/mods-available
WARNING: Module bcmath ini file doesn't exist under /etc/php/8.4/mods-available
Removing php8.4-fpm (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-cli (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-zip (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-xml (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-curl (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-intl (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-mbstring (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-mysql (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...
Removing php8.4-common (8.4.1-3+0~20241125.19+debian11~1.gbpda2c03) ...

```
---

### **Verify Installed Modules**
To check which PHP modules are active:
```bash
php -m
```

---
