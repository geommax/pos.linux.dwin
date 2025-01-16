# Description: This script sets up the system language, timezone, and keyboard input method for Myanmar.
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
TIMEZONE="Asia/Yangon"  # Set timezone to Myanmar

# Update and install necessary packages
echo "Updating package list and installing required packages..."
sudo apt update
#sudo apt install -y language-pack-my fonts-noto myanmar-keyboard-setup ntp locales


# RAW

sudo apt install ibus ibus-m17n fonts-noto-cjk


# Set system timezone to Myanmar
echo "Setting system timezone to $TIMEZONE..."
sudo timedatectl set-timezone $TIMEZONE

# Sync system time with NTP
echo "Synchronizing system date and time..."
sudo service ntp start
sudo timedatectl set-ntp true

# Change system language to English (en_US.UTF-8)
echo "Changing system language to English (en_US.UTF-8)..."
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
sudo dpkg-reconfigure locales


# Set up Myanmar language and input method
echo "Setting up Myanmar language and locale..."
sudo update-locale LANG=my_MM.UTF-8
echo "Configuring Myanmar Keyboard input method..."
sudo dpkg-reconfigure myanmar-keyboard-setup
echo "Myanmar language and keyboard input setup complete!"
echo "System date and time have been synchronized."
echo "System language set to English (en_US.UTF-8)."

