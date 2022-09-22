#!/bin/sh
#
# Custom clock/calendar for polybar.
#
# Author: machaerus
# https://gitlab.com/machaerus

source colors.sh

custom_time() {
	WEEKDAY=$(date +%A)
	TIME=$(date +%H:%M:%S)
	DATE=$(date +"%e %b %Y")

	echo "$light0_soft $WEEKDAY $faded_yellow $TIME $light0_soft $DATE $RESET"
}

custom_time
