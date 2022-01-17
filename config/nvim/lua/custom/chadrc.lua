-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "gruvchad",
   -- transparency = true
}

M.options = {
  mapleader = ",",
  relativenumber = true,
  nvChad = {
    insert_nav = false
  }
}

M.mappings = {
}

M.plugins = {
  status = {
    dashboard = true
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    }
  },
  default_plugin_config_replace = {
    dashboard = "custom.plugins.dashboard"
  }
}

return M
