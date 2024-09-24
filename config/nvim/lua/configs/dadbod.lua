local M = {}

local g = vim.g

local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

function M.setup()
  g.db_ui_save_location = vim.fn.stdpath "data" .. require("plenary.path").path.sep .. "db_ui"
  g.db_ui_auto_execute_table_helpers = 1
  g.db_ui_winwidth = 50

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return M
