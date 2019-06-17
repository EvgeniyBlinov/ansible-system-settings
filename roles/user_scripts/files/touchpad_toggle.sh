#!/bin/bash

DEVICE_PATTERN='DELL.*Touchpad'

DEVICE_STATUS=$(xinput list |
    grep $DEVICE_PATTERN |
    grep -oP '(?<=id=)\d+' |
    head -1 |
    xargs \
    xinput list-props | awk -F: '/Device Enabled/{print $2}' |grep -o '[01]')

[ 0 -eq $DEVICE_STATUS ] && ACTION=enable || ACTION=disable
xinput list |
    grep $DEVICE_PATTERN |
    grep -oP '(?<=id=)\d+' |
    head -1 |
    xargs \
    xinput $ACTION
