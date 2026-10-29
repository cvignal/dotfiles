# -*- sh -*-
autoload -U zutil
autoload -U +X bashcompinit && bashcompinit
autoload compinit && {
    autoload -U complist
    # Only regenerate compdump once per day
    if [[ -n $ZSH/run/u/$HOST-$UID/zcompdump(#qN.mh+24) ]]; then
        compinit -u -d $ZSH/run/u/$HOST-$UID/zcompdump
    else
        compinit -C -u -d $ZSH/run/u/$HOST-$UID/zcompdump
    fi
}

setopt auto_menu
setopt auto_remove_slash
setopt complete_in_word
setopt always_to_end
setopt glob_complete
unsetopt list_beep

zstyle ':completion:*' completer _expand_alias _complete _match _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command "ps -eo pid,user,comm,cmd -w -w"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/run/u/$HOST-$UID/cache/
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:history-words:*' remove-all-dups true

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:*:git-fetch:argument-rest:' tag-order '!remote-repositories'
zstyle ':completion:*:*:git-pull:argument-1:' tag-order '!remote-repositories'

# In menu, select items with +
zmodload -i zsh/complist
bindkey -M menuselect "+" accept-and-menu-complete



#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
