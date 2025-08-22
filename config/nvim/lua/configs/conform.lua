local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		markdown = { "prettier" },
		-- yaml = { "prettier" },

		-- sh = { "shfmt" },
		go = { "goimports", "gofmt" },
		rust = { "rustfmt" },
		elixir = { "mix" },
		eelixir = { "mix" },
		heex = { "mix" },
		surface = { "mix" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
		format_on_save = function(bufnr)
			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			---@type conform.FormatOpts
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
	formatters = {
		prettier = {
			prepend_args = function()
				return {
					"--config-precedence",
					"prefer-file",
				}
			end,
		},
	},
}

require("conform").setup(options)
