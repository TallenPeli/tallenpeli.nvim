local settings = require("tallenpeli.settings").load()

if settings.ai.supermaven == true then
	return {
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	}
else
	return {}
end
