
#!/bin/bash

# Ensure the DBUS_SESSION_BUS_ADDRESS is set up for sudo
export DBUS_SESSION_BUS_ADDRESS=$(echo $DBUS_SESSION_BUS_ADDRESS)

# Run dbus-send with sudo and the session environment variable
sudo DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dbus-send --session --print-reply --dest=com.example.UsbSignal /com/example/UsbSignal com.example.UsbSignal.USBReady

exit 0
