#!/bin/bash
LOG_FILE="/home/linaro/usb_debug.log"
SOURCE_DIR="/home/linaro/Downloads/*"
# all extensions must be provided.
#EXTENSIONS=("xlsx" "csv" "backup")

echo "$(date) : Signal received! Running copy_trigger_server ..." >> "$LOG_FILE"
echo "................................." >> "$LOG_FILE"
sleep 5;
echo "$(date) : Prepare to copy from ~/Download/* to USB Mounted Dir. " >> "$LOG_FILE"

# Find where sdb1, sdc1, or sdd1 are mounted
MOUNTED_POINT=$(findmnt -rn -S /dev/sda1 -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdb1 -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdc1 -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdd1 -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sda -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdb -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdc -o TARGET 2>/dev/null || \
                findmnt -rn -S /dev/sdd -o TARGET 2>/dev/null)

if [ -n "$MOUNTED_POINT" ]; then
    echo "====================== Prepare Mounted Point ==============" >> "$LOG_FILE"
    echo "Mounted at: $MOUNTED_POINT" &>> "$LOG_FILE"
    echo "Removing \x20 for space in : $MOUNTED_POINT" &>> "$LOG_FILE"
    MOUNTED_POINT=$(printf '%b' "$MOUNTED_POINT") 
    #MOUNTED_POINT=$(echo "$MOUNTED_POINT" | sed 's/\\x20/\\ /g')
    echo "After removing \x20, The mounted point is : $MOUNTED_POINT" &>> "$LOG_FILE"
    echo "====================== Mounted Point is already Prepared ==============" >> "$LOG_FILE"
    sudo ls -l "$MOUNTED_POINT/" &>> "$LOG_FILE"
    sudo ls -l $SOURCE_DIR &>> "$LOG_FILE"
    sudo cp -rv $SOURCE_DIR "$MOUNTED_POINT/" &>> "$$LOG_FILE"
    sudo sync "$MOUNTED_POINT/" &>> "$LOG_FILE"
    echo "$(date) - =======================================" >> "$LOG_FILE"
    echo "$(date) - Successfully copied to '$MOUNTED_POINT'" >> "$LOG_FILE"
    exit 0
else
    echo "Device is not mounted." >> "$LOG_FILE"
    echo "$(date) - Error: Copying reports" >> "$LOG_FILE"
    echo "$(date) - =======================================" >> "$LOG_FILE"
    exit 1

fi





