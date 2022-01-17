-- OPTIONS
-- New options

vim.opt.wildmode = "longest,list,full"
vim.opt.backspace = "indent,eol,start"
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.g.session_directory = tostring(os.getenv("HOME")) .. "/.config/nvim/session"
vim.g.session_autoload = "no"
vim.g.session_autosave = "no"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.so = 7
vim.opt.undodir = tostring(os.getenv("HOME")) .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 20
