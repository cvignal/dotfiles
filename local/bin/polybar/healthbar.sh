#!/bin/sh
#
# Battery status as am RPG-like "health bar" with hearts and half-hearts.
# To be used with polybar or similar. This should work for a ThinkPad with
# two batteries installed.
#
# It also shows desktop notifications when the battery is low (notify-send).
#
# Author: machaerus
# https://gitlab.com/machaerus
#
# Original idea for calculating the battery % is not mine, unfortunately
# I don't remember the source.

source colors.sh

healthbar_print() {

	PATH_AC="/sys/class/power_supply/AC"
	PATH_BATTERY_0="/sys/class/power_supply/BAT0"
	PATH_BATTERY_1="/sys/class/power_supply/BAT1"

	ac=0
	battery_level_0=0
	battery_level_1=0
	battery_max_0=0
	battery_max_1=0

	if [ -f "$PATH_AC/online" ]; then
		ac=$(cat "$PATH_AC/online")
	fi

	if [ -f "$PATH_BATTERY_0/energy_now" ]; then
		battery_level_0=$(cat "$PATH_BATTERY_0/energy_now")
	fi

	if [ -f "$PATH_BATTERY_0/energy_full" ]; then
		battery_max_0=$(cat "$PATH_BATTERY_0/energy_full")
	fi

	if [ -f "$PATH_BATTERY_1/energy_now" ]; then
		battery_level_1=$(cat "$PATH_BATTERY_1/energy_now")
	fi

	if [ -f "$PATH_BATTERY_1/energy_full" ]; then
		battery_max_1=$(cat "$PATH_BATTERY_1/energy_full")
	fi

	battery_level=$(("$battery_level_0 + $battery_level_1"))
	battery_max=$(("$battery_max_0 + $battery_max_1"))

	battery_percent=$(("$battery_level * 100"))
	battery_percent=$(("$battery_percent / $battery_max"))

	# notify-send "Battery below 90%"
	# notify-send "$battery_percent"
	if [[ "$battery_percent" -lt 5 ]] && [[ ! "$ac" -eq 1 ]]; then
		play /usr/share/sounds/freedesktop/stereo/message.oga 2> /dev/null
		notify-send -u critical "Battery below 3%!"
	elif [[ "$battery_percent" -lt 15 ]] && [[ ! "$ac" -eq 1 ]]; then
		play /usr/share/sounds/freedesktop/stereo/message.oga 2> /dev/null
		notify-send -u critical "Battery below 10%!"
	fi

	if [ "$battery_percent" -gt 88 ]; then
		hp="$faded_red   $RESET"
	elif [ "$battery_percent" -gt 75 ]; then
		hp="$faded_red   ﯜ$RESET"
	elif [ "$battery_percent" -gt 63 ]; then
		hp="$faded_red   $RESET$dark0_soft$RESET"
	elif [ "$battery_percent" -gt 50 ]; then
		hp="$faded_red  ﯜ $RESET$dark0_soft$RESET"
	elif [ "$battery_percent" -gt 38 ]; then
		hp="$faded_red  $RESET$dark0_soft $RESET"
	elif [ "$battery_percent" -gt 25 ]; then
		hp="$faded_red ﯜ $RESET$dark0_soft $RESET"
	elif [ "$battery_percent" -gt 13 ]; then
		hp="$faded_red $RESET$dark0_soft  $RESET"
	else
		hp="$faded_redﯜ $RESET$dark0_soft  $RESET"
	fi
    echo $hp

	# if [ "$ac" -eq 1 ]; then
	# 	echo "$dark0_soft[$faded_yellow$dark0_soft]$RESET $battery_percent"
	# else
	# 	echo " $battery_percent"
	# fi

	# if [ "$battery_percent" -gt 25 ]; then
	# 	battery_color="$faded_green"
	# elif [ "$battery_percent" -gt 10 ]; then
	# 	battery_color="$faded_yellow"
	# else
	# 	battery_color="$faded_red"
	# fi

	# if [ "$ac" -eq 1 ]; then
	# 	echo "$battery_color$RESET $battery_percent"
	# else
	# 	echo "$battery_color$RESET $battery_percent"
	# fi
}

healthbar_print
