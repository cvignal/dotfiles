local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "c",
    "markdown",
    "markdown_inline",
    "go",
    "terraform",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = { "yaml" },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "gopls",
    "deno",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },

  view = {
    width = 40,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.copilot = {
  suggestion = {
    enable = false,
  },
  panel = {
    enable = false,
  },
}
return M
