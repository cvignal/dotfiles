require("nvchad.autocmds")
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
-- Don't show any numbers inside terminals

autocmd("TermOpen", {
	pattern = "term://*",
	command = "setlocal nonumber norelativenumber | setfiletype terminal",
})

-- Open a file from its last left off position
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- File extension specific tabbing
autocmd("Filetype", {
	pattern = "apiblueprint",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

autocmd("Filetype", {
	pattern = "terraform",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

autocmd("Filetype", {
	pattern = "json",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

autocmd("Filetype", {
	pattern = "lua",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

autocmd("BufWritePost", {
	pattern = { "*Xresources", "*Xdefaults" },
	command = "!xrdb %",
})

local function trim_whitespace()
	if vim.bo.filetype ~= "markdown" then
		local save_cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, save_cursor)
	end
end

autocmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" }, {
	pattern = "*",
	callback = trim_whitespace,
})

usercmd("TrimWhitespace", function()
	trim_whitespace()
end, {})

autocmd("BufWritePost", {
	pattern = { "~/.config/bmdirs", "~/.config/bmfiles" },
	command = "!shortcuts",
})

autocmd("BufWritePost", {
	pattern = "*sxhkdrc",
	command = "!pkill -USR1 sxhkd",
})

autocmd("BufNewFile", {
	pattern = "*.tfvars",
	command = "setfiletype terraform",
})

autocmd("BufRead", {
	pattern = "*.tfvars",
	command = "setfiletype terraform",
})

autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})
