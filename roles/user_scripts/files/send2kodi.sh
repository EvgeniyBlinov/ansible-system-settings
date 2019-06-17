#!/bin/bash

# check if `xdotool` installed
if [[ ! -x $(which xdotool) ]];then
	echo
	echo "Install 'xdotool' first."
	echo "In Arch Linux:"
	echo "$ sudo pacman -S xdotool"
	echo "or Ubuntu/Debian/etc.:"
	echo "$ sudo apt-get install xdotool"
	echo
	exit -1;
fi

# find Kodi window
KODIWINID=$(xdotool search --class Kodi)

# fawk! No Kodi. Curse & bail out
if [[ $KODIWINID = "" ]];then
	echo "Run Kodi! Stupid beotch!"
	exit -2;
fi

# no parameters from command line? Read from stdin...
if [[ -z "${1}" ]];then
	while read LINE; do
		xdotool type --window $KODIWINID "${LINE}"
	done
fi

# send 1st command line parameter to Kodi (hopefully) =]
xdotool type --window $KODIWINID "${1}"
