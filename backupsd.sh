#!/bin/bash

sudo dd if=/dev/mmcblk0p1 bs=4M | gzip > jetsonnano@rig__sd-card-backup.img.gz