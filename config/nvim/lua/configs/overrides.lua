local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"c",
		"markdown",
		"markdown_inline",
		"go",
		"terraform",
		"elixir",
	},
	indent = {
		enable = true,
		disable = {
			"python",
			"yaml",
		},
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	incremental_selection = {
		enable = true,
		disable = { "yaml" },
	},
	additional_vim_regex_highlighting = false,
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"gopls",
		"deno",
	},
}

return M
