#!/bin/bash

DEVICE_PATH=/dev/mmcblk0p1

if [ ! -d $DEVICE_PATH || -z "$1" ] then
    echo "Don't know which device to back-up in $DEVICE_PATH, insert card or tell me which device to back-up"
else
    DEVICE_PATH = $1
    sudo dd if=$DEVICE_PATH bs=4M | gzip > jetsonnano@rig__sd-card-backup.img.gz
fi