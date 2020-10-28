autoload -U colors && colors

COMMON_PROMPT_SYMBOL="❯"
# Colors
COMMON_COLORS_HOST_ME=yellow
COMMON_COLORS_HOST_USER=blue
COMMON_COLORS_HOST_AWS_VAULT=yellow
COMMON_COLORS_CURRENT_DIR=magenta
COMMON_COLORS_RETURN_STATUS_TRUE=yellow
COMMON_COLORS_RETURN_STATUS_FALSE=red
COMMON_COLORS_GIT_STATUS_DEFAULT=green
COMMON_COLORS_GIT_STATUS_STAGED=red
COMMON_COLORS_GIT_STATUS_UNSTAGED=yellow
COMMON_COLORS_GIT_PROMPT_SHA=green
COMMON_COLORS_BG_JOBS=yellow

# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# Host
common_host() {
    echo "%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M :%{$reset_color%}"
}

# Current directory
common_current_dir() {
  echo -n "%{$fg[$COMMON_COLORS_CURRENT_DIR]%}%~ "
}

# Prompt symbol
common_return_status() {
  echo -n "%(?.%F{$COMMON_COLORS_RETURN_STATUS_TRUE}.%F{$COMMON_COLORS_RETURN_STATUS_FALSE})$COMMON_PROMPT_SYMBOL%f "
}

# Git prompt SHA
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{$COMMON_COLORS_GIT_PROMPT_SHA}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

# Background Jobs
common_bg_jobs() {
  bg_status="%{$fg[$COMMON_COLORS_BG_JOBS]%}%(1j.↓%j .)"
  echo -n $bg_status
}

_vbe_setprompt () {
    setopt prompt_subst
    PROMPT="$(common_host)$(common_current_dir)$(common_bg_jobs)$(common_return_status)"
}
