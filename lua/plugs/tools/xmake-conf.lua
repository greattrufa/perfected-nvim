return {
	{
		"Mythos-404/xmake.nvim",
		version = "^3",
		lazy = true,
		event = "BufReadPost xmake.lua",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"rcarriga/nvim-notify",
		},
		config = true,
		-- Configuration when saving `xmake.lua`
		on_save = {
			reload_project_info = true,
			lsp_compile_commands = {
				enable = true,
				output_dir = "build",
			},
		},

		-- Enable development mode
		dev_debug = true,

		compile_command = {
			lsp = "clangd",
			dir = ".vscode",
		},

		menu = {
			size = { width = 25, height = 20 },
			bottom_text_format = "%s(%s)",
			border_style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},

		debug = true, -- Temporarily enable for troubleshooting
	},
}
