local M = {}

function M.git_add()
	vim.fn.jobstart({ "git", "add", "." }, {
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.notify("git add: " .. line, vim.log.levels.INFO)
					end
				end
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git add failed with code: " .. exit_code, vim.log.levels.ERROR)
			end
		end,
	})
end

function M.git_add_current_file()
	local current_file = vim.fn.expand("%")
	vim.fn.jobstart({ "git", "add", current_file }, {
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.notify("git add: " .. line, vim.log.levels.INFO)
					end
				end
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git add failed with code: " .. exit_code, vim.log.levels.ERROR)
			end
		end,
	})
end

function M.git_commit()
	local commit_buf = vim.api.nvim_create_buf(false, true)
	vim.bo[commit_buf].buftype = "prompt"
	vim.bo[commit_buf].bufhidden = "wipe"
	vim.bo[commit_buf].filetype = "markdown"

	vim.api.nvim_open_win(commit_buf, true, {
		relative = "editor",
		width = 80,
		height = 10,
		row = (vim.o.lines - 10) / 2,
		col = (vim.o.columns - 80) / 2,
		style = "minimal",
		border = "single",
	})
	vim.fn.prompt_setprompt(commit_buf, "Commit message: ")
	vim.cmd("startinsert")

	local function on_commit_message_entered()
		local commit_message = vim.api.nvim_buf_get_lines(commit_buf, 0, -1, false)
		local commit_message_str = table.concat(commit_message, "\n"):gsub("^Commit message: ", "")
		vim.api.nvim_win_close(0, true)

		vim.fn.jobstart({ "git", "commit", "-m", commit_message_str }, {
			on_stdout = function(_, data)
				if data then
					for _, line in ipairs(data) do
						if line ~= "" then
							vim.notify("git commit: " .. line, vim.log.levels.INFO)
						end
					end
				end
			end,
			on_exit = function(_, exit_code)
				if exit_code ~= 0 then
					vim.notify("git commit failed with code: " .. exit_code, vim.log.levels.ERROR)
				end
			end,
		})
	end

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = commit_buf,
		callback = on_commit_message_entered,
	})
end

function M.git_push()
	vim.fn.jobstart({ "git", "push" }, {
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.notify("git push: " .. line, vim.log.levels.INFO)
					end
				end
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git push failed with code: " .. exit_code, vim.log.levels.ERROR)
			end
		end,
	})
end

function M.git_pull()
	vim.fn.jobstart({ "git", "pull" }, {
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.notify("git pull: " .. line, vim.log.levels.INFO)
					end
				end
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("git pull failed with code: " .. exit_code, vim.log.levels.ERROR)
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
