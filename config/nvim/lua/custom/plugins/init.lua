return {
  { "williamboman/nvim-lsp-installer" },
  { "vimwiki/vimwiki" },
  { "elixir-editors/vim-elixir" },
  { "kylef/apiblueprint.vim" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gdiff",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Gw",
    }
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
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
  }
}
