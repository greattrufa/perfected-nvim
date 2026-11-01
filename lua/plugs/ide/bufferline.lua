return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
    require("bufferline").setup{
      require('transparent').clear_prefix('BufferLine'),
      require("transparent").clear_prefix("TabLine"),

      -- highlights = {
      --   fill =       { bg = "NONE", ctermbg = "NONE" },
      --   background = { bg = "NONE", ctermbg = "NONE" },
      -- },
      options = {
        truncate_names = true,
        style_preset = { "no_bold", "minimal" },
        separator_style = "thick",
        indicator = {
          style = "icon", -- 'icon', 'underline', or 'none'
        },

        offsets = {
          {
            filetype = "NeoTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            padding = 1,
            separator = true,
          }
        },
      },
    }
  end
}

