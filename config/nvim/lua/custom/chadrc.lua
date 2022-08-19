-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}
local userPlugins = require "custom.plugins"

M.ui = {
   theme = "catppuccin",
   -- transparency = true
}

M.options = {
  user = function()
    require("custom.options")
  end,
}

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    }
  },
  override = {
    ["L3MON4D3/LuaSnip"] = {}
  },
  remove = {
    "nathom/filetype.nvim",
  },
  user = userPlugins
}

return M
