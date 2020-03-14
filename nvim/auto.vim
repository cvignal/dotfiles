autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
