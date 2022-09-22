local configs = require "custom.plugins.configs"

return {
  ["NvChad/nvterm"] = {
    override_options = configs.nvterm
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = configs.treesitter,
  },
  ["williamboman/mason.nvim"] = {
    override_options = configs.mason,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    config = function ()
      require "custom.plugins.alpha"
    end
  },
  ["kylef/apiblueprint.vim"] = {
    ft = { "apiblueprint" }
  },
  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" }
  },
  ["tpope/vim-fugitive"] = {
    cmd = {
      "Git",
      "Gdiff",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Gw",
    }
  },
  ["nvim-telescope/telescope-media-files.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
          extensions = {
             media_files = {
                filetypes = { "png", "webp", "jpg", "jpeg" },
                find_cmd = "rg", -- find command (defaults to `fd`)
             },
          },
       }
       require("telescope").load_extension "media_files"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["nathom/filetype.nvim"] = false,
}
