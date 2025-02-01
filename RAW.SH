#!/bin/bash

# Maintained By Geommax.

# USB Vendor & Product ID
USB_VENDOR_ID="13fe"
USB_PRODUCT_ID="6700"

# Allowed USB Serial Number
USB_SERIAL="0721341F8E98BB06"

# Mount point
MOUNT_POINT="$HOME/report_backup"

# Source directory
SOURCE_DIR="$HOME/Downloads"
EXTENSIONS=("xlsx" "csv" "backup")

# Log file
LOG_FILE="$HOME/usb.log"

# Function to flash red screen (commented out for now)
flash_red_screen() {
    for i in {1..5}; do
        xrandr --output "$(xrandr | grep " connected" | awk '{print $1}')" --gamma 1:0:0
        sleep 0.2
        xrandr --output "$(xrandr | grep " connected" | awk '{print $1}')" --gamma 1:1:1
        sleep 0.2
    done
}

# Start Logging
echo "====== USB Backup Script Started: $(date) ======" >> "$LOG_FILE"

# Detect USB by serial number
if ! lsusb -d "$USB_VENDOR_ID:$USB_PRODUCT_ID" | grep -q "$USB_SERIAL"; then
    echo "Allowed USB not found!" >> "$LOG_FILE"
    exit 1
fi

# Find USB device name (e.g., sdb)
USB_DEVICE=$(lsblk -o NAME,SERIAL | grep "$USB_SERIAL" | awk '{print $1}')

if [[ -z "$USB_DEVICE" ]]; then
    echo "USB device not detected!" >> "$LOG_FILE"
    exit 1
fi

# Find the first partition (e.g., sdb1, sdc1)
USB_PARTITION=$(lsblk -nr -o NAME "/dev/$USB_DEVICE" | awk 'NR==2')

if [[ -z "$USB_PARTITION" ]]; then
    echo "No partition found on USB device $USB_DEVICE" >> "$LOG_FILE"
    exit 1
fi

USB_PARTITION="/dev/$USB_PARTITION"

# Create mount point if not exists
mkdir -pv "$MOUNT_POINT" >> "$LOG_FILE" 2>&1

# Check if USB is already mounted
if mount | grep -q "$USB_PARTITION"; then
    echo "USB already mounted. Unmounting first..." >> "$LOG_FILE"
    sudo umount "$USB_PARTITION"
fi

# Mount USB
sudo mount "$USB_PARTITION" "$MOUNT_POINT" >> "$LOG_FILE" 2>&1

if [[ $? -ne 0 ]]; then
    echo "Failed to mount USB!" >> "$LOG_FILE"
    exit 1
fi

echo "USB Mounted Successfully at $MOUNT_POINT" >> "$LOG_FILE"

# Remove existing backup files in USB
echo "Removing old backup files in USB..." >> "$LOG_FILE"
for ext in "${EXTENSIONS[@]}"; do
    find "$MOUNT_POINT" -type f -name "*.$ext" -exec rm -f {} \; >> "$LOG_FILE" 2>&1
done

# Copy files and verify
COPY_SUCCESS=true

for ext in "${EXTENSIONS[@]}"; do
    shopt -s nullglob  # Prevents errors if no matching files exist
    for file in "$SOURCE_DIR"/*.$ext; do
        [ -e "$file" ] || continue

        # Copy the file
        cp -v "$file" "$MOUNT_POINT/" >> "$LOG_FILE" 2>&1

        # Verify the file was copied correctly
        dest_file="$MOUNT_POINT/$(basename "$file")"
        if [[ -f "$dest_file" ]]; then
            echo "Copied: $file -> $dest_file" >> "$LOG_FILE"
        else
            echo "Failed to copy: $file" >> "$LOG_FILE"
            COPY_SUCCESS=false
        fi
    done
    shopt -u nullglob  # Reset shell option
done

# Delete originals only if all copies succeeded
if $COPY_SUCCESS; then
    echo "All files copied successfully, deleting originals..." >> "$LOG_FILE"
    for ext in "${EXTENSIONS[@]}"; do
        rm -f "$SOURCE_DIR"/*.$ext >> "$LOG_FILE" 2>&1
    done
else
    echo "Copy verification failed! Keeping original files." >> "$LOG_FILE"
    #flash_red_screen
fi

# Sync to ensure all writes are completed
sync >> "$LOG_FILE" 2>&1

# Unmount USB
sudo umount "$MOUNT_POINT" >> "$LOG_FILE" 2>&1

echo "USB Unmounted Successfully!" >> "$LOG_FILE"

# Flash red screen as an alert
#flash_red_screen

echo "Backup process completed!" >> "$LOG_FILE"
