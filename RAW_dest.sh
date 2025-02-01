#!/bin/bash

MOUNT_POINT="/home/bot/report_generate/"

# Find the device name dynamically
SEARCH_DEV_NAME=$(/usr/bin/lsblk -rpo "NAME,UUID,VENDOR,MODEL,SERIAL" | /usr/bin/grep "0721341F8E98BB06" | /usr/bin/awk '{print $1}')
echo "$SEARCH_DEV_NAME " >> /home/bot/usb_debug.log

DEV_NAME="${SEARCH_DEV_NAME}1"



echo "$DEV_NAME" >> /home/bot/usb_debug.log
sleep 3;

/usr/bin/mkdir -p "$MOUNT_POINT"
echo "GGG " >> /home/bot/usb_debug.log
sudo mount "$DEV_NAME" "$MOUNT_POINT"
echo "Mountint Done " >> /home/bot/usb_debug.log
#sudo /usr/bin/mount -o uid=$(id -u),gid=$(id -g) "$DEV_NAME" "$MOUNT_POINT"

#ACTION=="add", SUBSYSTEM=="block", ATTRS{idVendor}=="13fe", ATTRS{idProduct}=="6700", ATTRS{serial}=="0721341F8E98BB06", ENV{UDISKS_IGNORE}="1", KERNEL=="sd[b-z][0-9]", OWNER="bot", GROUP="dialout", MODE="0660", RUN+="/home/bot/pos.linux.dwin/RAW.SH"


