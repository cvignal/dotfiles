local M = {}

M.treesitter = {
	parsers = {
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
		"starlark",
	},
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
