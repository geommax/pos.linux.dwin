#!/bin/bash
LOG_FILE="/home/bot/usb_debug.log"
echo "$(date) : About To Received Signal Processding (sleep 5 sec)..." >> "$LOG_FILE"
sleep 5;
echo "$(date) : Signal received! Executing script..." >> "$LOG_FILE"
echo "$(date) : Found Copy Trigger Server.sh in /usr/local/bin/" >> "$LOG_FILE"
# Add your commands here

