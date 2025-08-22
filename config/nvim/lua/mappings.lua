require("nvchad.mappings")

local map = vim.keymap.set

-- TODO comments
map("n", "]t", function()
	require("todo-comments").jump_next()
end)
map("n", "[t", function()
	require("todo-comments").jump_prev()
end)

-- Diagnostics
map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

-- DadBod
map("n", "<leader>Du", "<cmd>DBUIToggle<Cr>", { desc = "Database: Toggle UI" })
map("n", "<leader>Df", "<cmd>DBUIFindBuffer<Cr>", { desc = "Database: Find buffer" })
map("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<Cr>", { desc = "Database: Rename buffer" })
map("n", "<leader>Dr", "<cmd>DBUILastQueryInfo<Cr>", { desc = "Database: Last query info" })

-- gitsigns
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<Cr>", { desc = "Toggle current line git blame" })

-- DAP
map("n", "<leader>dk", "<cmd>lua require 'dap'.continue()<cr>", { desc = "DAP continue" })
map("n", "<leader>dj", "<cmd>lua require 'dap'.step_over()<cr>", { desc = "DAP step over" })
map("n", "<leader>dh", "<cmd>lua require 'dap'.step_into()<cr>", { desc = "DAP step into" })
map("n", "<leader>dl", "<cmd>lua require 'dap'.step_out()<cr>", { desc = "DAP step out" })
map("n", "<leader>b", "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", { desc = "DAP toggle breakpoint" })
map("n", "<leader>dp", "<cmd>lua require 'dap'.run_last()<cr>", { desc = "DAP run last" })
