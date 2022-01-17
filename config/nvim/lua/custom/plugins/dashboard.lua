local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
 " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
 " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
 " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
 " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
 " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
 " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

g.dashboard_custom_section = {
   a = { description = { "  Find File                 , f f" }, command = "Telescope find_files" },
   b = { description = { "  Recents                   , f o" }, command = "Telescope oldfiles" },
   c = { description = { "  Find Word                 , f w" }, command = "Telescope live_grep" },
   d = { description = { "洛 New File                  , f n" }, command = "DashboardNewFile" },
   e = { description = { "  Bookmarks                 , b m" }, command = "Telescope marks" },
   f = { description = { "  Load Last Session         , l  " }, command = "SessionLoad" },
}

g.dashboard_custom_footer = {
   "   ",
}

