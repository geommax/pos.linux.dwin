# pos.linux.dwin
config parameters and automated script for debian 10 - LXDE 

> install necessary apache2 and maridb from the manual pdf file

##### installing php 8.3 for arm64 

https://github.com/oerdnj/deb.sury.org/issues/2220
https://github.com/oerdnj/deb.sury.org/issues/2176


#### Target="Debian GNU/Linux 10 (buster), Rockchip RK3566 EVB2 LP4X V10 Board"

> debian 10 မှာ ပြသနာ တက်နေတဲ့ php8.3 installation အား fix ခြင်း


Download PHP 8.3 Core and Extensions
https://packages.sury.org/php/dists/bullseye/

https://packages.sury.org/php/pool/main/p/php8.3/

> core packages for php backend.

- sdfd


Extension	Purpose	Download URL Pattern
php8.3-cli	Run PHP scripts from the command line.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-cli_<version>_arm64.deb
php8.3-mysql	MySQL database support.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-mysql_<version>_arm64.deb
php8.3-common	Common files for PHP.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-common_<version>_arm64.deb
php8.3-fpm	FastCGI Process Manager for PHP.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-fpm_<version>_arm64.deb
php8.3-xml	XML support.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-xml_<version>_arm64.deb
php8.3-curl	CURL support for API integrations.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-curl_<version>_arm64.deb
php8.3-zip	ZIP handling for file compression.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-zip_<version>_arm64.deb
php8.3-mbstring	Multibyte string functions.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-mbstring_<version>_arm64.deb
php8.3-bcmath	For arithmetic calculations in Laravel.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-bcmath_<version>_arm64.deb
php8.3-tokenizer	Required for Laravel blade templates.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-tokenizer_<version>_arm64.deb
php8.3-intl	Internationalization functions.	https://packages.sury.org/php/pool/main/p/php8.3/php8.3-intl_<version>_arm64.deb



### browser kiosk-mode

chromium --kiosk http://localhost

### Defend input Command Shortcuts to the system


### user can use only on browser kiosk environment.
