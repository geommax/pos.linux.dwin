#!/bin/bash

MOUNT_POINT="/home/bot/report_generate"

# Find the device name dynamically
SEARCH_DEV_NAME=$(/usr/bin/lsblk -rpo "NAME,UUID,VENDOR,MODEL,SERIAL" | /usr/bin/grep "0721341F8E98BB06" | /usr/bin/awk '{print $1}')
echo "$SEARCH_DEV_NAME " >> /home/bot/usb_debug.log

DEV_NAME="${SEARCH_DEV_NAME}1"


# echo "$DEV_NAME" >> /home/bot/usb_debug.log

# if [ -n "$DEV_NAME" ]; then
#     /usr/bin/mkdir -p "$MOUNT_POINT"
#     echo "GGG " >> /home/bot/usb_debug.log
#     /usr/bin/umount "$DEV_NAME" 2>/dev/null
#     /usr/bin/mount -o uid=$(id -u),gid=$(id -g) "$DEV_NAME" "$MOUNT_POINT"
# fi
