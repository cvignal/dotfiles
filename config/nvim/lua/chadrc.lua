---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
--
M.base46 = {
	theme = "solarized_light",
}

M.ui = {
	statusline = {
		theme = "minimal",
		separator_style = "block",
	},
}

M.nvdash = {
	load_on_startup = false,

	header = {
		" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
		" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
		" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
		" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
		" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
		" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	},

	buttons = {
		{ txt = "  Find File", keys = "Spc f f", cmd = "FzfLua files" },
		{ txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "FzfLua oldfiles" },
		{ txt = "󰈭  Find Word", keys = "Spc f w", cmd = "FzfLua grep" },
		{ txt = "  Bookmarks", keys = "Spc m a", cmd = "FzfLua marks" },
		{ txt = "  Themes", keys = "Spc t h", cmd = "FzfLua colorschemes" },
		{ txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
	},
}

-- M.plugins = "plugins"

-- check core.mappings for table structure
-- M.mappings = require "mappings"

return M
