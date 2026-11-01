return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"zapling/mason-conform.nvim",
	},
	config = function()
		require("mason-conform").setup({
			ensure_installed = {
				"prettier",
				"clang-format",
				"stylua",
				"taplo", -- was talpo
				"black",
			},
		})

		require("conform").setup({
			formatters_by_ft = {
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier", "injected" },
				lua = { "stylua" },
				python = { "isort", "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},

			format_on_save = {
				lsp_format = "fallback",
				async = false,
				quiet = false,
				timeout_ms = 3000,
			},

			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		})
	end,

	vim.keymap.set({ "n", "v" }, "<Leader>fm", function()
		require("conform").format({
			lsp_format = "fallback", -- was lsp_fallback = true
			async = false,
			timeout_ms = 500,
		})
	end, { desc = "Format file or range (in visual mode)" }),
}
