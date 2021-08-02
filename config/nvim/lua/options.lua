local opt = vim.opt
local g = vim.g

opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"

-- disable nvim intro
opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
-- opt.relativenumber = true

-- Indenline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

opt.wildmode = "longest,list,full"
opt.backspace = "indent,eol,start"
opt.hlsearch = false
opt.incsearch = true
opt.smartcase = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

g.mapleader = ","
g.auto_save = false

-- Session management
g.session_directory = tostring(os.getenv("HOME")) .. "/.config/nvim/session"
g.session_autoload = "no"
g.session_autosave = "no"
g.session_command_aliases = 1
opt.backup = false
opt.swapfile = false
opt.compatible = false
opt.so = 7
opt.undodir = tostring(os.getenv("HOME")) .. "/.cache/nvim/undodir"
opt.undofile = true

-- Folding
opt.foldmethod = indent
opt.foldlevelstart = 20

-- disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Don't show status line on vim terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]

-- Open a file from its last left off position
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

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
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]
