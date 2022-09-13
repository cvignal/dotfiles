#!/usr/bin/env sh
# shellcheck disable=SC2059

# Launch the corresponding bars on the primary and any secondary screen.
#
# Author: Benedikt Vollmerhaus <benedikt@vollmerhaus.org>
# License: MIT

set -eu

# Retrieve interface names for network module
readonly ETH=$(ip link | grep -wv 'NO-CARRIER' | grep -m 1 -E '\b(en)' \
  | awk '{print substr($2, 1, length($2)-1)}')
readonly WIFI=$(ip link | grep -m 1 -E '\b(wl)' \
  | awk '{print substr($2, 1, length($2)-1)}')

readonly NC='\033[0m'
readonly IT='\033[3m'
readonly RED='\033[1;31m'
readonly BLUE='\033[1;34m'

kill_running_instances() {
  pkill polybar || true
  while pgrep -u "$(id -u)" -x polybar >/dev/null; do
    sleep 0.25
  done
}

launch_bar() {
  MONITOR=$1 IF_ETH=${ETH} IF_WIFI=${WIFI} polybar "$2" &
}

launch_secondary_bars() {
  IFS=$(printf '\n')
  printf "${BLUE}::${NC} Launching secondary bars on %s...\n" "$1"
  launch_bar "$1" top-secondary
  launch_bar "$1" bottom-secondary
}

main() {
  if ! command -v xrandr >/dev/null 2>&1; then
    printf '%b' \
      "${RED}error:${NC} ${IT}xrandr${NC} is required " \
      "for monitor detection but not installed.\n" >&2
    exit 1
  fi

  printf "Network interfaces: ${IT}%s${NC}, ${IT}%s${NC}\n" "${ETH}" "${WIFI}"

  printf "${BLUE}::${NC} Terminating running bar instances...\n"
  kill_running_instances

  printf "${BLUE}::${NC} Launching bars on primary monitor...\n"
  launch_bar '' top-primary
  launch_bar '' bottom-primary

  [[ $# -ge 1 ]] && launch_secondary_bars $1
}

main $@
# kak:filetype=sh
