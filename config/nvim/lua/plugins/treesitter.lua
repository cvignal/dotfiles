local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end


ts_config.setup {
    ensure_installed = {
        "javascript",
        "html",
        "css",
        "bash",
        "lua",
        "json",
        "python",
        "elixir",
        "erlang",
        "latex"
        -- "rust",
        -- "go"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
    playground = {
      enable = true,
      disable =  {},
      updatetime = 25,
      persist_queries = false
    },
    rainbow = {
      enable = true
    }
}
