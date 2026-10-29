-- Obsidian: vaults, project workspaces, daily notes, task filtering
local M = {}

local workspaces = {
	{
		name = "perso",
		path = "~/Perso/obsidian",
	},
}

local function vault()
	-- primary vault root
	return vim.fs.normalize(workspaces[1].path)
end

M.setup = function()
	-- conceallevel must be 1 or 2 for obsidian.nvim's markdown UI (issue #286).
	-- Registered BEFORE require("obsidian").setup() so it runs before the
	-- plugin's own BufEnter check, which otherwise warns while it is still 0.
	for _, ws in ipairs(workspaces) do
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = vim.fs.normalize(ws.path) .. "/**.md",
			callback = function()
				vim.wo.conceallevel = 2
			end,
		})
	end

	require("obsidian").setup({
		-- readable filenames: "My design doc" -> my-design-doc.md
		-- (default is zettel_id: <unixtime>-<random letters>.md)
		note_id_func = require("obsidian.builtin").title_id,

		picker = {
			name = "fzf-lua", -- or fzf-lua
		},
		legacy_commands = false, -- this will be removed in 4.0.0
		workspaces = workspaces,
		daily_notes = {
			folder = "Daily",
			date_format = "YYYY-MM-DD",
			template = "daily.md",
		},
		templates = {
			folder = "Templates",
			date_format = "YYYY-MM-DD",
			time_format = "HH:mm",
		},
	})

	-- Compat shim: obsidian's <C-x> "create note from query" in pickers reads
	-- fzf_opts.query, but current fzf-lua passes the typed query as
	-- opts.last_query instead -> obsidian gets nil and silently aborts.
	-- Fall back to fzf-lua's last_query when the query doesn't come through.
	local picker_mappings = require("obsidian.picker.mappings")
	local orig_new_note = picker_mappings.new_note
	picker_mappings.new_note = function(query)
		if not query or vim.trim(query) == "" then
			local cfg = require("fzf-lua.config")
			query = cfg.__resume_data and cfg.__resume_data.last_query
		end
		orig_new_note(query)
	end

	-- Global entry points
	vim.keymap.set("n", "<leader>o", "<cmd>Obsidian quick_switch<CR>", { desc = "Obsidian: find note" })
	vim.keymap.set("n", "<leader>p", M.projects, { desc = "Obsidian: open project" })
	vim.keymap.set("n", "<leader>t", M.tasks, { desc = "Obsidian: open tasks (vault-wide)" })

	-- :ObsidianNewProject <name> -> Projects/<name>/ with index.md + todo.md, then opens it
	vim.api.nvim_create_user_command("ObsidianNewProject", function(data)
		local name = vim.trim(data.args or "")
		if name == "" then
			vim.notify("Usage: :ObsidianNewProject <name>", vim.log.levels.WARN)
			return
		end
		local path = vault() .. "/Projects/" .. name
		if vim.fn.isdirectory(path) == 1 then
			vim.notify("Project already exists: " .. path, vim.log.levels.WARN)
			return
		end
		vim.fn.mkdir(path, "p")
		local index = io.open(path .. "/index.md", "w")
		index:write("# " .. name .. "\n\n## Goal\n\n\n## Notes\n\n")
		index:close()
		local todo = io.open(path .. "/todo.md", "w")
		todo:write("# " .. name .. " - tasks\n\n- [ ] \n")
		todo:close()
		M.open_project(path)
	end, { nargs = "?" })

	-- "Obsidian mode": buffer-local mappings, only active inside vault notes.
	-- They shadow the global <leader> mappings (fzf-lua files/grep) so the same
	-- keys operate on notes when you're in one.
	vim.api.nvim_create_autocmd("User", {
		pattern = "ObsidianNoteEnter",
		callback = function(ev)
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = "Obsidian: " .. desc })
			end

			-- Same keys as global find mappings, scoped to the vault
			map("<leader>ff", "<cmd>Obsidian quick_switch<CR>", "find note by name")
			map("<leader>fw", "<cmd>Obsidian search<CR>", "grep notes")
			map("<leader>fb", "<cmd>Obsidian backlinks<CR>", "backlinks")
			map("<leader>fl", "<cmd>Obsidian links<CR>", "outgoing links")
			map("<leader>fg", "<cmd>Obsidian tags<CR>", "tags")
			map("<leader>fn", "<cmd>Obsidian new<CR>", "new note")
			map("<leader>fr", "<cmd>Obsidian rename<CR>", "rename note")
			map("<leader>ft", "<cmd>Obsidian today<CR>", "today's note")
			map("<leader>fs", "<cmd>Obsidian workspace<CR>", "switch workspace")
			map("<leader>fe", function()
				local api = require("nvim-tree.api")
				api.tree.open()
				api.tree.change_root(tostring(Obsidian.dir))
			end, "nvim-tree at vault root")
		end,
	})
end

-- Open a project: cd into it (tree + ,ff/,fw scope to the project), then
--   tree + symbols | index.md | todo.md
-- Idempotent: safe to call with another project already laid out.
local function panel_win(w)
	local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
	return ft == "NvimTree" or ft == "trouble"
end

M.open_project = function(path)
	local function safe(fn)
		local ok, err = pcall(fn)
		if not ok then
			vim.notify("open_project: " .. tostring(err), vim.log.levels.WARN)
		end
		return ok
	end

	path = vim.fs.normalize(path)
	local index = path .. "/index.md"
	local todo = path .. "/todo.md"
	if vim.fn.filereadable(index) == 0 then
		vim.notify("No index.md in " .. path, vim.log.levels.WARN)
		return
	end

	safe(function()
		vim.cmd("cd " .. vim.fn.fnameescape(path))
	end)

	-- tree: re-root if open, otherwise open it at the project
	local tree_win
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "NvimTree" then
			tree_win = w
		end
	end
	if tree_win then
		safe(function()
			require("nvim-tree.api").tree.change_root(path)
		end)
	else
		-- open first: change_root is a no-op before the tree exists
		safe(function()
			require("nvim-tree.api").tree.open()
			require("nvim-tree.api").tree.change_root(path)
		end)
		-- symbols below the tree, deferred like sidepanel does
		vim.defer_fn(function()
			safe(function()
				local tw
				for _, w in ipairs(vim.api.nvim_list_wins()) do
					if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "NvimTree" then
						tw = w
					end
				end
				if tw then
					vim.api.nvim_set_current_win(tw)
					require("trouble").open({
						mode = "symbols",
						focus = false,
						win = { type = "split", relative = "win", position = "bottom", size = 0.4 },
					})
				end
			end)
		end, 100)
	end

	-- content windows: first shows index, second shows todo
	vim.defer_fn(function()
		safe(function()
			local content = {}
			for _, w in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_is_valid(w) and not panel_win(w) then
					content[#content + 1] = w
				end
			end

			if #content == 0 then
				-- no content window at all: create one next to the tree
				if tree_win and vim.api.nvim_win_is_valid(tree_win) then
					vim.api.nvim_set_current_win(tree_win)
				end
				vim.cmd("rightbelow vsplit")
				content[1] = vim.api.nvim_get_current_win()
			end

			vim.api.nvim_set_current_win(content[1])
			vim.cmd("edit " .. vim.fn.fnameescape(index))

			if #content >= 2 then
				vim.api.nvim_set_current_win(content[2])
				vim.cmd("edit " .. vim.fn.fnameescape(todo))
			elseif vim.fn.filereadable(todo) == 1 then
				vim.cmd("split")
				vim.cmd("edit " .. vim.fn.fnameescape(todo))
			end

			vim.api.nvim_set_current_win(content[1])
		end)
	end, 100)
end

-- fzf picker over Projects/* folders
M.projects = function()
	local projects_dir = vault() .. "/Projects"
	local names = {}
	for name, typ in vim.fs.dir(projects_dir) do
		if typ == "directory" and name:sub(1, 1) ~= "." then
			names[#names + 1] = name
		end
	end
	table.sort(names)

	require("fzf-lua").fzf_exec(names, {
		prompt = "Projects❯ ",
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					M.open_project(projects_dir .. "/" .. selected[1])
				end
			end,
		},
	})
end

-- All unchecked checkboxes across the vault
M.tasks = function()
	require("fzf-lua").live_grep({
		search = "\\[ \\]",
		search_paths = { vault() },
		prompt = "Open tasks❯ ",
	})
end

return M
