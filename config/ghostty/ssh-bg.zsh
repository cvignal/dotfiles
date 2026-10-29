# Visual cue for SSH sessions: tint the terminal background while SSH'd, reset on exit.
#
# Implemented with preexec/precmd hooks (not an `ssh()` wrapper) so it works even
# if `ssh` is aliased — a plain `ssh() { ... }` wrapper fails to parse with
# "parse error near `()`" when an ssh alias exists in the shell.
#
# How it works:
#   - preexec hook: when the command line contains `ssh` as a word, emit OSC 11
#     to set the background color. Per-surface in Ghostty, so only the split
#     running ssh changes; other splits stay untouched.
#   - precmd hook: when the prompt returns (ssh exited), emit OSC 111 to reset
#     the background to the theme default.
#
# Override the color with:  SSH_BG_COLOR=#123456  (any hex or named color).
# Default is a subtle warm tint of the Solarized Light background (#fdf6e3 → #f0ead3).

autoload -U add-zsh-hook

_ghostty_ssh_bg="${SSH_BG_COLOR:-#f0ead3}"

_ghostty_ssh_preexec() {
  # Match `ssh` as a word: handles `ssh host`, `sudo ssh host`, `x && ssh y`.
  if [[ "$1" =~ (^|[[:space:]])ssh([[:space:]]|$) ]]; then
    printf '\033]11;%s\007' "$_ghostty_ssh_bg"
  fi
}

_ghostty_ssh_precmd() {
  printf '\033]111\007'
}

add-zsh-hook preexec _ghostty_ssh_preexec
add-zsh-hook precmd _ghostty_ssh_precmd
