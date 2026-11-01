## Perfected Neovim Configuration

This is an opinionated neovim configuration that focuses mostly on C/C++ and Python development with a few extra languages like rust and lua

## Requirements

For this configuration to work you should have:

- The latest version of [Neovim](https://neovim.io/) should work
- A version of npm in your system (the one in your package manager should work)

## How to install?

It should be easy.

Just use this command to clone the repository in the neovim configuration folder:

For Linux (And probably MacOS I am not sure)

```bash
git clone https://github.com/greattrufa/lazy-neovim-config.git ~/.config/nvim
```

For Windows:

```powershell
git clone https://github.com/greattrufa/lazy-neovim-config.git $HOME\AppData\Local\nvim
```

Everything should work now

## What does it include?

It uses the lazy package manager to hande the packages that are used in this configuration. The plugins used are seperated in a four different directories called `ide` `lang` `looks` and `tools`

`ide`: Has all the plugins that would make neovim an IDE

`lang`: Trouble, mason, dap and any other language lsp congifuration

`looks`: What makes this neovim configuration look visually pleasing

`tools`: Language specific tools or any other tools that this configuration might use

## Important plugins and Keybinds

Basic Keybinds:

Note `leader` key is the `space` key

- Ctrl + s: Save selected file
- Leader + s: Save all open tabs and buffers
- Ctrl + a: Select all
- Ctrl + z: Undo action

  <br>

- Ctrl + l: Focus on the Right window
- Ctrl + h: Focus on the left window
- Ctrl + k: Focus on the above window
- Ctrl + j: Focus on the window below

  <br>

- gf: Hover definition
- gd: Go to definition
- gr: See references
- Leader + fa: Add to workspace directory

#### IDE

- [NeoTree](https://github.com/nvim-neo-tree/neo-tree.nvim): File tree plugin

  Keybinds:
  - Ctrl + c: Open the file tree
  - m: Move a file to a specific directory
  - r: Rename a file or directory
  - o: Should open the an image or pdf

<br>

- [BufferLine](https://github.com/akinsho/bufferline.nvim#tabpages): The tab functionality

  Keybinds:
  - Ctrl + n: For a new empty tab
  - Ctrl + w: To close a tab
  - Leader + tmp: Move the active tab to the left
  - Leader + tmn: Move the active tab to the right
  - Alt + Left arrow: Switch to the left tab
  - Alt + Right arrow: Switch to the right tab

<br>

- [Telescope](https://github.com/nvim-telescope/telescope.nvim): File picker and file search

  Keybinds:
  - Ctrl + f: File search
  - Ctrl + b: Search through open tabs
  - Leader + /: Search through the file contents using grep

<br>

- [Session](https://github.com/natecraddock/sessions.nvim): Session management

  Keybinds:
  - Leader + w: Save the current session
  - Leader + r: List through the saved sessions
  - Leader + a: Toggle the session autosave on or off
  - Leader + d: Delete a selected session

<br>

#### LANG

Some of the plugins that are being used here are:

- [Mason](https://github.com/mason-org/mason.nvim) & [Mason LSP](https://github.com/mason-org/mason-lspconfig.nvim)
- [Neovim LSP](https://github.com/neovim/nvim-lspconfig)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Which do not include any keybindings

- [Coq autocomplete](https://github.com/ms-jpq/coq_nvim): Fast autocomplete configured in the lsp file

  Keybinds:
  - Enter: Confirm autoconfirm selection

<br>

- [Conform](https://github.com/stevearc/conform.nvim) & [Mason Conform](https://github.com/zapling/mason-conform.nvim): Conform for formatting and Mason Conform for installing the formatters

  > Note that it includes the clang-format, black, prettier, stylua which are formatters for C/C++, Python and Lua

  Keybinds:
  - Leader + fm: Format open file

<br>

- [Dap](https://github.com/mfussenegger/nvim-dap) & [Mason Dap](https://github.com/jay-babu/mason-nvim-dap.nvim): Mason Dap for the installation of debuggers and Dap the debbuger for neovim

  > Note that it has not been tested that much in this configuration. Some stuff might not work

  > Sesond Note: Debug presets are configured only for C++ with codelldb and cpptools which should provide compatibility with vscode debugging

  Keybinds:
  - Ctrl + e: Launch a dap instance
  - Leader + ds: Disconnect from a dap instance
  - Leader + br: Add a breakpoint
  - Leader + di: Step into
  - Leader + do: Step over
  - Leader + du: Step out

<br>

- [Trouble](https://github.com/folke/trouble.nvim): Diagnostics tool for warnings and errors

  Keybinds:

  Every key binding taken from the default example configuration that is provided in the trouble.nvim github repository just swapped space with the Leader key

  - Leader + xx: Toggle the trouble diagnostics tool

<br>

#### Looks

- [alpha](https://github.com/goolord/alpha-nvim): Startup menu when launching neovim

  Keybinds:
  - Leader + t: Toggle the alpha menu whenever you wish

<br>

Additional plugins that were used for visual enchancement include:

- [Noice](https://github.com/folke/noice.nvim): Neovim facelift that changes the UI, cmdline, popup menu and messages
- [Transparent](https://github.com/xiyaowong/transparent.nvim): Provices a transparent look for neovim
- [Statuscol](https://github.com/luukvbaal/statuscol.nvim): Used to add a double bar for regular line numbers and relative ones
- [Lualine](https://github.com/nvim-lualine/lualine.nvim): Status line used to provide better statistics
- [Colorizer](https://github.com/norcalli/nvim-colorizer.lua): Color highligher
- Themes:
  - [One Dark](https://github.com/nvim-lualine/lualine.nvim) (Enabled by default)
  - [Tokyo Night Gosh Storm](https://github.com/cesaralvarod/tokyogogh.nvim)
  - [Kanagawa Wave/Lotus](https://github.com/rebelot/kanagawa.nvim)

<br>

#### Tools

- [Xmake](Mythos-404/xmake.nvim): Set of tools that are used when working with projects that use the xmake build system

<br>

## Configuring

All of the plugins mentioned can be found in the `lua/plugs` directory + many more. Fell free to add or remove any you wish

You can change any keybinds you wish in `lua/keys.lua`

Autocommands are inside `lua/autocmd.lua`

Options can be changed in `lua/options.lua`

## Contribution

You are always welcome to file an issue or open a pull request
