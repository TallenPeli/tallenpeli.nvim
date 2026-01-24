return {
	"tallenpeli/autoupdate",
	virtual = true,
	config = function()
		local update_script = vim.fn.expand("~/.config/nvim/update.sh")

		local function run_update(is_startup)
			if vim.fn.filereadable(update_script) == 0 then
				return
			end

			vim.fn.jobstart({ update_script }, {
				on_stdout = function(_, data)
					if data then
						for _, line in ipairs(data) do
							if line ~= "" then
								vim.api.nvim_echo({ { "tallenpeli.nvim: " .. line, "None" } }, false, {})
							end
						end
					end
				end,
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						print("tallenpeli.nvim: Up to date")
					else
						print("tallenpeli: Update failed with code: " .. exit_code)
					end
				end,
			})
		end

		vim.api.nvim_create_user_command("ConfigUpdate", run_update, {})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				run_update(true)
			end,
		})
	end,
}
