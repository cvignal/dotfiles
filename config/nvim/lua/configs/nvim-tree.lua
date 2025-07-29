local M = {}

function M.grep_at_current_tree_node()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	if not node then
		return
	end
	require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })
end

local function custom_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set(
		"n",
		"<Leader>gr",
		":lua require'configs.nvim-tree'.grep_at_current_tree_node()<CR> ",
		opts("live grep at current tree node")
	)
end

function M.setup()
	local config = {
		filters = { dotfiles = false },
		disable_netrw = true,
		hijack_cursor = true,
		sync_root_with_cwd = true,
		git = {
			enable = true,
			ignore = false,
			timeout = 1000,
		},
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			width = 40,
			preserve_window_proportions = true,
		},
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			icons = {
				show = {
					git = true,
				},
			},
		},
		on_attach = custom_on_attach,
	}

	require("nvim-tree").setup(config)
end

return M
