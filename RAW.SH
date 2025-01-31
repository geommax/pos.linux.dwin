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




step 1:
usb plugged is detected, check the unique ID of usb is the same as a unique ID or part number of
allowed  usb , 


step 2: 
If equal, the usb will be mountd with ~/report_backup. And then, 


step 3: 
move all contents in the ~/Download/*.xlsx,csv,.backup to /usb_mounted_point 

step 4:
and sync. check the moving content is ok or not. and unmount the mount point. And I want to show shaking red flash screen on computer xfce4, desktop environment, screen.  


Please provide idea of how to be seen for user when it is done instead of shaking flash red sreen