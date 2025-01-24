#!/bin/bash

KIOSK_URL="http://frontend.local"
AUTOSTART_DIR="/home/$USER/.config/autostart"
TOUCHSCREEN_FLAGS="--touch-events=enabled --overscroll-history-navigation=enabled --force-device-scale-factor=0.75"

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
  setup_xfce4
  setup_kiosk_mode
}

main