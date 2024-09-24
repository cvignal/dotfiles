require "nvchad.options"

local g = vim.g
local o = vim.opt

o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4

o.wildmode = "longest,list,full"
o.backspace = "indent,eol,start"
o.hlsearch = false
o.incsearch = true

g.session_directory = tostring(os.getenv "HOME") .. "/.config/nvim/session"
g.session_autoload = "no"
g.session_autosave = "no"

o.backup = false
o.swapfile = false
o.compatible = false
o.so = 7
o.undodir = tostring(os.getenv "HOME") .. "/.cache/nvim/undodir"
o.undofile = true
o.foldmethod = "indent"
o.foldlevelstart = 20

o.mouse = ""
