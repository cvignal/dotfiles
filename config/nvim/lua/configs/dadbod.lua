local M = {}

local g = vim.g

function M.setup()
  g.db_ui_save_location = vim.fn.stdpath "data" .. require("plenary.path").path.sep .. "db_ui"
  g.db_ui_auto_execute_table_helpers = 1
  g.db_ui_winwidth = 50

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })
end

return M
