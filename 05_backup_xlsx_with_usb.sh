#!/bin/bash

# Allowed USB Serial Number
USB_SERIAL="0721341F8E98BB06"

# Mount point
MOUNT_POINT="$HOME/report_backup"

# Source directory
SOURCE_DIR="$HOME/Downloads"
EXTENSIONS=("xlsx" "csv" "backup")
USB_DEVICE="sdb1"

# Function to flash red screen
flash_red_screen() {
    for i in {1..5}; do
        xrandr --output $(xrandr | grep " connected" | awk '{print $1}') --gamma 1:0:0
        sleep 0.2
        xrandr --output $(xrandr | grep " connected" | awk '{print $1}') --gamma 1:1:1
        sleep 0.2
    done
}

# Detect USB by serial number
if ! lsusb -v 2>/dev/null | grep  "$USB_SERIAL"; then
    echo "Allowed USB not found!"
    exit 1
fi

mkdir -p "$MOUNT_POINT"
sudo mount "/dev/$USB_DEVICE" "$MOUNT_POINT"

if [[ $? -ne 0 ]]; then
    echo "Failed to mount USB!"
    exit 1
fi

# Remove existing backup files in USB
echo "Removing old backup files in USB..."
for ext in "${EXTENSIONS[@]}"; do
    find "$MOUNT_POINT" -type f -name "*.$ext" -exec rm -f {} \;
done

# Copy files and verify
COPY_SUCCESS=true

for ext in "${EXTENSIONS[@]}"; do
    for file in "$SOURCE_DIR"/*.$ext; do
        [ -e "$file" ] || continue

        # Copy the file
        cp "$file" "$MOUNT_POINT/"

        # Verify the file was copied correctly
        dest_file="$MOUNT_POINT/$(basename "$file")"
        if [[ -f "$dest_file" ]]; then
            echo "Copied: $file -> $dest_file"
        else
            echo "Failed to copy: $file"
            COPY_SUCCESS=false
        fi
    done
done

# Delete originals only if all copies succeeded
if $COPY_SUCCESS; then
    echo "All files copied successfully, deleting originals..."
    for ext in "${EXTENSIONS[@]}"; do
        rm -f "$SOURCE_DIR"/*.$ext
    done
else
    echo "Copy verification failed! Keeping original files."
    flash_red_screen
fi

# Sync to ensure all writes are completed
sync

# Unmount USB
sudo umount "$MOUNT_POINT"

# Flash red screen as an alert
flash_red_screen

echo "Backup process completed!"
