require "nvchad.mappings"

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

-- M.dap = {
--   n = {
--     ["<leader>dk"] = { "<cmd>lua require 'dap'.continue()<cr>", "DAP continue" },
--     ["<leader>dj"] = { "<cmd>lua require 'dap'.step_over()<cr>", "DAP step over" },
--     ["<leader>dh"] = { "<cmd>lua require 'dap'.step_into()<cr>", "DAP step into" },
--     ["<leader>dl"] = { "<cmd>lua require 'dap'.step_out()<cr>", "DAP step out" },
--     ["<leader>b"] = { "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", "DAP toggle breakpoint" },
--     ["<leader>dp"] = { "<cmd>lua require 'dap'.run_last()<cr>", "DAP run last" },
--   },
-- }
