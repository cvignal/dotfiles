syntax enable
colorscheme gruvbox
let g:airline_theme='bubblegum'
set laststatus=2
syntax enable
set noshowmode
set cursorline

hi Folded         ctermbg=NONE ctermfg=3
hi LineNr         ctermbg=NONE ctermfg=8
hi Normal         ctermbg=NONE
hi CursorLine     ctermbg=0    ctermfg=NONE
hi CursorLineNr   ctermbg=0    ctermfg=3
hi Pmenu          ctermbg=0
hi PmenuSel       ctermbg=7    ctermfg=0
hi PrimaryBlock   ctermbg=NONE ctermfg=8
hi ModeBlock      ctermbg=NONE ctermfg=3
hi SecondaryBlock ctermbg=NONE ctermfg=8
hi TeritaryBlock  ctermbg=NONE ctermfg=5
hi Blanks         ctermbg=NONE
hi statusline     ctermbg=NONE
hi SpellBad       ctermbg=1    ctermfg=0
hi SpellCap       ctermbg=1    ctermfg=0
hi ColorColumn    ctermbg=NONE ctermfg=1
hi PmenuThumb     ctermbg=NONE ctermfg=1
hi SignColumn     ctermbg=NONE
hi QuickFixLine   ctermbg=NONE ctermfg=1
hi StatusLineNC   ctermbg=NONE ctermfg=8

hi link SyntasticWarningSign ColorColumn
hi link SyntasticErrorSign PmenuThumb

let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N',
    \ 'v'  : 'V ',
    \ 'V'  : 'V ',
    \ '' : 'V ',
    \ 's'  : 'S ',
    \ 'S'  : 'S ',
    \ '' : 'S ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V ',
    \ 'c'  : 'C ',
    \ 'cv' : 'V EX ',
    \ 'ce' : 'E ',
    \ 'r'  : 'P ',
    \ 'rm' : 'M ',
    \ 'r?' : 'C ',
    \ '!'  : 'S ',
    \ 't'  : 'T '}

" set statusline=
" set statusline+=%#ModeBlock#
" set statusline+=\ %{g:currentmode[mode()]}
" set statusline+=%#TeritaryBlock#
" set statusline+=\ %f\
" set statusline+=%M\
" set statusline+=%#Blanks#
" set statusline+=%=
" set statusline+=%#PrimaryBlock#
" set statusline+=\ %Y\
" set statusline+=%#SecondaryBlock#
" set statusline+=\ %P\


let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹ ",
    \ "Staged"    : "✚ ",
    \ "Untracked" : "✭ ",
    \ "Renamed"   : "➜ ",
    \ "Unmerged"  : "═ ",
    \ "Deleted"   : "✖ ",
    \ "Dirty"     : "✗ ",
    \ "Clean"     : "✔︎ ",
    \ 'Ignored'   : '☒ ',
    \ "Unknown"   : "? "
    \ }

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

let NERDTreeShowHidden=0
 function! StartUp()
  if 0 == argc()
    Startify
    NERDTree /var/www
  end
endfunction
autocmd VimEnter * call StartUp()

function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:UltiSnipsExpandTrigger="<C-l>"

let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0

filetype plugin on
set omnifunc=syntaxcomplete#Complete
map <C-S-l> :Prettier<CR>
