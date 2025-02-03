#### UnixSocket

```bash
socat UNIX-LISTEN:/tmp/copy_trigger.sock,fork -
```

#### Netcat
```bash
nc -l -U /tmp/copy_trigger.sock
```
#### Waiting with next trigger
```bash
socat UNIX-LISTEN:/tmp/copy_trigger.sock,fork EXEC:copy_trigger_server.sh
```

#### Client
```bash
echo "Hello, systemd Unix socket!" | nc -U /tmp/copy_trigger.sock
```
> ##################################################################











## Reload systemd configuration to apply the new service and udev rules
```bash
sudo systemctl daemon-reload
sudo udevadm control --reload
```

# Enable the service so it starts on boot
```bash
sudo systemctl enable usb_data_transfer.service
```

```bash
journalctl -u copy_trigger.service -f
journalctl -u copy_trigger.socket -f

sudo systemctl status copy_trigger.service
sudo systemctl status copy_trigger.socket

sudo systemctl start copy_trigger.service
sudo systemctl start copy_trigger.socket

sudo systemctl enable copy_trigger.service
sudo systemctl enable copy_trigger.socket
```