#!/bin/sh
#
# Custom RPG-like wifi signal strength indicator for polybar.
#
# Author: machaerus
# https://gitlab.com/machaerus

source colors.sh

manabar_print() {
	ESSID=$(iwconfig wlan0 | grep ESSID | cut -d: -f2 | xargs)
	[ "$ESSID" = "off/any" ] && CONNECTED_WIFI=0 || CONNECTED_WIFI=1
	WIFI_Q=$(awk 'NR==3 {printf("%.0f\n",$3*10/7)}' /proc/net/wireless)
	if [ "$CONNECTED_WIFI" -eq 1 ]; then
		if [ "$WIFI_Q" -gt 75 ]; then
			wifi="$bright_blue   $RESET"
		elif [ "$WIFI_Q" -gt 50 ]; then
			wifi="$bright_blue   $RESET$dark0_soft$RESET"
		elif [ "$WIFI_Q" -gt 25 ]; then
			wifi="$bright_blue  $RESET$dark0_soft $RESET"
		elif [ "$WIFI_Q" -gt 0 ]; then
			wifi="$bright_blue $RESET$dark0_soft  $RESET"
		else
			wifi="$dark0_soft   $RESET"
		fi
	else
		wifi="$dark0_soft   $RESET"
	fi
	echo "$wifi"
}

manabar_print


