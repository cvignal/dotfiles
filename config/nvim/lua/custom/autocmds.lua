-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show status line on certain windows
vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]
vim.cmd [[ au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif ]]

vim.cmd [[ au BufEnter term://* set laststatus=0 ]]
vim.cmd [[ au BufWritePost *Xresources,*Xdefaults !xrdb % ]]
vim.cmd [[ au BufWritePre * :%s/\s\+$//e ]]
vim.cmd [[ au BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts ]]
vim.cmd [[ au BufWritePost *sxhkdrc !pkill -USR1 sxhkd ]]
vim.cmd [[ au BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
