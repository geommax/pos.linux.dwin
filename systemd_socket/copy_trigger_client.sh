#!/bin/bash

echo "Hello, systemd Unix socket!" | nc -U /tmp/copy_trigger.sock

