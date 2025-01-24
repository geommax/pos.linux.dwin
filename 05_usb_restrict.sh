#!/bin/bash
LOGFILE="/var/log/usb-auto-run.log"

echo "$(date): USB device plugged in, starting script..." >> $LOGFILE

SOURCE_FILE="/home/bot/file.txt"
USB_MOUNT=$(lsblk -o NAME,MOUNTPOINT | grep -i 'sd' | grep -i 'media' | awk '{print $2}')
#USB_MOUNT="/media/bot/UEFI_NTFS"

echo $USB_MOUNT >> $LOGFILE
if [ -d "$USB_MOUNT" ]; then

    cp "$SOURCE_FILE" "$USB_MOUNT"
    echo "$(date): File copied to $USB_MOUNT" >> $LOGFILE
else
   echo "$(date): USB device not mounted or not found." >> $LOGFILE
fi