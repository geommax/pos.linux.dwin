#!/bin/bash

# Define allowed USB IDs (Replace with your USB's actual ID)
ALLOWED_USB_ID="6014-4768"

# Define mount point
MOUNT_POINT="$HOME/report_backup"

# Define source and destination
SOURCE_DIR="$HOME/Downloads"
EXTENSIONS=("xlsx" "csv" "backup")

# Function to flash red screen
flash_red_screen() {
    for i in {1..5}; do
        xrandr --output $(xrandr | grep " connected" | awk '{print $1}') --gamma 1:0:0
        sleep 0.2
        xrandr --output $(xrandr | grep " connected" | awk '{print $1}') --gamma 1:1:1
        sleep 0.2
    done
}

# Detect USB device
USB_ID=$(lsblk -o NAME,UUID | grep -i sd | awk '{print $2}' | grep -i "$ALLOWED_USB_ID")

if [[ -z "$USB_ID" ]]; then
    echo "No allowed USB detected!"
    exit 1
fi

# Create mount point if not exists
mkdir -p "$MOUNT_POINT"

# Mount the USB
sudo mount /dev/disk/by-uuid/"$USB_ID" "$MOUNT_POINT"

if [[ $? -ne 0 ]]; then
    echo "Failed to mount USB!"
    exit 1
fi

# Remove pre-existing files in USB mount point
echo "Checking for existing files in USB mount point..."
for ext in "${EXTENSIONS[@]}"; do
    find "$MOUNT_POINT" -type f -name "*.$ext" -exec rm -f {} \;
done

echo "Old files deleted from USB."

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

# Only delete originals if all copies succeeded
if $COPY_SUCCESS; then
    echo "All files copied successfully, deleting originals..."
    for ext in "${EXTENSIONS[@]}"; do
        rm -f "$SOURCE_DIR"/*.$ext
    done
else
    echo "Copy verification failed! Original files are not deleted."
    flash_red_screen
fi

# Sync to ensure all changes are written
sync

# Unmount USB
sudo umount "$MOUNT_POINT"

# Flash red screen as an alert
flash_red_screen

echo "Process completed!"
