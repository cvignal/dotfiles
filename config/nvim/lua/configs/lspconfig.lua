local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = {
	"html",
	"cssls",
	"ts_ls",
	"clangd",
	"gopls",
	"pylsp",
	"rust_analyzer",
	"svelte",
	"terraformls",
	"elixirls",
	"ruff",
}

local function settings_lsp(lsp)
	if lsp == "gopls" then
		return {
			gopls = { buildFlags = { "-tags=integration,e2e" } },
		}
	elseif lsp == "pylsp" then
		return {
			-- configure plugins in pylsp
			pylsp = {
				plugins = {
					pyflakes = { enabled = false },
					pylint = { enabled = false },
				},
			},
		}
	else
		return {}
	end
end

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
})

for _, lsp in ipairs(servers) do
	local settings = settings_lsp(lsp)
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = settings,
	})
end
