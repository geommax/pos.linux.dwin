#### UnixSocket
```bash
sudo apt install socat
```

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

### Reload systemd configuration to apply the new service and udev rules
```bash
sudo systemctl daemon-reload
sudo udevadm control --reload
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
```bash
bot@bot-Vostro-14-3468:~$ sudo systemctl status copy_trigger.service 
[sudo] password for bot: 
● copy_trigger.service - copy_trigger_Unix Socket Server
     Loaded: loaded (/etc/systemd/system/copy_trigger.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2025-02-04 14:24:38 +0630; 1min 31s ago
TriggeredBy: ● copy_trigger.socket
   Main PID: 892 (python3)
      Tasks: 1 (limit: 9278)
     Memory: 3.8M
        CPU: 49ms
     CGroup: /system.slice/copy_trigger.service
             └─892 python3 /usr/local/bin/copy_trigger_server.py

Feb 04 14:24:38 bot-Vostro-14-3468 systemd[1]: Started copy_trigger_Unix Socket Server.
bot@bot-Vostro-14-3468:~$ 
```