#!/bin/bash

sudo cp -v 99-usb-backup.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo cp -v send_copy_trigger_signal.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/send_copy_trigger_signal.sh

sudo cp -rv copy_trigger.service copy_trigger.socket /etc/systemd/system/
sudo cp -rv copy_trigger_server.py copy_trigger_server.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/copy_trigger_server*

sudo systemctl daemon-reload 
sudo systemctl start copy_trigger.socket
sudo systemctl start copy_trigger.service
sudo systemctl status copy_trigger.socket
sudo systemctl status copy_trigger.service


