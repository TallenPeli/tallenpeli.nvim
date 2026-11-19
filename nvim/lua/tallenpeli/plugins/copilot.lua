local settings = require("tallenpeli.settings").load()

if settings.ai.copilot == true then
	return {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true, -- Automatically shows ghost text as you type
				keymap = {
					accept = "<Tab>", -- Press Tab to accept the inline suggestion
					next = "<M-]>", -- Alt + ] for next suggestion
					prev = "<M-[>", -- Alt + [ for previous suggestion
					dismiss = "<C-]>", -- Ctrl + ] to dismiss
				},
			},
			panel = { enabled = false }, -- Disable the side panel if you only want inline completions
		},
	}
else
	return {}
end
