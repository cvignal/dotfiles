-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}
local userPlugins = require "custom.plugins"
local pluginConfs = require "custom.plugins.configs"

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
  override = {
    ["L3MON4D3/LuaSnip"] = {},
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["NvChad/nvterm"] = pluginConfs.nvterm
  },
  remove = {
    "nathom/filetype.nvim",
  },
  user = userPlugins
}

return M
