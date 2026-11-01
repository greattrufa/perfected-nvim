return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<C-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<Leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search project" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		require("telescope").setup({
			defaults = {
				hidden = true,
				winblend = 0,
				theme = "classic",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				previewer = true,
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				sorting_strategy = "ascending",
				layout_strategy = "center",
				layout_config = {
					width = 0.8,
					height = 0.8,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"node_modules",
					"target",
					"src-tauri/target",
					".git",
					".venv",
					".vscode",
					"build",
					".cache",
					".xmake",
					"bin",
					"dist",
					"%.jpg$",
					"%.png$",
				},
			},
			-- pickers = {
			-- 	find_files = {
			-- 		find_command = { "fd", "--type=f", "--hidden", "--follow" },
			-- 	},
			-- },
		})
	end,
}
