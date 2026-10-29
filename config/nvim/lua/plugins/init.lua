local overrides = require("configs.overrides")

return {
	"nvim-lua/plenary.nvim",

	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
	},

	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	"nvchad/volt", -- optional, needed for theme switcher
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"mason-org/mason.nvim",
		lazy = false,
	},

	-- override plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ts = require("nvim-treesitter")
			require("nvim-treesitter.install").prefer_git = true
			ts.install(overrides.treesitter.parsers)

			vim.treesitter.language.register("starlark", "bzl")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					if ft == "" then
						return
					end
					-- Enable treesitter highlighting
					pcall(vim.treesitter.start, args.buf)
					-- Enable treesitter indentation (except disabled filetypes)
					local indent_disabled = { python = true, yaml = true }
					if not indent_disabled[ft] then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("configs.nvim-tree").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		config = function()
			require("configs.gitsigns").setup()
		end,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"tpope/vim-dadbod",
		opt = true,
		dependencies = {
			{ "kristijanhusak/vim-dadbod-ui" },
			-- { "kristijanhusak/vim-dadbod-completion" },
		},
		config = function()
			require("configs.dadbod").setup()
		end,
		cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
	},
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	lazy = false,
	-- },
	-- {
	-- 	"leoluz/nvim-dap-go",
	-- 	config = function()
	-- 		require("dap-go").setup({
	-- 			-- Additional dap configurations can be added.
	-- 			-- dap_configurations accepts a list of tables where each entry
	-- 			-- represents a dap configuration. For more details do:
	-- 			-- :help dap-configuration
	-- 			dap_configurations = {
	-- 				{
	-- 					-- Must be "go" or it will be ignored by the plugin
	-- 					type = "go",
	-- 					name = "Attach remote",
	-- 					mode = "remote",
	-- 					request = "attach",
	-- 				},
	-- 				{
	-- 					type = "go",
	-- 					name = "Debug (Build Flags)",
	-- 					request = "launch",
	-- 					program = "${file}",
	-- 					buildFlags = require("dap-go").get_build_flags,
	-- 				},
	-- 			},
	-- 			-- delve configurations
	-- 			delve = {
	-- 				-- the path to the executable dlv which will be used for debugging.
	-- 				-- by default, this is the "dlv" executable on your PATH.
	-- 				path = "dlv",
	-- 				-- time to wait for delve to initialize the debug session.
	-- 				-- default to 20 seconds
	-- 				initialize_timeout_sec = 20,
	-- 				-- a string that defines the port to start delve debugger.
	-- 				-- default to string "${port}" which instructs nvim-dap
	-- 				-- to start the process in a random available port
	-- 				port = "${port}",
	-- 				-- additional args to pass to dlv
	-- 				args = {},
	-- 				-- the build flags that are passed to delve.
	-- 				-- defaults to empty string, but can be used to provide flags
	-- 				-- such as "-tags=unit" to make sure the test suite is
	-- 				-- compiled during debugging, for example.
	-- 				-- passing build flags using args is ineffective, as those are
	-- 				-- ignored by delve in dap mode.
	-- 				build_flags = "-tags=integration,e2e",
	-- 			},
	-- 		})
	-- 	end,
	-- 	lazy = false,
	-- },
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	dependencies = {
	-- 		{
	-- 			"mfussenegger/nvim-dap",
	-- 			"nvim-neotest/nvim-nio",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		local dap, dapui = require("dap"), require("dapui")
	-- 		dapui.setup()
	-- 		dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 	end,
	-- 	lazy = false,
	-- },
	-- {
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	config = function()
	-- 		require("nvim-dap-virtual-text").setup()
	-- 	end,
	-- 	lazy = false,
	-- },
	{
		"andreshazard/vim-freemarker",
		lazy = false,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
	},
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	cmd = {
	-- 		"LazyGit",
	-- 		"LazyGitConfig",
	-- 		"LazyGitCurrentFile",
	-- 		"LazyGitFilter",
	-- 		"LazyGitFilterCurrentFile",
	-- 	},
	-- 	-- optional for floating window border decoration
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- 	-- order to load the plugin when the command is run for the first time
	-- 	keys = {
	-- 		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	-- 	},
	-- },
	{
		"mfussenegger/nvim-jdtls",
		config = function()
			require("configs.jdtls")
		end,
		lazy = false,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>gx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>gX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false win.size=60<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.size=60<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"rafikdraoui/jj-diffconflicts",
		lazy = false,
	},
	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			require("fzf-lua").setup({
				winopts = {
					width = 0.95,
				},
				files = {
					winopts = {
						width = 0.98,
					},
				},
			})
		end,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- use latest release, remove to use latest commit
		lazy = false,
		config = function()
			require("configs.obsidian").setup()
		end,
		dependencies = {
			"ibhagwan/fzf-lua",
		},
	},

	-- Disable plugins
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
	},
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
	},
}
