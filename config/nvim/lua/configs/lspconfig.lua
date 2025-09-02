require("nvchad.configs.lspconfig").defaults()

local x = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	float = { border = "single" },
})

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
	"lua_ls",
	"pylsp",
	"tailwindcss",
	"elixirls",
	"expert",
	"protols",
}
vim.lsp.enable(servers)
