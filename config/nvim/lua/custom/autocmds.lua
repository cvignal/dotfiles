-- Don't show any numbers inside terminals
local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  pattern = "term://*",
  command = "setlocal nonumber norelativenumber | setfiletype terminal"
})

-- Open a file from its last left off position
autocmd("BufReadPost", {
   callback = function()
      if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
         vim.cmd "normal! g'\""
         vim.cmd "normal zz"
      end
   end,
})

-- File extension specific tabbing
autocmd("Filetype", {
   pattern = "apiblueprint",
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
   end,
})

autocmd("BufEnter", {
  pattern = "term://*",
  command = "set laststatus=0",
})

autocmd("BufWritePost", {
  pattern = {"*Xresources", "*Xdefaults"},
  command = "!xrdb %"
})

autocmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" }, {
  pattern = "*",
  command = ":call TrimWhitespace()"
})

vim.api.nvim_exec([[
  function! TrimWhitespace()
    if &ft != 'markdown'
      %s/\s\+$//e
    endif
  endfunction
]], false)


autocmd("BufWritePost", {
  pattern = {"~/.config/bmdirs", "~/.config/bmfiles"},
  command = "!shortcuts"
})

autocmd("BufWritePost", {
  pattern = "*sxhkdrc",
  command = "!pkill -USR1 sxhkd"
})
