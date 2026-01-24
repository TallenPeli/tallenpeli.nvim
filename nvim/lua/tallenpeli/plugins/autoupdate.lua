return {
	"tallenpeli/autoupdate",
	virtual = true,
	config = function()
		local update_script = vim.fn.expand("~/.config/nvim/update.sh")

		local function run_update_silent()
			if vim.fn.filereadable(update_script) == 0 then
				return
			end

			local on_data = function(_, data)
				if data then
					for _, line in ipairs(data) do
						if line ~= "" then
							print("Update: " .. line)
						end
					end
				end
			end

			vim.fn.jobstart({ update_script }, {
				on_stdout = on_data,
				on_stderr = on_data,
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						print("tallenpeli.nvim: Up to date")
					elseif exit_code == 1 then
						print("tallenpeli: Update completed")
					else
						print("tallenpeli: Update failed with code: " .. exit_code)
					end
				end,
			})
		end

		vim.api.nvim_create_user_command("ConfigUpdate", run_update_silent, {})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				run_update_silent()
			end,
		})
	end,
}
