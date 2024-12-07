# pos.linux.dwin
#### ABOUT : config parameters and automated script for debian 10 - LXDE 

## Step 1. install necessary apache2 and maridb from the manual pdf file

## Step 2. installing php 8.3 for arm64 

https://github.com/oerdnj/deb.sury.org/issues/2220
https://github.com/oerdnj/deb.sury.org/issues/2176


###### Target="Debian GNU/Linux 10 (buster), Rockchip RK3566 EVB2 LP4X V10 Board"

> debian 10 မှာ ပြသနာ တက်နေတဲ့ php8.3 installation အား fix ခြင်း


###### Download PHP 8.3 Core and Extensions
https://packages.sury.org/php/dists/bullseye/

https://packages.sury.org/php/pool/main/p/php8.3/

> core packages for php backend.

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



## Step 3. browser kiosk-mode

> $ chromium --kiosk http://localhost

> $ vim ~/.config/lxsession/LXDE/autostart

> $ chromium --kiosk http://example.com --disable-infobars --start-fullscreen

##### Additional Options
You can also include more flags for customization:

--start-fullscreen (force fullscreen mode).
--disable-infobars (disable info bars).
--incognito (private browsing).

linaro@linaro-alip:~$ cat ~/.config/lxsession/LXDE/autostart 

@lxpanel --profile LXDE
> Explaination: Restores the LXDE panel, which might include your WiFi icon and other system indicators.

@pcmanfm --desktop --profile LXDE
> Explaination: Restores desktop management and icons. Include this if you want to see the desktop background or use file manager shortcuts.

@xscreensaver -no-splash
@chromium --kiosk http://localhost 

> ~/.config/lxsession/LXDE/autostart file ထဲမှာ @chromimum --kiosk http://localhost သာထည့်ထားလိုက်တာနဲ့ရပါပြီ။

#### NOTE: Openbox controls window decorations (title bar, buttons). To customize it:
> vim ~/.config/openbox/lxde-rc.xml


## Step 4. Defend input Command Shortcuts to the system

1. Edit Openbox Configuration
The keyboard shortcuts for LXDE are managed in the lxde-rc.xml file.

> vim ~/.config/openbox/lxde-rc.xml

2. If the file does not exist, check in the global configuration:

> sudo vim /etc/xdg/openbox/lxde-rc.xml

- Solution : autostart မှာ @chromium mode နဲ့ ပဲ run မှာဖြစ်တဲ့အတွက် win + d shortcut ဝင်ရင်တောင် screen အမဲရောင်ပဲ ပေါ်နေမှာဖြစ်ပါတယ်။ ဒါကြောင့် စိတ်ပူစရာမလိုတော့ပါ။ 

- User can use only on browser kiosk environment.

- power ပိတ်ဖို့အတွက်ပဲ ဘယ်နားပိတ်ရမလဲ မသိပါ။

## Step 5. Defend Network ports and filtering firewall rules

- do not expose port 80, database ports. 

- bind TCP/22 for ethernet adapter only with specific IP configuration

- host ID နှစ်လုံးပဲရမယ့် subnet ကိုတွက်ပေးပါ။

## Step 6. user can use only on browser kiosk environment.

> Core Requirements

- 1. battery status
- 2. poweroff button
- 3. wifi connection web UI
- 4. Ads Tunnel if device can access internet via wifi
- 5. wifi connection management application (linux aarch64)

## Step 7. Remove repository source lists

## Step 8. Printer Setup X - Printer (compile & install) (over wifi, usb)

https://www.xprintertech.com/pos-80-printer-intallation-tutorial-video-on-linux-system-of-ubuntu-version

https://www.alibaba.com/product-detail/XP-T80Q-80mm-Thermal-Receipt-Printers_1600871634631.html

#### ON AMD64 
Printer_POS-80
Printer_POS-80 (Idle, Accepting Jobs, Not Shared)

Maintenance
 
Administration
Description:	Printer POS-80
Location:	counter
Driver:	XP-80 (grayscale)
Connection:	usb://Printer/POS-80
Defaults:	job-sheets=none, none media=custom_71.97x209.9mm_71.97x209.9mm sides=one-sided
> =-=-=-=-=-=-=-=-=-
#### ON AARCH64
linlin@linaro-alip:~$ sudo dpkg -i printer-driver-xprinter_3.13.3_all.deb 
(Reading database ... 85163 files and directories currently installed.)
Preparing to unpack printer-driver-xprinter_3.13.3_all.deb ...
Unpacking printer-driver-xprinter (3.13.3) over (3.13.3) ...
Setting up printer-driver-xprinter (3.13.3) ...
CPU_BITS: 64
SYS_NAME: Linux
CPU_ARCH: aarch64
USB device 0x2D37 already configured!
USB device 0x2D84 already configured!
Driver success installed!
Please navigate to http://localhost:631/ for manage your printers.
> =-=-=-=-=-=-=-=-=-

##### how to check /dev lists for POS 80 printer?
> dmesg | grep -i usb

> dmesg -w

> ဒီလိုမျိုး ရှိနိုင်တယ်။ /dev/usb/lp0







## Step 9. Using SIM Card Module

## Step 10. Push Button Function and Hardware Structure

