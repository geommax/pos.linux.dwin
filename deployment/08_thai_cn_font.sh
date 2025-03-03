#!/bin/bash

# Step 1: Download Noto Sans Myanmar font
echo "Downloading Noto Sans Myanmar font..."
wget https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSansMyanmar/NotoSansMyanmar-Regular.ttf -O /tmp/NotoSansMyanmar-Regular.ttf

# Step 2: Download Noto Sans Thai font
echo "Downloading Noto Sans Thai font..."
wget https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSansThai/NotoSansThai-Regular.ttf -O /tmp/NotoSansThai-Regular.ttf

# Step 3: Download Noto Sans CJK font (for Chinese)
echo "Downloading Noto Sans CJK font..."
wget https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/SimplifiedChinese/NotoSansCJKsc-Regular.otf -O /tmp/NotoSansCJKsc-Regular.otf

# Step 4: Create font directory if it doesn't exist
echo "Creating font directory..."
sudo mkdir -p /usr/local/share/fonts/noto

# Step 5: Move the fonts to the system fonts directory
echo "Installing fonts..."
sudo mv /tmp/NotoSansMyanmar-Regular.ttf /usr/local/share/fonts/noto/
sudo mv /tmp/NotoSansThai-Regular.ttf /usr/local/share/fonts/noto/
sudo mv /tmp/NotoSansCJKsc-Regular.otf /usr/local/share/fonts/noto/

# Step 6: Update font cache
echo "Updating font cache..."
sudo fc-cache -f -v

# Step 7: Configure the system to use Noto Sans fonts as the default
echo "Configuring system to use Noto Sans fonts..."
sudo tee /etc/fonts/local.conf > /dev/null <<EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <!-- Default font configuration for sans-serif -->
    <match target="pattern">
        <test name="family" compare="eq">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>Noto Sans Myanmar</string>
            <string>Noto Sans Thai</string>
            <string>Noto Sans SC</string> <!-- Ensure correct Chinese font -->
        </edit>
    </match>

    <!-- Explicitly set Noto Sans SC for Simplified Chinese -->
    <match target="pattern">
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans SC</string>
        </edit>
    </match>
</fontconfig>
EOL

# Step 8: Rebuild font cache after changes
echo "Rebuilding font cache..."
sudo fc-cache -f -v

# Step 9: Modify the X11 keyboard configuration to add Burmese, Thai, and Chinese
echo "Configuring keyboard layouts (English, Burmese, Thai, Chinese)..."
sudo sed -i 's/XKBLAYOUT=\".*/XKBLAYOUT=\"us,mm,th,cn\"/' /etc/default/keyboard

# Step 10: Set Left Shift + Left Ctrl as the shortcut for switching between layouts
echo "Setting Left Shift + Left Ctrl as keyboard switching shortcut..."
sudo sed -i 's/XKBOPTIONS=\".*/XKBOPTIONS=\"grp:ctrl_shift_toggle\"/' /etc/default/keyboard

# Step 11: Reload the keyboard settings without interactive configuration
echo "Applying new keyboard configuration..."
sudo service keyboard-setup restart
setxkbmap -layout "us,mm,th,cn" -option "grp:ctrl_shift_toggle"

echo "Noto Sans Myanmar, Thai, and Chinese fonts installed and keyboard layout configured successfully with Left Shift + Left Ctrl for switching."

