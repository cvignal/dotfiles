#!/usr/bin/env sh
# shellcheck disable=SC2059

# Download and install the M+ Nerd Font for the current user.
#
# See:
#   * https://mplus-fonts.osdn.jp/about-en.html
#   * https://github.com/ryanoasis/nerd-fonts
#
# Author: Benedikt Vollmerhaus <benedikt@vollmerhaus.org>
# License: MIT

set -eu

readonly FONT_VERSION='2.0.0'
readonly FONT_NAME='M+ 1m'
readonly FONT_STYLES='Bold Light Medium Regular Thin'
readonly USER_FONT_DIR="${HOME}/.local/share/fonts"

readonly DL_URL=$(printf '%s' \
  "https://github.com/ryanoasis/nerd-fonts/raw/" \
  "${FONT_VERSION}/patched-fonts/MPlus/%s/complete/%s")
readonly FILENAME_FORMAT="${FONT_NAME}%s Nerd Font Complete.ttf"

readonly NC='\033[0m'
readonly DIM='\033[2m'
readonly IT='\033[3m'
readonly GREEN='\033[1;32m'
readonly BLUE='\033[1;34m'

download_font() {
  font_style=$1

  if [ "${font_style}" != 'Regular' ]; then
    style_in_filename=$(printf " ${font_style}" | awk '{print tolower($0)}')
  else
    style_in_filename=''
  fi

  filename=$(printf "${FILENAME_FORMAT}" "${style_in_filename}")
  encoded_filename=$(printf "${filename}" | sed 's/ /%20/g')
  url=$(printf "${DL_URL}" "${font_style}" "${encoded_filename}")

  printf " ${DIM}[${NC} ${DIM}]${NC} %s " "${filename}"
  curl -fLsS -o "${filename}" "${url}"
  printf "\r ${DIM}[${NC}%b${DIM}]${NC} %s\n" "${GREEN}✓${NC}" "${filename}"
}

main() {
  mkdir -p "${USER_FONT_DIR}/${FONT_NAME}"
  cd "${USER_FONT_DIR}/${FONT_NAME}"

  printf "${BLUE}::${NC} Downloading ${IT}%s${NC} fonts...\n" "${FONT_NAME}"
  for style in ${FONT_STYLES}; do
    download_font "${style}"
  done

  printf "${BLUE}::${NC} Rebuilding font cache...\n"
  fc-cache -f "${USER_FONT_DIR}"
}

main

# kak:filetype=sh
