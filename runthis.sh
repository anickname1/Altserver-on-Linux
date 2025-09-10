#!/bin/bash
# install-vm-auto-pause.sh
# Copies files, sets permissions, and sets up the VM auto-pause service

# Paths inside your folder
SOURCE_FOLDER="$(pwd)"  # assume you run this script from the folder containing scripts
VM_SCRIPT="$SOURCE_FOLDER/vm-auto-pause.sh"
SERVICE_FILE="$SOURCE_FOLDER/vm-auto-pause.service"

# Destination paths
DEST_SCRIPT="/usr/local/bin/vm-auto-pause.sh"
DEST_SERVICE="/etc/systemd/system/vm-auto-pause.service"

echo "1. Copying VM script to /usr/local/bin/..."
sudo cp "$VM_SCRIPT" "$DEST_SCRIPT"
sudo chmod +x "$DEST_SCRIPT"

echo "2. Copying systemd service to /etc/systemd/system/..."
sudo cp "$SERVICE_FILE" "$DEST_SERVICE"
sudo chmod 644 "$DEST_SERVICE"

echo "3. Reloading systemd daemon..."
sudo systemctl daemon-reexec

echo "4. Enabling and starting the service..."
sudo systemctl enable vm-auto-pause.service
sudo systemctl restart vm-auto-pause.service

echo "5. Showing service status..."
sudo systemctl status vm-auto-pause.service
