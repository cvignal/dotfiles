local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local function enable_codelens(bufnr)
	pcall(vim.lsp.codelens.refresh)

	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = bufnr,
		group = java_cmds,
		desc = "refresh codelens",
		callback = function()
			pcall(vim.lsp.codelens.refresh)
		end,
	})
end

local function enable_debugger(bufnr)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()

	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>df", "<cmd>lua require('jdtls').test_class()<cr>", opts)
	vim.keymap.set("n", "<leader>dn", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		if client.name == "jdtls" then
			enable_debugger(args.buf)

			enable_codelens(args.buf)

			-- The following mappings are based on the suggested usage of nvim-jdtls
			-- https://github.com/mfussenegger/nvim-jdtls#usage

			local opts = { buffer = args.buf }
			vim.keymap.set("n", "<A-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
			vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
			vim.keymap.set("x", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
			vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
			vim.keymap.set("x", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
			vim.keymap.set("x", "crm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
			vim.keymap.set("n", "<leader>pjp", "<cmd>lua require('jdtls').javap()<cr>", opts)
		end
	end,
})
