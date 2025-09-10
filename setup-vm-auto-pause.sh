#!/bin/bash
# setup-vm-auto-pause.sh
# Full setup for VM auto pause system

VM_SCRIPT="/usr/local/bin/vm-auto-pause.sh"
SERVICE_FILE="/etc/systemd/system/vm-auto-pause.service"

echo "1. Setting execute permission for VM script..."
sudo chmod +x $VM_SCRIPT

echo "2. Reloading systemd daemon..."
sudo systemctl daemon-reexec

echo "3. Restarting VM auto pause service..."
sudo systemctl restart vm-auto-pause.service

echo "4. Checking service status..."
sudo systemctl status vm-auto-pause.service