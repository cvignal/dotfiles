-- This is an example init file , its supposed to be placed in /lua/custom dir
-- lua/custom/init.lua

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

require "custom.autocmds"
require "custom.options"

-- MAPPINGS
-- To add new mappings, use the "setup_mappings" hook,
-- local map = require("core.utils").map

-- map("n", "<leader>cc", ":Telescope <CR>")
-- map("n", "<leader>q", ":q <CR>")

-- NOTE : opt is a variable  there (most likely a table if you want multiple options),
-- you can remove it if you dont have any custom options

-- Install plugins
-- To add new plugins, use the "install_plugins" hook,

-- examples below:

local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
  use {
    "williamboman/nvim-lsp-installer",
  }

  use {
    "vimwiki/vimwiki"
  }

  use {
    "nvim-telescope/telescope-media-files.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
          extensions = {
             media_files = {
                filetypes = { "png", "webp", "jpg", "jpeg" },
                find_cmd = "rg", -- find command (defaults to `fd`)
             },
          },
       }
       require("telescope").load_extension "media_files"
    end,
  }

  use {
    "elixir-editors/vim-elixir"
  }

  use {
    "kylef/apiblueprint.vim"
  }

  use {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gdiff",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Gw",
    },
  }
end)

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
