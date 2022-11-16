-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}

M.ui = {
   theme = "solarized_dark",
   transparency = true
}

M.options = {
  user = function()
    require("custom.options")
  end,
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

return M
