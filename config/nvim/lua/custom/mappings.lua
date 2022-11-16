local M = {}

M.todo_comments = {
  n = {
    ["]t"] = {function() require("todo-comments").jump_next() end},
    ["[t"] = {function() require("todo-comments").jump_prev() end}
  }
}

M.lspconfig = {
  n = {
    ["gn"] = {"<cmd>lua vim.diagnostic.goto_next()<CR>"},
    ["gp"] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>"}
  }

}

return M
