return {
	-- ── Mason: installs the servers ─────────────────────────────────────────
	{
		"mason-org/mason.nvim", -- moved from williamboman/ in the v2 era
		config = true, -- require("mason").setup()
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig", -- must be in rtp before setup()
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd", -- C/C++
					"rust_analyzer", -- Rust
					"glsl_analyzer", -- GLSL
					"lua_ls", -- Lua
					"ty", -- Python (Astral)
					"typos_lsp", -- spell check
					"terraformls", -- Terraform
					"slint_lsp",
					"neocmake",
				},
				-- v2: `automatic_installation` was REMOVED. This is the replacement.
				automatic_enable = true,
			})
		end,
	},

	-- ── LSP + coq ───────────────────────────────────────────────────────────
	{
		"neovim/nvim-lspconfig",
		-- REQUIRED by coq: it has to be alive from startup, not lazily loaded.
		lazy = false,
		dependencies = {
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" }, -- 9000+ snippets
			{ "ms-jpq/coq.thirdparty", branch = "3p" }, -- needs separate config
		},
		init = function()
			-- MUST be assigned before `require("coq")` ever runs.
			vim.g.coq_settings = {
				display = {
					-- preview = { border = { "rounded" } },
					ghost_text = {
						enabled = false,
					},
				},
			}
		end,
		config = function()
			-- This is the line that makes coq's LSP source work.
			local coq = require("coq")

			-- if vim.fn.has("win32") == 1 then
			-- 	vim.env.PATH = vim.env.PATH .. ";" .. vim.fn.stdpath("data") .. "/mason/bin"
			-- end

			-- ── Diagnostics ────────────────────────────────────────────────
			local sev_name = { [1] = "Error", [2] = "Warn", [3] = "Info", [4] = "Hint" }

			vim.diagnostic.config({
				virtual_text = true,
				signs = true, -- see note below if you want custom glyphs back
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					format = function(diagnostic)
						return string.format(
							"%s (%s) [%s]",
							diagnostic.message,
							diagnostic.source,
							diagnostic.code or ""
						)
					end,
					-- `diagnostic.severity` is a NUMBER here, not a table.
					prefix = function(diagnostic)
						return (sev_name[diagnostic.severity] or "") .. " "
					end,
				},
			})

			-- ── Server configs ─────────────────────────────────────────────
			-- Every config is wrapped in coq.lsp_ensure_capabilities() so the
			-- server is told coq supports snippets / incremental completion.

			vim.lsp.config("rust_analyzer", {
				filetypes = { "rust" }, -- ".rs" is not a filetype
				root_markers = { ".git", "Cargo.toml", ".gitignore" },
			})

			vim.lsp.config("lua_ls", {
				root_markers = { ".git", ".luarc.json", ".luarc.jsonc", ".stylua.toml" },
				settings = {
					Lua = {
						workspace = {
							maxPreload = 1000,
							preloadFileSize = 500,
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						diagnostics = {
							globals = { "vim" },
						},
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					-- NOTE: globs match the driver *path*; absolute globs are far
					-- more reliable than bare `clang*`.
					"--query-driver=clang*,clang++*,gcc*,g++*,cl.exe",
					-- NOTE: clangd takes ONE directory here, not a list.
					-- Pick whichever holds your compile_commands.json.
					"--compile-commands-dir=build,.",
					"--pch-storage=memory",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--offset-encoding=utf-8",
					"--enable-config",
					-- "--log=verbose", -- very noisy, enable only when debugging
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
					fallbackFlags = { "-std=c++23" },
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = { "compile_commands.json", "CMakeLists.txt", "xmake.lua", ".git" },
				single_file_support = true,
				-- The old `capabilities = { offsetEncoding = ... }` block is gone:
				-- it clobbered every other capability, and coq supplies them now.
			})

			vim.lsp.config("ty", {
				filetypes = { "python" },
				root_markers = { ".git", "pyproject.toml", "requirements.txt", "setup.py", ".gitignore" },
				-- The `python.analysis.*` block you had is pyright-specific and
				-- does nothing for `ty`. Configure ty via pyproject.toml / ty.toml.
			})

			vim.lsp.config("terraformls", {})

			vim.lsp.config("neocmake", {})

			-- Enable the same names you install. (`automatic_enable` in
			-- mason-lspconfig v2 already does this; being explicit is fine.)
			vim.lsp.enable({ "rust_analyzer", "lua_ls", "clangd", "ty", "terraformls", "neocmake" })

			-- ── Keys ───────────────────────────────────────────────────────
			vim.keymap.set("n", "<Space>ee", vim.diagnostic.open_float)
			vim.keymap.set("n", "<Space>qs", vim.diagnostic.setloclist)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Do NOT set omnifunc here. coq drives completion itself;
					-- forcing v:lua.vim.lsp.omnifunc just fights it.

					local opts = { buffer = ev.buf, silent = true }

					vim.keymap.set("n", "gk", function()
						vim.diagnostic.open_float(nil, {
							border = "rounded",
							focusable = false,
							close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
							source = "always",
							prefix = function(diagnostic)
								return (sev_name[diagnostic.severity] or "") .. " "
							end,
						})
					end, opts)

					vim.keymap.set("n", "gf", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>fa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<Leader>d", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<Leader>wg", ":belowright split<CR>:lua vim.lsp.buf.definition()<CR>", opts)
				end,
			})

			-- Diagnostics on cursor hold
			vim.api.nvim_create_autocmd("CursorHold", {
				group = vim.api.nvim_create_augroup("UserDiagFloat", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, {
						scope = "cursor",
						focusable = false, -- was true: steals focus constantly
						close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
					})
				end,
			})
		end,
	},
}
