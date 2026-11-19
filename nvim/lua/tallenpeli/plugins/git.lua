local M = {}

function M.git_add()
	vim.fn.jobstart({ "git", "add", "." }, {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git add failed with code: " .. exit_code, vim.log.levels.ERROR)
			else
				vim.notify("Success: git add .", vim.log.levels.INFO)
			end
		end,
	})
end

function M.git_add_current_file()
	local current_file = vim.fn.expand("%")
	vim.fn.jobstart({ "git", "add", current_file }, {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git add failed with code: " .. exit_code, vim.log.levels.ERROR)
			else
				vim.notify("Success: git add " .. current_file, vim.log.levels.INFO)
			end
		end,
	})
end

function M.git_commit()
	local prev_tab = vim.api.nvim_get_current_tabpage()

	-- Open a brand-new full-screen tabpage (leaves your current tab's layout completely untouched)
	vim.cmd("tabnew")
	local commit_win = vim.api.nvim_get_current_win()
	local commit_buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_name(commit_buf, "gitcommit://" .. commit_buf)
	vim.bo[commit_buf].buftype = "acwrite"
	vim.bo[commit_buf].bufhidden = "wipe"
	vim.bo[commit_buf].swapfile = false
	vim.bo[commit_buf].filetype = "gitcommit"
	vim.wo[commit_win].winbar = "  Git Commit (:w to commit, :q! to cancel) "

	vim.cmd("startinsert")

	local committed = false

	local function close_commit_tab()
		-- Switch back to the original tab and close the commit tab
		if vim.api.nvim_tabpage_is_valid(prev_tab) then
			vim.api.nvim_set_current_tabpage(prev_tab)
		end
		if vim.api.nvim_buf_is_valid(commit_buf) then
			vim.api.nvim_buf_delete(commit_buf, { force = true })
		end
	end

	-- Allow ZZ to save & close cleanly
	vim.keymap.set("n", "ZZ", "<cmd>w<CR>", { buffer = commit_buf, silent = true })

	vim.api.nvim_create_autocmd("BufWriteCmd", {
		buffer = commit_buf,
		once = true,
		callback = function()
			committed = true
			vim.bo[commit_buf].modified = false

			local lines = vim.api.nvim_buf_get_lines(commit_buf, 0, -1, false)
			local msg_lines = vim.tbl_filter(function(line)
				return not line:match("^#")
			end, lines)
			local commit_message_str = vim.trim(table.concat(msg_lines, "\n"))

			close_commit_tab()

			if commit_message_str == "" then
				vim.notify("Commit message must not be empty", vim.log.levels.WARN)
				return
			end

			vim.fn.jobstart({ "git", "commit", "-m", commit_message_str }, {
				on_stdout = function(_, data)
					local out = table.concat(data, "\n"):gsub("%s+$", "")
					if out ~= "" then
						vim.notify("git commit:\n" .. out, vim.log.levels.INFO)
					end
				end,
				on_stderr = function(_, data)
					local err = table.concat(data, "\n"):gsub("%s+$", "")
					if err ~= "" then
						vim.notify("git commit:\n" .. err, vim.log.levels.ERROR)
					end
				end,
				on_exit = function(_, exit_code)
					if exit_code ~= 0 then
						vim.notify("git commit failed with code: " .. exit_code, vim.log.levels.ERROR)
					end
				end,
			})
		end,
	})

	-- If you quit (:q / :q!) without saving, close the tab and return to your layout
	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = commit_buf,
		once = true,
		callback = function()
			if not committed and vim.api.nvim_tabpage_is_valid(prev_tab) then
				vim.schedule(function()
					if vim.api.nvim_tabpage_is_valid(prev_tab) then
						vim.api.nvim_set_current_tabpage(prev_tab)
					end
				end)
			end
		end,
	})
end

function M.git_push()
	local output = {}

	local function collect(_, data)
		if data then
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(output, line)
				end
			end
		end
	end

	vim.fn.jobstart({ "git", "push" }, {
		on_stdout = collect,
		on_stderr = collect,
		on_exit = function(_, exit_code)
			local msg = table.concat(output, "\n")
			if exit_code ~= 0 then
				vim.notify("git push failed:\n" .. msg, vim.log.levels.ERROR)
			else
				vim.notify(msg ~= "" and ("git push:\n" .. msg) or "git push: Done", vim.log.levels.INFO)
			end
		end,
	})
end

function M.git_pull()
	local output = {}

	local function collect(_, data)
		if data then
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(output, line)
				end
			end
		end
	end

	vim.fn.jobstart({ "git", "pull" }, {
		on_stdout = collect,
		on_stderr = collect,
		on_exit = function(_, exit_code)
			local msg = table.concat(output, "\n")
			if exit_code ~= 0 then
				vim.notify("git pull failed:\n" .. msg, vim.log.levels.ERROR)
			else
				vim.notify("git pull:\n" .. msg)
			end
		end,
	})
end

return {
	dir = vim.fn.stdpath("config"),
	name = "tallenpeli-git",

	git_add = M.git_add,
	git_add_current_file = M.git_add_current_file,
	git_commit = M.git_commit,
	git_push = M.git_push,
	git_pull = M.git_pull,
}
