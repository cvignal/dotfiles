" vim:fdm=marker

source $HOME/.config/nvim/plug.vim

" Basic stuff
let mapleader=","
set wildmode=longest,list,full
set nocompatible
filetype off
set nocp
set nofoldenable
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nohlsearch
set go=a
set splitbelow splitright
set number relativenumber

" Python config
let g:python3_host_prog='/usr/bin/python3.8'
let g:python_host_prog='/usr/bin/python2.7'

" Themes
colorscheme gruvbox
let g:airline_theme='bubblegum'
hi Normal guibg=NONE ctermbg=NONE

" CTRL-P config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Remap for splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" NerdTree and plugin config
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Deoplete config
let g:deoplete#enable_at_startup=1

" Formatters for prettier
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css
nnoremap <F5> mzgggqG`z

" Autocmd for various sys files
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
