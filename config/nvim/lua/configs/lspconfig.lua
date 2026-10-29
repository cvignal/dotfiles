require("nvchad.configs.lspconfig").defaults()

local x = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	float = { border = "single" },
})
vim.lsp.config("*", {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = false },
		},
	},
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
	"expert",
	"protols",
	"jdtls",
}
vim.lsp.enable(servers)
