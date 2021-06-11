let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
""" Basic plugs
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'prettier/vim-prettier', {'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']}
  Plug 'scrooloose/nerdcommenter'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/goyo.vim'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'jreybert/vimagit'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jiangmiao/auto-pairs'
  Plug 'LukeSmithxyz/vimling'
  Plug 'vimwiki/vimwiki'
  Plug 'tools-life/taskwiki'
  Plug 'powerman/vim-plugin-AnsiEsc'
  Plug 'vim-airline/vim-airline'
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'wikitopian/hardmode'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'godlygeek/tabular'
  Plug 'neomake/neomake'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'thinca/vim-ref'
  Plug 'tpope/vim-fugitive'
  Plug 'chrisbra/unicode.vim'
  """ Languages specific plugs
  Plug 'elixir-editors/vim-elixir'
  Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  Plug 'pangloss/vim-javascript'
  Plug 'crusoexia/vim-javascript-lib'
  Plug 'epilande/vim-es2015-snippets'
  Plug 'epilande/vim-react-snippets'
  Plug 'mxw/vim-jsx'
  Plug 'slashmili/alchemist.vim'
  Plug 'Shougo/deoplete-clangx'
  Plug 'wokalski/autocomplete-flow'
  Plug 'Shougo/neco-syntax'
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'cespare/vim-toml'
  Plug 'lervag/vimtex'
  Plug 'lumiliet/vim-twig'
  """ Themes
  Plug 'ayu-theme/ayu-vim'
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'tomasr/molokai'
call plug#end()

filetype plugin indent on
