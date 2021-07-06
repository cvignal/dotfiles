-- load all plugins
require "pluginList"
require "misc-utils"
require "top-bufferline"

--require("colorizer").setup()
--require("neoscroll").setup() -- smooth scroll

local cmd = vim.cmd
local g = vim.g

g.mapleader = ","

-- colorscheme related stuff
g.nvchad_theme = "gruvbox"
cmd "syntax on"

local base16 = require "base16"
base16(base16.themes["nvchad-softgruv"], true)
cmd([[hi Normal guibg=NONE ctermbg=NONE]])

require "highlights"
require "mappings"
require "file-icons"
require "statusline"


-- autocommands for specific files
vim.api.nvim_exec(
  [[
    au BufEnter term://* setlocal nonumber
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
    au BufEnter term://* set laststatus=0
    au BufWritePost *Xresources,*Xdefaults !xrdb %
    au BufWritePre * :%s/\s\+$//e
    au BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts
    au BufWritePost *sxhkdrc !pkill -USR1 sxhkd
    au BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]],
  false
)
