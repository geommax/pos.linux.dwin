#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
USER="kiosk"
KIOSK_URL="http://localhost"
AUTOSTART_DIR="/home/$USER/.config/autostart"
CHROMIUM_DESKTOP_FILE="$AUTOSTART_DIR/chromium-kiosk.desktop"

# Update and install necessary packages
echo "Updating package list and installing required packages..."
sudo apt update
sudo apt install -y xfce4 chromium xorg unclutter

# Create a new user for the kiosk session if it doesn't exist
if ! id -u "$USER" &>/dev/null; then
    echo "Creating user $USER..."
    sudo adduser --gecos "" --disabled-password "$USER"
    echo "$USER:$USER" | sudo chpasswd
fi

# Set up Chromium autostart for the kiosk user
echo "Setting up Chromium kiosk mode autostart..."
sudo -u "$USER" mkdir -p "$AUTOSTART_DIR"

cat <<EOF | sudo -u "$USER" tee "$CHROMIUM_DESKTOP_FILE" > /dev/null
[Desktop Entry]
Type=Application
Name=Chromium Kiosk
Exec=chromium --kiosk $KIOSK_URL --noerrdialogs --disable-infobars --disable-session-crashed-bubble
X-GNOME-Autostart-enabled=true
EOF

# Disable power management to prevent screen blanking
echo "Disabling power management settings..."
sudo -u "$USER" mkdir -p /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml
cat <<EOF | sudo -u "$USER" tee /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml > /dev/null
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-power-manager" version="1.0">
  <property name="blank-on-ac" type="int" value="0"/>
  <property name="blank-on-battery" type="int" value="0"/>
  <property name="dpms-on-ac-off" type="int" value="0"/>
  <property name="dpms-on-battery-off" type="int" value="0"/>
</channel>
EOF

# Inform the user
echo "Kiosk setup is complete! Reboot the system to apply changes."