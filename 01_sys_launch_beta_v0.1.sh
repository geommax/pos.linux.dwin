#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
USER="linaro"
KIOSK_URL="https://youtube.com"
AUTOSTART_DIR="/home/$USER/.config/autostart"
TOUCHSCREEN_FLAGS="--touch-events=enabled --overscroll-history-navigation=enabled --force-device-scale-factor=1"
TIMEZONE="Asia/Yangon"

# Function to change system language
set_system_language() {
  echo "Changing system language to English (en_US.UTF-8)..."
  echo 'LANG=en_US.UTF-8' | sudo tee /etc/default/locale > /dev/null
  echo 'LC_ALL=en_US.UTF-8' | sudo tee -a /etc/default/locale > /dev/null
  echo 'LANGUAGE=en_US.UTF-8' | sudo tee -a /etc/default/locale > /dev/null
  sudo locale-gen
  echo "System Language is changed ! "
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
}

# Function to set timezone and enable NTP
set_timezone() {
  echo "Setting system timezone to $TIMEZONE..."
  sudo timedatectl set-timezone "$TIMEZONE"
  echo "Synchronizing system date and time..."
  ##sudo apt-get install -y ntp
  sudo service ntp start
  ##sudo timedatectl set-ntp true
  echo "System timezone is changed to $TIMEZONE..."
  echo "Current Date & Time is " 
  date
  sleep 3;
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
}

# Function to install Myanmar fonts and keyboard configuration
install_myanmar_fonts_and_keyboard() {
  echo "Installing Myanmar fonts and configuring keyboard..."
  sudo tee -a /etc/apt/sources.list > /dev/null <<EOF
deb http://ftp.de.debian.org/debian sid main
EOF
  sudo apt update
  sudo apt install -y fonts-myanmar
  sudo tee /etc/default/keyboard > /dev/null <<EOF
# KEYBOARD CONFIGURATION FILE
XKBMODEL="pc105"
XKBLAYOUT="us,mm"
XKBVARIANT=","
XKBOPTIONS="grp:alt_shift_toggle,terminate:ctrl_alt_bksp,grp_led:scroll"
BACKSPACE="guess"
EOF
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
  echo "enter ko pae press twar par !.."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
  sleep 3;
  sudo dpkg-reconfigure keyboard-configuration
  sudo systemctl restart keyboard-setup
}

# Function to configure XFCE4
setup_xfce4() {
  echo "Setting up XFCE4 configuration..."
  sudo -u "$USER" rm -r /home/$USER/.config/xfce4
  sudo -u "$USER" cp -rv ./xfce4 /home/$USER/.config/
  sudo -u "$USER" cp -rv wallpaper.png /home/$USER/
  echo "XFCE4 is finished successfully !..."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
}

# Function to set up kiosk mode
setup_kiosk_mode() {
  echo "Setting up Chromium kiosk mode autostart..."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
  sudo -u "$USER" mkdir -p "$AUTOSTART_DIR"
  cat <<EOF | sudo -u "$USER" tee "$AUTOSTART_DIR/chromium-kiosk.desktop" > /dev/null
[Desktop Entry]
Type=Application
Name=Chromium Kiosk
Exec=chromium --kiosk $KIOSK_URL --noerrdialogs --disable-infobars --disable-session-crashed-bubble $TOUCHSCREEN_FLAGS
X-GNOME-Autostart-enabled=true
EOF

  echo "Disabling power management settings..."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
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

  echo "Disabling mouse cursor..."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
  sudo apt install libglib2.0-bin unclutter -y
  echo "CLUTTER_CURSOR_SIZE=0" | sudo tee -a /etc/environment
  cat <<EOF | sudo -u "$USER" tee "$AUTOSTART_DIR/unclutter.desktop" > /dev/null
[Desktop Entry]
Type=Application
Name=Unclutter
Exec=unclutter -idle 0
X-GNOME-Autostart-enabled=true
EOF
}

# Main execution
main() {
  set_system_language
  set_timezone
  install_myanmar_fonts_and_keyboard
  setup_xfce4
  setup_kiosk_mode
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
  echo " Right Click Function ko close par !.."
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
  echo "Setup is complete! Reboot the system to apply changes. (y/n)"
  read -r REBOOT
  if [[ $REBOOT == "y" || $REBOOT == "Y" ]]; then
    sudo reboot
  else
    echo "Reboot skipped. Please reboot manually to apply changes."
  fi
}

main
