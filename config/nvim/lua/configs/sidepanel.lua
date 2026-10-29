local M = {}

local function get_win_by_ft(ft)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == ft then
			return win
		end
	end
	return nil
end

local function is_trouble_symbols_open()
	local trouble = require("trouble")
	return trouble.is_open({ mode = "symbols" })
end

function M.toggle()
	local nvim_tree_api = require("nvim-tree.api")
	local trouble = require("trouble")

	local tree_win = get_win_by_ft("NvimTree")
	local symbols_open = is_trouble_symbols_open()

	-- If either is open, close both
	if tree_win or symbols_open then
		if symbols_open then
			trouble.close({ mode = "symbols" })
		end
		if tree_win then
			nvim_tree_api.tree.close()
		end
		return
	end

	-- Both are closed, open both
	local current_win = vim.api.nvim_get_current_win()

	-- Open nvim-tree first
	nvim_tree_api.tree.open()

	-- Wait for nvim-tree, then open symbols below it
	vim.defer_fn(function()
		local nvim_tree_win = get_win_by_ft("NvimTree")
		if not nvim_tree_win then
			return
		end

		-- Focus nvim-tree so win.relative=win targets it
		vim.api.nvim_set_current_win(nvim_tree_win)

		-- Open trouble symbols below nvim-tree
		trouble.open({
			mode = "symbols",
			focus = false,
			win = {
				type = "split",
				relative = "win",
				position = "bottom",
				size = 0.4,
			},
		})

		-- Return to original window
		vim.defer_fn(function()
			if vim.api.nvim_win_is_valid(current_win) then
				vim.api.nvim_set_current_win(current_win)
			end
		end, 50)
	end, 50)
end

return M
