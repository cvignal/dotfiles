local M =  {}

M.treesitter = {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  ensure_installed = {
    "lua",
    "html",
    "css",
    "bash",
    "elixir",
    "erlang",
    "json",
    "ruby",
    "markdown",
    "vim"
  }
}

M.nvterm = {
  terminals = {
    type_opts = {
      vertical = { location = "rightbelow", split_ratio = 0.3 },
    },
  },
}

return M
