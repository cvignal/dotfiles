#!/usr/bin/env bash
rofi -dmenu\
    -password\
    -i\
    -no-fixed-num-lines\
    -p "Password:"\
    -theme ~/.config/rofi/askpass/askpass.rasi
