#!/bin/bash
# vm-auto-pause.sh
# Pauses VM if any process uses more than 4 GB RAM, resumes when RAM drops

VM="windows2016"           # Change this to your VM name
RAM_LIMIT_KB=$((4 * 1024 * 1024))  # 4 GB in KB

while true; do
    # Get the max RSS memory usage in KB
    max_mem=$(ps -eo rss --sort=-rss | head -n 2 | tail -n 1)

    if [ "$max_mem" -gt "$RAM_LIMIT_KB" ]; then
        echo "RAM usage exceeded 4GB ($((max_mem/1024)) MB), pausing VM..."
        virsh suspend $VM

        # Wait until RAM drops below limit
        while [ $(ps -eo rss --sort=-rss | head -n 2 | tail -n 1) -gt "$RAM_LIMIT_KB" ]; do
            sleep 5
        done

        echo "RAM usage dropped, resuming VM..."
        virsh resume $VM
    fi

    sleep 5
done
