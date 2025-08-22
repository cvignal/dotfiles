local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_init = require("nvchad.configs.lspconfig").on_init

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		on_attach(_, args.buf)
	end,
})

local x = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	float = { border = "single" },
})

vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })

local servers = {
	"html",
	"cssls",
	"ts_ls",
	"clangd",
	"gopls",
	"rust_analyzer",
	"svelte",
	"terraformls",
	"ruff",
	"rust_analyzer",
	"starpls",
	"elixirls",
	"lua_ls",
	"pylsp",
	"tailwindcss",
}
vim.lsp.enable(servers)
