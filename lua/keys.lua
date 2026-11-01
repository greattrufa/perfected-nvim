local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Only map <Space> commands in Normal mode
map("n", " ", "<Nop>", opts) -- Override the default space key in order to be leader
map("n", "<Leader>q", ":qa<CR>", opts) -- Quit all
map("n", "<Leader>s", ":wa<CR>", opts) -- Save all buffers
map("n", "<Leader>l", ":Lazy<CR>", opts) -- Open Up Lazy

map("n", "<C-q>", ":q<CR>", opts) -- Quit
map("n", "<C-a>", "ggVG", opts) -- Select All
map("n", "<C-s>", ":w<CR>", opts) -- Save buffer
map("n", "<C-z>", ":u<CR>", opts) -- Undo

-- Swtch Between windows
map("n", "<C-h>", "<C-w>h<CR>", opts) -- switch window left
map("n", "<C-l>", "<C-w>l<CR>", opts) -- switch window right
map("n", "<C-j>", "<C-w>j<CR>", opts) -- switch window down
map("n", "<C-k>", "<C-w>k<CR>", opts) -- switch window up

-- Tetris and Minesweeper
map("n", "<Leader>tet", ":Tetris<CR>", opts) -- Tetris
map("n", "<Leader>mine", ":Nvimesweeper<CR>", opts) -- Minesweeper

-- Open specific buffer
map("n", "<Leader>m", ":Mason<CR>", opts) -- Toggle Mason package manager
map("n", "<Leader>t", ":Alpha<CR>", opts) -- Toggle Alpha neovim

-- Create and close tabs
map("n", "<C-n>", "<cmd>enew<CR>", opts) -- Create a new tab
map("n", "<C-w>", "<cmd>bdelete<CR>", opts) -- Close the tab you are at
map("n", "<M-q>", ":bdelete!<CR>", opts) -- Close the buffer without any saving

-- Splitting functionality
map("n", "<Leader>vv", ":vsplit<CR>", opts) -- Vertically slipt the windows
map("n", "<Leader>hh", ":split<CR>", opts) -- Horizontally slipt the windows

-- Tab only mode
-- map("n", "<Leader>to", ":tabonly<CR>", opts) -- I don't know this one

-- Session management
map("n", "<Leader>wr", "<cmd>AutoSession search<CR>", opts) -- Session search
map("n", "<Leader>ws", "<cmd>AutoSession save<CR>", opts) -- Save session
map("n", "<Leader>wa", "<cmd>AutoSession toggle<CR>", opts) -- Toggle autosave
map("n", "<Leader>wd", "<cmd>AutoSession deletePicker<CR>", opts) -- Pick a session to delete

map("n", "<C-c>", ":Neotree toggle<CR>", opts) -- Toggle the filesystem

-- Move right and left tab
map("n", "<M-Left>", "<cmd>BufferLineCyclePrev<CR>", opts) -- Previous Tab
map("n", "<M-Right>", "<cmd>BufferLineCycleNext<CR>", opts) -- Next Tab

-- move current tab to previous position
map("n", "<Leader>tmp", "<cmd>BufferLineMovePrev<CR>", opts) -- Moves the previous tab to the left
-- move current tab to next position
map("n", "<Leader>tmn", "<cmd>BufferLineMoveNext<CR>", opts) -- Moves the current tab to the right

-- Debbugins keymaps
map("n", "<C-e>", "<cmd>lua require('dap').continue()<cr>", opts) -- Continue
map("n", "<Leader>br", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts) -- Toggle Breakpoint
map("n", "<Leader>ds", "<cmd>lua require('dap').disconnect()<cr>", opts) -- Stop the debugging process
map("n", "<Leader>di", "<cmd>lua require('dap').step_into()<cr>", opts) -- Step Into
map("n", "<Leader>do", "<cmd>lua require('dap').step_over()<cr>", opts) -- Step Over
map("n", "<Leader>du", "<cmd>lua require('dap').step_out()<cr>", opts) -- Step Outline

-- Lsp stuff
map("n", "gf", vim.lsp.buf.hover, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
map("n", "<Leader>fa", vim.lsp.buf.add_workspace_folder, opts)
map("n", "<Leader>d", vim.lsp.buf.type_definition, opts)
map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<Leader>wg", ":belowright split<CR>:lua vim.lsp.buf.definition()<CR>", opts)
