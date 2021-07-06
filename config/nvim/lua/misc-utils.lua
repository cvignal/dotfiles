local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local g = vim.g

local home = os.getenv("HOME")

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
--opt("o", "bg", "dark")
--vim.cmd([[colorscheme gruvbox]])
opt("w", "number", true)
opt("o", "relativenumber", true)
opt("o", "numberwidth", 2)
opt("w", "cul", true)
opt("o", "wildmode", "longest,list,full")
opt("o", "backspace", "indent,eol,start")
opt("o", "hlsearch", false)
opt("o", "incsearch", true)
opt("o", "smartcase", true)
-- Session management
g.session_directory = tostring(os.getenv("HOME")) .. "/.config/nvim/session"
g.session_autoload = "no"
g.session_autosave = "no"
g.session_command_aliases = 1
opt("o", "backup", false)
opt("o", "swapfile", false)
opt("o", "compatible", false)

opt("o", "so", 7)
opt("o", "undodir", tostring(os.getenv("HOME")) .. "/.cache/nvim/undodir")
opt("o", "undofile", true)

opt("o", "foldmethod", "indent")
opt("o", "foldlevelstart", 20)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)


opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "clipboard", "unnamedplus")
opt("o", "timeoutlen", 500)

-- for indenline
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
-- file extension specific tabbing
-- vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=4 softtabstop=4]])

-- blankline config
M.blankline = function()
	g.indentLine_enabled = 1
	g.indent_blankline_char = "▏"

	g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
	g.indent_blankline_buftype_exclude = {"terminal"}

	g.indent_blankline_show_trailing_blankline_indent = false
	g.indent_blankline_show_first_indent_level = false
end
return M
