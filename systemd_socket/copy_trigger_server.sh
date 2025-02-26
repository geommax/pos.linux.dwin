#!/bin/bash

LOG_FILE="/home/linaro/usb_debug.log"
SOURCE_DIR="/home/linaro/Downloads/*"
MOUNT_BASE="/media"
TARGET_SERIAL="5270601000150688271"  

echo "$(date) : USB Mount and Copy Started" | tee -a "$LOG_FILE"

for DEV in /dev/sd[a-d]; do
    if [ -b "$DEV" ]; then  
        MOUNT_POINT="${MOUNT_BASE}/$(basename $DEV)"  
        echo "[$(date)] Found device: $DEV" | tee -a "$LOG_FILE"

        USB_SERIAL=$(udevadm info --query=property --name=$DEV | grep ID_SERIAL_SHORT= | cut -d= -f2)
        echo "[$(date)] Detected USB Serial Number: $USB_SERIAL" | tee -a "$LOG_FILE"


        if [ "$USB_SERIAL" != "$TARGET_SERIAL" ]; then
            echo "[$(date)] Serial number does not match. Skipping device." | tee -a "$LOG_FILE"
            continue 
        fi

        PARTITION=$(lsblk -l -n -o NAME | grep "^$(basename $DEV)[0-9]$" | head -n 1)

        if [ -n "$PARTITION" ]; then
            DEVICE="/dev/$PARTITION"  
            echo "[$(date)] Found partition: $DEVICE" | tee -a "$LOG_FILE"
        else
            DEVICE="$DEV"  
            echo "[$(date)] No partition found, using full device: $DEVICE" | tee -a "$LOG_FILE"
        fi


        if [ ! -d "$MOUNT_POINT" ]; then
            sudo mkdir -p "$MOUNT_POINT"
            echo "[$(date)] Created mount point: $MOUNT_POINT" | tee -a "$LOG_FILE"
        fi


        sudo mount "$DEVICE" "$MOUNT_POINT" 2>> "$LOG_FILE"
        if [ $? -eq 0 ]; then
            echo "[$(date)] Mounted $DEVICE to $MOUNT_POINT" | tee -a "$LOG_FILE"
            

            echo "[$(date)] Copying files from ~/Downloads/ to $MOUNT_POINT" | tee -a "$LOG_FILE"
            sudo cp -rv $SOURCE_DIR "$MOUNT_POINT/" | tee -a "$LOG_FILE"
            sudo sync "$MOUNT_POINT/" | tee -a "$LOG_FILE"

            echo "[$(date)] Successfully copied files to $MOUNT_POINT" | tee -a "$LOG_FILE"
        else
            echo "[$(date)] Failed to mount $DEVICE" | tee -a "$LOG_FILE"
        fi

        sudo umount "$MOUNT_POINT"
        echo "[$(date)] Unmounted $MOUNT_POINT" | tee -a "$LOG_FILE"
    fi
done

echo "$(date) : USB Mount and Copy Finished" | tee -a "$LOG_FILE"
exit 0
