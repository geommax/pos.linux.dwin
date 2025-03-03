If your system's journal logs are taking up too much space, you can clean them using `journalctl`. Here’s how:

---

### **1️⃣ Check Current Journal Log Size**
Run the following command to check how much space the journal logs are using:

```bash
journalctl --disk-usage
```

If it's **591M**, you can proceed with cleaning.

---

### **2️⃣ Delete Old Logs**
You can clean journal logs using different methods:

#### **A) Clear Logs Older Than X Days**
If you want to remove logs older than **7 days**, use:

```bash
sudo journalctl --vacuum-time=7d
```

You can adjust the number of days (`7d`, `14d`, etc.).

#### **B) Limit Journal Log Size**
If you want to shrink the logs to a specific size, e.g., **100MB**, use:

```bash
sudo journalctl --vacuum-size=100M
```

#### **C) Remove ALL Journal Logs**
⚠ **Warning:** This will **delete all logs**, so only do this if you’re sure!

```bash
sudo rm -rf /var/log/journal/*
sudo systemctl restart systemd-journald
```

---

### **3️⃣ Set a Permanent Limit (Optional)**
To **prevent logs from growing too large**, edit the journald config:

```bash
sudo nano /etc/systemd/journald.conf
```

Find (or add) these lines:

```
SystemMaxUse=200M
SystemMaxFileSize=50M
SystemMaxFiles=5
```

Then restart the journal service:

```bash
sudo systemctl restart systemd-journald
```

---

### **✅ Summary**
✔ Checked journal log size  
✔ Cleaned logs using **time-based** or **size-based** vacuuming  
✔ (Optional) Set **permanent log size limits**  

Now, your logs should be cleaned up and **won’t take excessive space** anymore! 🚀 Let me know if you need more help. 😊