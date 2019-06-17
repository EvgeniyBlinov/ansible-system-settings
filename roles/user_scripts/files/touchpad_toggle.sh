#!/bin/bash
# @requirements: xinput

PROBE_1='DELL.*Touchpad'
PROBE_2='Touchpad'

if xinput list | grep -q $PROBE_1 ; then
    DEVICE_PATTERN=$PROBE_1
elif xinput list | grep -q $PROBE_2 ; then
    DEVICE_PATTERN=$PROBE_2
fi

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
