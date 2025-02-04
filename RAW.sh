#!/bin/bash
LOG_FILE="/home/bot/usb_debug.log"

echo "$(date) - Found RAW.sh" >> "$LOG_FILE"
# Path to the Unix socket
SOCKET_PATH="/tmp/copy_trigger.sock"

# Send a signal to the socket
echo "trigger" | socat - UNIX-CONNECT:"$SOCKET_PATH" 


exit 0
