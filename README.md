# pos.linux.dwin 🚀🚀
> ABOUT : config parameters and automated script for debian 10 - LXDE "Debian GNU/Linux 10 (buster), Rockchip RK3566 EVB2 LP4X V10 Board"

## 🚀 Step 1. install necessary apache2 and MySQL 8.4 LTS Servers 

NOTE: URL 
```
https://www.digitalocean.com/community/tutorials/how-to-install-lamp-stack-on-ubuntu
```
```
sudo apt install apache2
```
https://dev.mysql.com/
https://downloads.mysql.com/archives/community/

> နောက်ဆုံးမှာ maridb ကို သာ အသုံးပြုဖို့ ဆုံးဖြတ်ခဲ့သည်။

> အသေးစိတ်အဖြစ်အပျက်ကို project_deployment တွင်ကြည့်ရန်။

```ဘက်
sudo apt install maridb
```

```ဘက်
sudo mariadb -u root -p
```

> Database administration commands နဲ့ query များကို mariadb_administration.md တွင်ဖတ်ပါ။

## 🚀 Step 2. installing php 8.3 for arm64 

https://github.com/oerdnj/deb.sury.org/issues/2220
https://github.com/oerdnj/deb.sury.org/issues/2176

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

> php7.3.31 သာ repo မှာ ရသေးတာဖြစ်တဲ့အတွက် 8.3 version မရပေမယ့်လည်း အာ့ကောင်နဲ့ပဲ စမ်းကြည့်မယ်။ 

> 8.3 version အတွက် RAW Data များကို project deployments တွင် ကြည့်ရန်။ 

###### Target="Debian GNU/Linux 10 (buster), Rockchip RK3566 EVB2 LP4X V10 Board"

> debian 10 မှာ ပြသနာ တက်နေတဲ့ php8.3 installation အား fix ခြင်း



## 🚀 Step 3. browser kiosk-mode

install ARCH 64 Compatible Browser

```ဘက်
sudo apt install chromium-browser firefox-esr
```

```ဘက်
chromium --kiosk http://localhost
```
```ဘက်
firefox --kiosk http://example.com
```
```ဘက်
vim ~/.config/lxsession/LXDE/autostart
```
```ဘက်
chromium --kiosk http://example.com --disable-infobars --start-fullscreen
```

#### Step 3.1 - unclutter to hide mouse icon (မရသေးပါ။)
```ဘက်
sudo apt install unclutter
```
```ဘက်
unclutter &
```

#### Step 3.2 - Disable screen blanking and power-saving
Add this to ~/.config/lxsession/LXDE/autostart:
```ဘက်
@xset s off
@xset -dpms
@xset s noblank
```
#### Additional Options
You can also include more flags for customization:

```ဘက်
--start-fullscreen (force fullscreen mode).
--disable-infobars (disable info bars).
--incognito (private browsing).
```

```ဘက်
linaro@linaro-alip:~$ cat ~/.config/lxsession/LXDE/autostart 
```
```ဘက်
@lxpanel --profile LXDE
```
> Explaination: Restores the LXDE panel, which might include your WiFi icon and other system indicators.
```ဘက်
@pcmanfm --desktop --profile LXDE
```
> Explaination: Restores desktop management and icons. Include this if you want to see the desktop background or use file manager shortcuts.
```ဘက်
@xscreensaver -no-splash
@chromium --kiosk http://localhost 
```
> ~/.config/lxsession/LXDE/autostart file ထဲမှာ @chromimum --kiosk http://localhost သာထည့်ထားလိုက်တာနဲ့ရပါပြီ။

#### NOTE: Openbox controls window decorations (title bar, buttons). To customize it:
```ဘက်
$ vim ~/.config/openbox/lxde-rc.xml
```

## 🚀 Step 4. Defend input Command Shortcuts to the system

1. Edit Openbox Configuration
The keyboard shortcuts for LXDE are managed in the lxde-rc.xml file.

```ဘက်
vim ~/.config/openbox/lxde-rc.xml
```

2. If the file does not exist, check in the global configuration:

```ဘက်
sudo vim /etc/xdg/openbox/lxde-rc.xml
```

- Solution : autostart မှာ @chromium mode နဲ့ ပဲ run မှာဖြစ်တဲ့အတွက် win + d shortcut ဝင်ရင်တောင် screen အမဲရောင်ပဲ ပေါ်နေမှာဖြစ်ပါတယ်။ ဒါကြောင့် စိတ်ပူစရာမလိုတော့ပါ။ 

- User can use only on browser kiosk environment.

- power ပိတ်ဖို့အတွက်ပဲ ဘယ်နားပိတ်ရမလဲ မသိပါ။

## 🚀 Step 5. Defend Network ports and filtering firewall rules

- do not expose port 80, database ports. 

- bind TCP/22 for ethernet adapter only with specific IP configuration

- host ID နှစ်လုံးပဲရမယ့် subnet ကိုတွက်ပေးပါ။

## 🚀 Step 6. user can use only on browser kiosk environment.

> Core Requirements

- 1. battery status
- 2. poweroff button
- 3. wifi connection web UI
- 4. Ads Tunnel if device can access internet via wifi
- 5. wifi connection management application (linux aarch64)

## 🚀 Step 7. Remove repository source lists

## 🚀 Step 8. Printer Setup X - Printer (compile & install) (over eth, usb)

https://www.xprintertech.com/pos-80-printer-intallation-tutorial-video-on-linux-system-of-ubuntu-version

https://www.alibaba.com/product-detail/XP-T80Q-80mm-Thermal-Receipt-Printers_1600871634631.html

#### Step 8.1. ON AMD64 

Printer_POS-80
Printer_POS-80 (Idle, Accepting Jobs, Not Shared)
Media Size: 80(72mm) * 210 mm

##### Maintenance Purpose

```ဘက်
Administration
Description:	Printer POS-80
Location:	counter
Driver:	XP-80 (grayscale)
Connection:	usb://Printer/POS-80
Defaults:	job-sheets=none, none media=custom_71.97x209.9mm_71.97x209.9mm sides=one-sided
```

#### Step 8.2. ON AARCH64
```ဘက်
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
```

#### Step 8.3. how to check /dev lists for POS 80 printer?
```ဘက်
dmesg | grep -i usb
```
```ဘက်
dmesg -w
```

> ဒီလိုမျိုး ရှိနိုင်တယ်။ /dev/usb/lp0

> expected kernel message output of AARCH64 $ sudo dmesg -w. 

#### Step 8.4. On Native Ubuntu Linux
```ဘက်
[23492.051181] usb 1-2: Product: USB Printer Port
[23492.051183] usb 1-2: Manufacturer: Printer
[23492.064856] usblp 1-2:1.0: usblp1: USB Bidirectional printer dev 6 if 0 alt 0 proto 2 vid 0x1FC9 pid 0x2016
[23492.064903] usbcore: registered new interface driver usblp
[23497.253646] usblp1: removed
[23497.254803] usblp 1-2:1.0: usblp1: USB Bidirectional printer dev 6 if 0 alt 0 proto 2 vid 0x1FC9 pid 0x2016
```

```ဘက်
bot@bot-Vostro-14-3468:~/pos.linux.dwin/Linux_Driver-Xprinter/Linux$ sudo lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 0cf3:e009 Qualcomm Atheros Communications 
Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
Bus 001 Device 003: ID 0bda:5689 Realtek Semiconductor Corp. Integrated Webcam
Bus 001 Device 007: ID 1fc9:2016 NXP Semiconductors USB Printer Port
Bus 001 Device 002: ID 25a7:fa23 Areson Technology Corp 2.4G Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

```ဘက်
dpkg -l | grep cups
```

```ဘက်
bot@bot-Vostro-14-3468:~/pos.linux.dwin/Linux_Driver-Xprinter/Linux$ lsusb -d 1fc9:2016
Bus 001 Device 007: ID 1fc9:2016 NXP Semiconductors USB Printer Port
```

#### Step 8.5. Connection From LAN

> XPrinter : 192.168.123.100

> Computer : 192.168.123.101 . 1 (gateway)

> socket://192.168.123.100:9100 နဲ့ cofigure လုပ်တာ အဆင်ပြေပါတယ်။ ipp, http မရသေးပါ။

#### Step 8.6.Installation 
```ဘက်
bot@bot-Vostro-14-3468:~/pos.linux.dwin$ sudo ./XP-80 
[sudo] password for bot: 
Xprinter
cupsdrv-2.4.0 installer
---------------------------------------

Models included:
                 XP-80

64
Linux
Searching for ServerRoot, ServerBin, and DataDir tags in /etc/cups/cupsd.conf

ServerBin tag not present in cupsd.conf - using default

DataDir tag not present in cupsd.conf - using default

ServerRoot = 
ServerBin  = 
DataDir    = 



11
44
Restarting CUPS
Stopping cups (via systemctl): cups.service.
Starting cups (via systemctl): cups.service.

Go to http://localhost:631, or http://127.0.0.1:631 to manage your printer please!

bot@bot-Vostro-14-3468:~/pos.linux.dwin$ ^C
bot@bot-Vostro-14-3468:~/pos.linux.dwin$ 
```


#### Step 8.7 - PPD File is here 

```ဘက်
bot@bot-Vostro-14-3468:/usr/share/cups/model$ cd XP/
bot@bot-Vostro-14-3468:/usr/share/cups/model/XP$ ls
XP-80.ppd
bot@bot-Vostro-14-3468:/usr/share/cups/model/XP$ cd ..
bot@bot-Vostro-14-3468:/usr/share/cups/model$ cd xprinter/
bot@bot-Vostro-14-3468:/usr/share/cups/model/xprinter$ ls
 XP-230H.ppd    XP-318BM.ppd     XP-D3601B.ppd    XP-D8502B.ppd          XP-P3301B.ppd   XP-Q374U.ppd    XP-T375U.ppd     XP-T8103E.ppd
 XP-233B.ppd    XP-318B.ppd      XP-D3602B.ppd    XP-D8503B.ppd          XP-P3301E.ppd   XP-Q375U.ppd    XP-T41001E.ppd   XP-T81B.ppd
 XP-233H.ppd    XP-320B.ppd      XP-D3603B.ppd   'XP-DT108A LABEL.ppd'   XP-P3302B.ppd   XP-T201FD.ppd   XP-T41002E.ppd   XP-T81E.ppd
 XP-233Q.ppd    XP-323B.ppd      XP-D3604B.ppd   'XP-DT108B LABEL.ppd'   XP-P3302E.ppd   XP-T201F.ppd    XP-T41003E.ppd   XP-T81.ppd
```

#### Step 8.8 - Solution using Socket Protocol

```ဘက်
Description:	ETH
Location:	
Connection:	socket://192.168.123.100:9100
Sharing:	Do Not Share This Printer
Make:	XP 
Model:	Current Driver - XP-80XP-80 (en)
```
#### NOTE: USB နဲ့ မရပါဘူး, ETH နဲ့ ပဲ ip config ချပြီး connection ရယူလိုက်တာပါ။ USB နဲ့က လိုအပ်တဲ့ power voltage မလုံလောက်ဘူး၊ bad usb cable ဆိုပြီး kernel error message တက်တာပါ။


```ဘက်
dmesg -w
```

```ဘက်
[ 3935.629014] usb 2-1: new high-speed USB device number 30 using ehci-platform
[ 3937.155860] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 3938.669071] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 3938.669256] usb usb2-port1: attempt power cycle
[ 3940.255630] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
```

## 🚀 Step 9. On PROD DWIN LCD

#### Step 9.1 - Install XP-80 Printer & check 
```ဘက်
linaro@linaro-alip:~$ sudo ./XP-80 
Xprinter
cupsdrv-2.4.0 installer
---------------------------------------

Models included:
                 XP-80

64
Linux
Searching for ServerRoot, ServerBin, and DataDir tags in /etc/cups/cupsd.conf

ServerBin tag not present in cupsd.conf - using default

DataDir tag not present in cupsd.conf - using default

ServerRoot = 
ServerBin  = 
DataDir    = 



11
44
Restarting CUPS
[ ok ] Stopping cups (via systemctl): cups.service.
[ ok ] Starting cups (via systemctl): cups.service.

Go to http://localhost:631, or http://127.0.0.1:631 to manage your printer please!
```

#### Step 9.2 - Check Printer ppd file is exists.
```ဘက်
linaro@linaro-alip:~$ ls /usr/share/cups/model/
XP  xprinter
linaro@linaro-alip:~$ ls /usr/share/cups/model/XP/
XP-80.ppd
linaro@linaro-alip:~$ 
```

#### Step 9.3 - Configure CUPS configuration as the same steps as Step 8.8. Done...

modify Printer configuration

```ဘက်
http://localhost:631/printers/POS-80
```

## 🚀 Step 10. Browser MM Fonts Support, Wifi Application, Logout application , Print Test From Browser not cups service.


### Step 10.1 Printer Mangement Applications

> Browser မှာ Printing From System Dialog ဖွင့်ပြီး print ထုတ်ရင်တော့ရပါတယ်။ (Ctl + Shift + p)


### Step 10.2 Wifi Application

```ဘက်
sudo apt install network-manager network-manager-gnome
```

```ဘက်
echo "@nm-applet" >> ~/.config/lxsession/LXDE/autostart
```

### Step 10.3 Logout, Restart, Poweroff Utility

> TODO 

### Step 10.4 Browser Myanmar Language Support
```ဘက်
sudo apt install fonts-noto fonts-noto-cjk fonts-noto-color-emoji
```
```ဘက်
sudo apt install fonts-padauk
```
```ဘက်
Repo ထဲက Paduk-5.100.zip ကို ဖြည်ပြီး installation လုပ်နိုင်ပါတယ်။ မလုပ်ကြည့်ရသေးပါ။ အပေါ်က fonts-noto သွင်းပြီးတာနဲ့ browser မှာ တန်းပြီး Myanmar စာ ရသွားပါတယ်။
```
##### NOTE : URL 
```ဘက်
https://software.sil.org/padauk/download/
```
```ဘက်
sudo locale-gen my_MM.UTF-8
```
```ဘက်
sudo update-locale LANG=my_MM.UTF-8
```

## 🚀 Step 11. Change Boot Logo 

> TODO 

## 🚀 Step 11. Using SIM Card Module

> Wifi Chip RTL8723DS

## 🚀 Step 12. Analysis Push Button Function and Hardware Structure

## 🚀 Step 13. Project Deployment Manual ( LINK to new md file )
