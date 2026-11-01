return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				require("transparent").clear_prefix("NeoTree"),

				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				close_if_last_window = true,
				filesystem = {
					filtered_items = {
						visible = true,
						show_hidden_count = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
				window = {
					position = "right",
					width = 35,
					mapping_options = { -- This sets global options for mappings
						noremap = true,
						nowait = true,
					},
					mappings = { -- Define your specific key mappings here
						-- ["<Space>p"] = "image_wezterm", -- " or another map
						-- ["o"] = { -- This should be inside 'mappings'
						-- 	-- "toggle_preview",
						-- 	"open_check_images",
						-- 	config = {
						-- 		use_float = true,
						-- 		use_image_nvim = true,
						-- 	},
						-- },
						["o"] = function(state)
							local node = state.tree:get_node()
							if vim.list_contains({ "jpg", "png", "jpeg", "pdf" }, node.ext) then
								local command = vim.fn.has("mac") == 1 and "open" or "xdg-open"
								vim.fn.jobstart(command .. " " .. node.path)
							else
								vim.cmd.edit(node.path)
							end
						end,
					},
				},
			})
		end,
	},
	{
		"adelarsq/image_preview.nvim",
		event = "VeryLazy",
		config = function()
			require("image_preview").setup()
		end,
	},
}
