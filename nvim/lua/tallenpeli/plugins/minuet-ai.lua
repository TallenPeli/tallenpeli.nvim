return {
	"milanglacier/minuet-ai.nvim",
	config = function()
		require("minuet").setup({
			provider = "openai_fim_compatible",
			n_completions = 1,
			context_window = 512,
			provider_options = {
				openai_fim_compatible = {
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://localhost:11434/v1/completions",
					-- Change this to whatever model you want, this one is just fast on low-end hardware
					model = "qwen2.5-coder:0.5b",
					optional = {
						max_tokens = 128,
						top_p = 0.9,
					},
				},
			},
			virtualtext = {
				auto_trigger_ft = { "*" },
				keymap = {
					accept = "<C-a>",
					accept_line = "<Tab>",
					next = "<A-]>",
					prev = "<A-[>",
					dismiss = "<A-e>",
				},
			},
		})
	end,
}
