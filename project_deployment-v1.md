## Project Deployments Version 1 (Beta Test on Debian 10 Buster)

## 🚀 Step 1. Fronend Deployment

```ဘက်
sudo apt install apache2
```
```ဘက်
sudo apt install apache2 php libapache2-mod-php php-cli php-mbstring php-xml php-bcmath unzip
```
Installation Log

```ဘက်

Creating config file /etc/php/7.3/mods-available/bcmath.ini with new version
Setting up php-bcmath (2:7.3+69) ...
Processing triggers for libapache2-mod-php7.3 (7.3.31-1~deb10u7) ...
Processing triggers for php7.3-fpm (7.3.31-1~deb10u7) ...
NOTICE: Not enabling PHP 7.3 FPM by default.
NOTICE: To enable PHP 7.3 FPM in Apache2 do:
NOTICE: a2enmod proxy_fcgi setenvif
NOTICE: a2enconf php7.3-fpm
NOTICE: You are seeing this message because you have apache2 package installed.

```

> PHP နဲ့ ပတ်သက်တဲ့ installation တွေကတော့ 
#### Install PHP and MySQL Extensions:
```ဘက်
sudo apt install -y php php-mysql php-cli php-xml php-curl php-mbstring php-zip libapache2-mod-php
```

Verify PHP:
```ဘက်
php -v
```
```ဘက်
linaro@linaro-alip:/usr/share$ php -v
PHP 7.3.31-1~deb10u7 (cli) (built: Jun 17 2024 21:48:38) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.31, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.3.31-1~deb10u7, Copyright (c) 1999-2018, by Zend Technologies
linaro@linaro-alip:/usr/share$ 
```

> php7.3.31 သာ repo မှာ ရသေးတာဖြစ်တဲ့အတွက် 8.3 version မရပေမယ့်လည်း အာ့ကောင်နဲ့ပဲ စမ်းကြည့်မယ်။

##### NOTE : ERROR on PHP 7.3

```
linaro@linaro-alip:~/backend$ php artisan serve
Composer detected issues in your platform:

Your Composer dependencies require a PHP version ">= 8.2.0". You are running 7.3.31-1~deb10u7.

PHP Fatal error:  Composer detected issues in your platform: Your Composer dependencies require a PHP version ">= 8.2.0". You are running 7.3.31-1~deb10u7. in /home/linaro/backend/vendor/composer/platform_check.php on line 24
```

> debian 10 မှာ ပြသနာ တက်နေတဲ့ php8.3 installation အား fix ခြင်း

> PHP 8.3 ကို Repo မှ ဆွဲလို့မရတဲ့အတွက် manual installation စလုပ်ဖို့ကြံရွယ်ပါတယ်။ (VPN လိုနေတာပါ လီးး။)

#### Step 1.1 Manual Installation of PHP 8.3 =< version

Resource Link 

```
https://deb.sury.org/
https://packages.sury.org/
https://launchpad.net/~ondrej/+archive/ubuntu/php/
```

required deb list

```
-
-
-
-

```

## 🚀 Step 2. Backend Deployment

https://dev.mysql.com/
https://downloads.mysql.com/archives/community/

> နောက်ဆုံးမှာ maridb ကို သာ အသုံးပြုဖို့ ဆုံးဖြတ်ခဲ့သည်။

> အသေးစိတ်အဖြစ်အပျက်ကို project_deployment တွင်ကြည့်ရန်။

```ဘက်
sudo apt install maridb
```

```ဘက်
sudo mariadb -u root -p
```

> Database administration commands နဲ့ query များကို mariadb_administration.md တွင်ဖတ်ပါ။





