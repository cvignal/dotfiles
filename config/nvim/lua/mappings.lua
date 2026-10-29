require("nvchad.mappings")

local map = vim.keymap.set

-- fzf-lua (replaces NvChad's telescope bindings)
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "find files" })
map("n", "<leader>fa", "<cmd>FzfLua files no_ignore=true hidden=true<CR>", { desc = "find all files" })
map("n", "<leader>fw", "<cmd>FzfLua grep<CR>", { desc = "live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua lines<CR>", { desc = "find in current buffer" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "git status" })
map("n", "<leader>th", "<cmd>FzfLua colorschemes<CR>", { desc = "themes" })
-- fzf-lua has no term picker; drop NvChad's <leader>pt (Telescope terms)
vim.keymap.del("n", "<leader>pt")

-- TODO comments
map("n", "]t", function()
	require("todo-comments").jump_next()
end)
map("n", "[t", function()
	require("todo-comments").jump_prev()
end)

-- Diagnostics
map("n", "gn", function()
	vim.diagnostic.jump({
		count = 1,
		on_jump = function()
			vim.diagnostic.open_float({ focusable = false })
		end,
	})
end)
map("n", "gp", function()
	vim.diagnostic.jump({
		count = -1,
		on_jump = function()
			vim.diagnostic.open_float({ focusable = false })
		end,
	})
end)

-- DadBod
map("n", "<leader>Du", "<cmd>DBUIToggle<Cr>", { desc = "Database: Toggle UI" })
map("n", "<leader>Df", "<cmd>DBUIFindBuffer<Cr>", { desc = "Database: Find buffer" })
map("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<Cr>", { desc = "Database: Rename buffer" })
map("n", "<leader>Dr", "<cmd>DBUILastQueryInfo<Cr>", { desc = "Database: Last query info" })

-- gitsigns
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<Cr>", { desc = "Toggle current line git blame" })

-- Side panels (nvim-tree + trouble symbols)
map("n", "<leader>a", function()
	require("configs.sidepanel").toggle()
end, { desc = "Toggle side panels" })

-- -- DAP
-- map("n", "<leader>dk", "<cmd>lua require 'dap'.continue()<cr>", { desc = "DAP continue" })
-- map("n", "<leader>dj", "<cmd>lua require 'dap'.step_over()<cr>", { desc = "DAP step over" })
-- map("n", "<leader>dh", "<cmd>lua require 'dap'.step_into()<cr>", { desc = "DAP step into" })
-- map("n", "<leader>dl", "<cmd>lua require 'dap'.step_out()<cr>", { desc = "DAP step out" })
-- map("n", "<leader>b", "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", { desc = "DAP toggle breakpoint" })
-- map("n", "<leader>dp", "<cmd>lua require 'dap'.run_last()<cr>", { desc = "DAP run last" })

-- Copy GitHub link for current line/selection
local function get_github_link(line1, line2)
	local function run_in_dir(dir, command)
		local output = vim.fn.systemlist("cd " .. vim.fn.shellescape(dir) .. " && " .. command)
		return output, vim.v.shell_error
	end

	local function trim(value)
		return (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
	end

	local function github_web_url(remote_url)
		remote_url = trim(remote_url):gsub("%.git$", "")

		local ssh_host, ssh_path = remote_url:match("^git@([^:]+):(.+)$")
		if not ssh_host then
			ssh_host, ssh_path = remote_url:match("^ssh://git@([^/]+)/(.+)$")
		end

		if ssh_host and ssh_path then
			return "https://" .. ssh_host .. "/" .. ssh_path
		end

		return remote_url
	end

	local function jj_remote_url(file_dir)
		local remotes, status = run_in_dir(file_dir, "jj git remote list --ignore-working-copy 2>/dev/null")
		if status ~= 0 then
			return nil
		end

		local first_url, first_name
		for _, remote in ipairs(remotes) do
			local name, url = remote:match("^(%S+)%s+(%S+)$")
			if name == "origin" then
				return url, name
			end
			first_url = first_url or url
			first_name = first_name or name
		end
		return first_url, first_name
	end

	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file in current buffer", vim.log.levels.ERROR)
		return
	end

	local file_dir = vim.fn.fnamemodify(file, ":h")
	local root, remote_url, commit

	local jj_root, jj_status = run_in_dir(file_dir, "jj root --ignore-working-copy 2>/dev/null")
	if jj_status == 0 then
		root = trim(jj_root[1])
		local remote_name
		remote_url, remote_name = jj_remote_url(file_dir)

		-- Prefer a commit that is known by the same remote we link to; local jj
		-- commits often do not exist on GitHub yet, which makes copied links 404.
		local remote_bookmarks = remote_name and ("remote_bookmarks(remote=" .. remote_name .. ")")
			or "remote_bookmarks()"
		local jj_commit, commit_status = run_in_dir(
			file_dir,
			[[jj log --ignore-working-copy -r 'heads(::@ & ]]
				.. remote_bookmarks
				.. [[)' --no-graph -T 'commit_id ++ "\n"' 2>/dev/null]]
		)
		if commit_status ~= 0 or trim(jj_commit[1]) == "" then
			-- Fall back to git HEAD, which is usually the checked-out remote-backed commit
			-- in colocated jj repositories.
			jj_commit = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "HEAD" })
			commit_status = vim.v.shell_error
		end
		if commit_status ~= 0 or trim(jj_commit[1]) == "" then
			-- Last resort: use jj's parent of the working-copy commit. This may be local
			-- and therefore not readable on GitHub until pushed.
			jj_commit, commit_status = run_in_dir(
				file_dir,
				[[jj log --ignore-working-copy -r @- --no-graph -T 'commit_id ++ "\n"' 2>/dev/null]]
			)
		end
		if commit_status == 0 then
			commit = trim(jj_commit[1])
		end
	else
		local git_root = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })
		if vim.v.shell_error ~= 0 then
			vim.notify("Not in a git or jj repository", vim.log.levels.ERROR)
			return
		end

		root = trim(git_root[1])
		local git_remote = vim.fn.systemlist({ "git", "-C", file_dir, "remote", "get-url", "origin" })
		if vim.v.shell_error == 0 then
			remote_url = git_remote[1]
		end
		local git_commit = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "HEAD" })
		if vim.v.shell_error == 0 then
			commit = git_commit[1]
		end
	end

	if not remote_url or remote_url == "" then
		vim.notify("No git remote found", vim.log.levels.ERROR)
		return
	end
	if not commit or commit == "" then
		vim.notify("Could not resolve repository revision", vim.log.levels.ERROR)
		return
	end

	local relative_path = file:sub(#root + 2)
	local url = github_web_url(remote_url) .. "/blob/" .. trim(commit) .. "/" .. relative_path
	if line1 == line2 then
		url = url .. "#L" .. line1
	else
		url = url .. "#L" .. line1 .. "-L" .. line2
	end

	vim.fn.setreg("+", url)
	vim.notify("Copied: " .. url)
end

map("n", "<leader>gl", function()
	get_github_link(vim.fn.line("."), vim.fn.line("."))
end, { desc = "Copy GitHub link for current line" })

map("v", "<leader>gl", function()
	local line1 = vim.fn.line("v")
	local line2 = vim.fn.line(".")
	if line1 > line2 then
		line1, line2 = line2, line1
	end
	get_github_link(line1, line2)
end, { desc = "Copy GitHub link for selection" })
