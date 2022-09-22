#!/bin/sh
#
# Show a custom network connection indicator in polybar.
# Includes code for wifi, VPN, ZeroTier, and Hamachi.
#
# Author: machaerus
# https://gitlab.com/machaerus

source colors.sh

net_print() {

	# CONNECTED_WIFI=$(iwconfig wlan0 | grep ESSID | wc -l)
	ESSID=$(iwconfig wlp3s0 | grep ESSID | cut -d: -f2 | xargs)
	[ "$ESSID" = "off/any" ] && CONNECTED_WIFI=0 || CONNECTED_WIFI=1
	CONNECTED_VPN=$(sudo ipsec status | grep kbrwvpn | wc -l)
	# CONNECTED_HAMACHI=$(hamachi | grep status | cut -d ':' -f 2 | xargs)
	# CONNECTED_ZEROTIER=$(zerotier-cli info | cut -d ' ' -f 5 | xargs)

	if [ "$CONNECTED_WIFI" -eq 1 ]; then
		wifi_indicator="${faded_green}${RESET}"
	else
		wifi_indicator="${dark0_soft}${RESET}"
	fi

	if [ "$CONNECTED_VPN" -eq 3 ]; then
		vpn_indicator="${faded_green}${RESET}"
	else
		vpn_indicator="${dark0_soft}${RESET}"
	fi

	# if [ "$CONNECTED_HAMACHI" = "logged in" ]; then
	# 	hamachi_indicator="${faded_green}${RESET}"
	# else
	# 	hamachi_indicator="${dark0_soft}${RESET}"
	# fi

	# if [ "$CONNECTED_ZEROTIER" = "ONLINE" ]; then
	# 	zerotier_indicator="${faded_green}${RESET}"
	# else
	# 	zerotier_indicator="${dark0_soft}${RESET}"
	# fi

	# echo "$dark2[$wifi_indicator$dark2]$dark2[$vpn_indicator$dark2]"
	# echo "$wifi_indicator $vpn_indicator $zerotier_indicator"
	echo " $wifi_indicator $vpn_indicator "
}

net_print


