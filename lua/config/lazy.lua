local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugs" },
  { import = "plugs.ide" },
  { import = "plugs.lang" },
  { import = "plugs.looks" },
  { import = "plugs.looks" },
	{ import = "plugs.tools" },

  git = {
    timeout = 360, -- This increases the timeout to 6 minutes somewhere
  },
})
