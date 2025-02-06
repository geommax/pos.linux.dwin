#!/bin/bash
LOG_FILE="/home/bot/usb_debug.log"
echo "$(date) : About To Received Signal Processding (sleep 5 sec)..." >> "$LOG_FILE"
sleep 5;
echo "$(date) : Signal received! Executing script..." >> "$LOG_FILE"
echo "$(date) : Found Copy Trigger Server.sh in /usr/local/bin/" >> "$LOG_FILE"

echo "$(date) : Prepare to copy from ~/Download/* to USB Mounted Dir. " >> "$LOG_FILE"

# all extensions must be provided.
#EXTENSIONS=("xlsx" "csv" "backup")

SOURCE_DIR="/home/bot/Downloads/Products.xlsx"
SEARCH_DEV_NAME=$(/usr/bin/lsblk -rpo "NAME,UUID,VENDOR,MODEL,SERIAL" | /usr/bin/grep "0721341F8E98BB06" | /usr/bin/awk '{print $1}')

echo "$(date) - Found New USB device: $SEARCH_DEV_NAME" >> "$LOG_FILE"
DEV_NAME="${SEARCH_DEV_NAME}1" # partition ကိုယူချင်လို့ 1 ပေါင်းထားပေးတာဖြစ်တယ်။

echo "$(date) - Triggering Copy..." >> "$LOG_FILE"
echo "$(date) - Waiting 3 sec to be ready for automounting.." >> "$LOG_FILE"
sleep 3;
MOUNTED_PATH=$(lsblk -rpo "NAME,MOUNTPOINT" | Products.xlsxgrep "$DEV_NAME" | awk '{print $2}')
echo "USB is mounted at: $MOUNTED_PATH" >> "$LOG_FILE"  

#---------------------------------------------

# mount ထားတာမရှိရင် mount ပေးရမယ်။ (ဆက်ရေးရန်။)

#---------------------------------------------
echo "$(date) - The Block Device $DEV_NAME is mounted at $MOUNTED_PATH".. >> "$LOG_FILE"
cp -rv "$SOURCE_DIR" "$MOUNTED_PATH" >> "$LOG_FILE"
echo "$(date) - Waiting 3 sec to be ready for copying.." >> "$LOG_FILE"
sleep 3;
sync
echo "$(date) - Successfully copied to $MOUNTED_PATH" >> "$LOG_FILE"
echo "$(date) - =======================================" >> "$LOG_FILE"

#echo "$(date) - Error: Copying reports" >> "$LOG_FILE"
echo "$(date) - =======================================" >> "$LOG_FILE"
exit 1

