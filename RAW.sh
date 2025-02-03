#!/bin/bash

MOUNT_POINT="/home/bot/report_generate/"
LOG_FILE="/home/bot/usb_debug.log"


SEARCH_DEV_NAME=$(/usr/bin/lsblk -rpo "NAME,UUID,VENDOR,MODEL,SERIAL" | /usr/bin/grep "0721341F8E98BB06" | /usr/bin/awk '{print $1}')
echo "$(date) - Found device: $SEARCH_DEV_NAME" >> "$LOG_FILE"
DEV_NAME="${SEARCH_DEV_NAME}1"

echo "$(date) - Trying to mount: $DEV_NAME" >> "$LOG_FILE"
/usr/bin/mkdir -p "$MOUNT_POINT"
sleep 3

echo "$(date) - Triggering mount..." >> "$LOG_FILE"
sudo mount "$DEV_NAME" "$MOUNT_POINT"

# /usr/bin/udisksctl mount --block-device "$DEV_NAME" --no-user-interaction >> "$LOG_FILE" 2>&1

MOUNTED_PATH=$(lsblk -rpo "NAME,MOUNTPOINT" | grep "$DEV_NAME" | awk '{print $2}')
echo "Mounted at: $MOUNTED_PATH" >> "$LOG_FILE"
# echo "$(date) - waiting 5 sec to be ready" >> "$LOG_FILE"
# sleep 2
# echo "$(date) - Umounting: $MOUNTED_PATH" >> "$LOG_FILE"
# sudo umount $MOUNTED_PATH

if [ -n "$MOUNTED_PATH" ]; then
    sudo mount "$MOUNTED_PATH" "$MOUNT_POINT"
    echo "$(date) - Successfully mounted to $MOUNT_POINT" >> "$LOG_FILE"
else
    echo "$(date) - Error: Device mounted but mount path not found!" >> "$LOG_FILE"
    exit 1
fi
exit 0
