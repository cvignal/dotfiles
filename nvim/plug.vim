if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
	Plug 'scrooloose/nerdcommenter'
    Plug 'epilande/vim-es2015-snippets'
    Plug 'epilande/vim-react-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'css', 'json', 'graphql'] }
    Plug 'mxw/vim-jsx'
	Plug 'junegunn/goyo.vim'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'jreybert/vimagit'
    Plug 'pangloss/vim-javascript'
    Plug 'crusoexia/vim-javascript-lib'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'jiangmiao/auto-pairs'
	Plug 'LukeSmithxyz/vimling'
	Plug 'vimwiki/vimwiki'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-airline'
	Plug 'tpope/vim-commentary'
	Plug 'vifm/vifm.vim'
	Plug 'kovetskiy/sxhkd-vim'
	Plug 'wikitopian/hardmode'
	Plug 'Shougo/deoplete.nvim'
	Plug 'Shougo/deoplete-clangx'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'godlygeek/tabular'
	Plug 'neomake/neomake'
	Plug 'elixir-editors/vim-elixir'
	Plug 'pangloss/vim-javascript'
""" Themes
	Plug 'flazz/vim-colorschemes'
	Plug 'ayu-theme/ayu-vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'tomasr/molokai'
call plug#end()

filetype plugin indent on
