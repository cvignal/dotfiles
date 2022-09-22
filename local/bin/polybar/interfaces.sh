#!/bin/sh

readonly ETH=$(ip link | grep -wv 'NO-CARRIER' | grep -m 1 -E '\b(en)' \
  | awk '{print substr($2, 1, length($2)-1)}')
readonly WIFI=$(ip link | grep -m 1 -E '\b(wl)' \
  | awk '{print substr($2, 1, length($2)-1)}')
