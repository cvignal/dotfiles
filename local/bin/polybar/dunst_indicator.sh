#!/bin/sh
# Dunst "do not disturb" indicator for polybar. You should be able
# to snooze and unsnooze notification by left-clicking the icon.
#
# Author: machaerus
# https://gitlab.com/machaerus

source colors.sh

dunst_notifications() {
	dunst_enabled=$(dunstctl is-paused)
	if [ "$dunst_enabled" == "false" ]; then
		dunst_indicator="${faded_green}${RESET}"
	else
		dunst_indicator="${faded_red}${RESET}"
	fi
	echo $dunst_indicator
}
dunst_notifications
