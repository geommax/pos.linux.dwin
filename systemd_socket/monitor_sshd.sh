#!/bin/bash

# Define the threshold time (in seconds)
IDLE_TIME_LIMIT=180  # 3 minutes

# Check for active SSH connections
ACTIVE_SSH=$(ss -tn state established '( dport = :ssh )' | grep -E 'ESTAB' | wc -l)

# If no active SSH connections, check last connection time
if [ "$ACTIVE_SSH" -eq 0 ]; then
    # Check the timestamp of the last SSH connection (this will look at the auth log)
    LAST_CONNECTION_TIME=$(grep 'Accepted' /var/log/auth.log | tail -n 1 | awk '{print $1, $2, $3, $4, $5}')
    
    # Convert the time to seconds since epoch for comparison
    LAST_CONNECTION_TIMESTAMP=$(date --date="$LAST_CONNECTION_TIME" +%s)
    CURRENT_TIME_TIMESTAMP=$(date +%s)
    
    # Calculate the difference in seconds
    DIFF_TIME=$((CURRENT_TIME_TIMESTAMP - LAST_CONNECTION_TIMESTAMP))
    
    # If the difference is more than the idle time limit, stop the SSH server
    if [ "$DIFF_TIME" -ge "$IDLE_TIME_LIMIT" ]; then
        echo "No SSH clients connected for $((DIFF_TIME / 60)) minutes. Stopping SSH server."
        sudo systemctl stop sshd
    else
        echo "SSH server is active. No action required."
    fi
else
    echo "Active SSH connections detected. No action required."
fi
