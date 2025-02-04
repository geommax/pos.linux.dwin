#!/usr/bin/env python3
import socket
import os
import sys

# Path to the Unix socket
SOCKET_PATH = "/tmp/copy_trigger.sock"

# Path to the script to execute when a signal is received
SCRIPT_PATH = "/usr/local/bin/copy_trigger_server.sh"

# Remove the socket file if it already exists
if os.path.exists(SOCKET_PATH):
    os.remove(SOCKET_PATH)

# Create a Unix socket server
server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
server.bind(SOCKET_PATH)
server.listen(1)

print("Kyaw Swar Tun's Listening for signals on Unix socket...")

while True:
    conn, addr = server.accept()
    data = conn.recv(1024).decode('utf-8')
    if data:
        print(f"Received signal: {data}")
        # Execute the script
        os.system(SCRIPT_PATH)
    conn.close()