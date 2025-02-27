#!/bin/bash

LOG_FILE="/home/linaro/usb_debug.log"
SOURCE_DIR="/home/linaro/Downloads/*"
MOUNT_BASE="/media"
TARGET_SERIAL="5270601000150688271"  # Set your expected USB serial number here
DB_NAME="db_web_pos"  # Replace with your database name
DB_USER="TZH"  # Replace with your MySQL user
DB_PASSWORD="password"  # Replace with your MySQL password
DATE_TIME=$(date +"%Y-%m-%d_%H-%M-%S")  # Generate timestamp
DB_DUMP_FILE="/home/linaro/Downloads/db_backup_${DATE_TIME}.sql"

# Ensure log file exists
sudo touch "$LOG_FILE"
sudo chmod 666 "$LOG_FILE"

echo "$(date) : USB Mount, Copy, and Cleanup Started" | tee -a "$LOG_FILE"

# Step 1: Dump the MySQL database
echo "[$(date)] Starting MySQL dump for database: $DB_NAME" | tee -a "$LOG_FILE"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases "$DB_NAME" > "$DB_DUMP_FILE" 2>> "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] MySQL dump successful: $DB_DUMP_FILE" | tee -a "$LOG_FILE"
else
    echo "[$(date)] MySQL dump failed!" | tee -a "$LOG_FILE"
    exit 1
fi

# Step 2: Detect USB and Mount
for DEV in /dev/sd[a-d]; do
    if [ -b "$DEV" ]; then  
        MOUNT_POINT="${MOUNT_BASE}/$(basename $DEV)"  # Example: /media/sda
        echo "[$(date)] Found device: $DEV" | tee -a "$LOG_FILE"

        # Get the serial number of the USB device
        USB_SERIAL=$(udevadm info --query=property --name=$DEV | grep ID_SERIAL_SHORT= | cut -d= -f2)
        echo "[$(date)] Detected USB Serial Number: $USB_SERIAL" | tee -a "$LOG_FILE"

        # Check if the serial number matches
        if [ "$USB_SERIAL" != "$TARGET_SERIAL" ]; then
            echo "[$(date)] Serial number does not match. Skipping device." | tee -a "$LOG_FILE"
            continue  # Skip this device
        fi

        # Check for partitions (e.g., sda1, sdb1, etc.)
        PARTITION=$(lsblk -l -n -o NAME | grep "^$(basename $DEV)[0-9]$" | head -n 1)

        if [ -n "$PARTITION" ]; then
            DEVICE="/dev/$PARTITION"  # Use first partition found
            echo "[$(date)] Found partition: $DEVICE" | tee -a "$LOG_FILE"
        else
            DEVICE="$DEV"  # Use whole device if no partitions
            echo "[$(date)] No partition found, using full device: $DEVICE" | tee -a "$LOG_FILE"
        fi

        # Create mount point if it doesn't exist
        if [ ! -d "$MOUNT_POINT" ]; then
            sudo mkdir -p "$MOUNT_POINT"
            echo "[$(date)] Created mount point: $MOUNT_POINT" | tee -a "$LOG_FILE"
        fi

        # Force mount the device
        sudo mount "$DEVICE" "$MOUNT_POINT" 2>> "$LOG_FILE"
        if [ $? -eq 0 ]; then
            echo "[$(date)] Mounted $DEVICE to $MOUNT_POINT" | tee -a "$LOG_FILE"
            
            # Copy files
            echo "[$(date)] Copying files from ~/Downloads/ to $MOUNT_POINT" | tee -a "$LOG_FILE"
            sudo cp -rv $SOURCE_DIR "$MOUNT_POINT/" | tee -a "$LOG_FILE"
            sudo sync "$MOUNT_POINT/" | tee -a "$LOG_FILE"

            # **Delete source files after copying**
            echo "[$(date)] Deleting source files from ~/Downloads/" | tee -a "$LOG_FILE"
            sudo rm -rf $SOURCE_DIR | tee -a "$LOG_FILE"

            echo "[$(date)] Successfully copied and deleted source files" | tee -a "$LOG_FILE"
        else
            echo "[$(date)] Failed to mount $DEVICE" | tee -a "$LOG_FILE"
        fi

        # Unmount after copying (optional)
        sudo umount "$MOUNT_POINT"
        echo "[$(date)] Unmounted $MOUNT_POINT" | tee -a "$LOG_FILE"
    fi
done

echo "$(date) : USB Mount, Copy, and Cleanup Finished" | tee -a "$LOG_FILE"
exit 0
