# Description: This script sets up the system language, timezone, and keyboard input method for Myanmar.
#!/bin/bash


# 1. Change China to Eng LANG
# 2. Change Timezone & Open NTP Enabled
# 3. Add Myanmar Fonts and Keyboard
# 4. xfce4 configuration
# 5. kiosk mode.


# Exit immediately if a command exits with a non-zero status
set -e

# 1. Change system language to English (en_US.UTF-8)
echo "Changing system language to English (en_US.UTF-8)..."
echo 'LANG=en_US.UTF-8' | sudo tee -a /etc/default/locale
echo 'LC_ALL=en_US.UTF-8' | sudo tee -a /etc/default/locale
echo 'LANGUAGE=en_US.UTF-8' | sudo tee -a /etc/default/locale
sudo locale-gen

# 2. Change Timezone & Open NTP Enabled
TIMEZONE="Asia/Yangon"  
# Set system timezone to Myanmar
echo "Setting system timezone to $TIMEZONE..."
sudo timedatectl set-timezone $TIMEZONE

# Sync system time with NTP
echo "Synchronizing system date and time..."
sudo service ntp start
sudo timedatectl set-ntp true

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Update and install necessary packages
echo "Set up Myanmar language and add as an input language..."
sleep 2;
echo "using this link ( https://packages.debian.org/sid/all/fonts-myanmar/download ) to download .."
sudo echo "deb http://ftp.de.debian.org/debian sid main " >> /etc/apt/sources.list
sudo apt update
sudo apt install fonts-myanmar


#=-=-=-=-=-=-=-

sudo nano /etc/default/keyboard

# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us,mm"
XKBVARIANT=","
XKBOPTIONS="grp:alt_shift_toggle,terminate:ctrl_alt_bksp,grp_led:scroll"
BACKSPACE="guess"

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "enter ko pae press twar par !.."
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
sleep 3;

sudo dpkg-reconfigure keyboard-configuration
sudo systemctl restart keyboard-setup
sudo systemctl status keyboard-setup

#=-=-=-=-=-=-=-

echo "Setting up xfce4."
cp -rv ./xfce4 $HOME/.config/xfce4
cp -rv wallpaper.png $HOME/

echo "Reboot Required (y/n)"





