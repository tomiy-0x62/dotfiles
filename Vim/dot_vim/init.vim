language C " 起動時の画面を英語に
set nocompatible 
syntax enable
set encoding=utf-8
set fileencoding=utf-8
set number
set guifont=Ricty_Bold:h24
set cursorline
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
filetype plugin indent on
set confirm
set cursorline
set laststatus=2
set statusline=%F%m%h%w%r\ %<\ %=\ ln\ %l/%L,Col\ %v\ %{&fenc!=''?&fenc:&enc}\ %{&ff}\ %Y

" set background=dark
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set list
set listchars=tab:»-,eol:↲
set hlsearch
set incsearch
" filetypeによって設定を変える
filetype plugin indent on
set undodir=$HOME/.vim/undodir


" カラースキームの設定
" 1. ~/.vimを作成(ない場合)
" 2. ~/.vim で git clone
"   molokai: https://github.com/tomasr/molokai
"   hybrid: https://github.com/w0ng/vim-hybrid
"   iceberg: https://github.com/cocopon/iceberg.vim.git
" 3. ~/.vim/colors を作成
" 4. ~/.vim/hoge/colors/hoge.vim を ~/.vim/colors/ に移動
"   molokai:  mv ~/.vim/molokai/colors/molokai.vim ~/.vim/colors/
"   hybrid: mv ~/.vim/vim-hybrid/colors/hybrid.vim ~/.vim/colors/
"   iceberg: mv ~/.vim/iceberg.vim/colors/iceberg.vim ~/.vim/colors/
" colorscheme molokai
" colorscheme hybrid
colorscheme iceberg

set termguicolors

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 

" statusline color
highlight StatusLine guifg=#34559E guibg=#FFFFFF

" 矢印キーを無効化
"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('$HOME/.local/share/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" pulagin installation derectory
" set runtimepath+=/Users/tomiy/.local/share/dein/repos/github.com/Shougo/dein.vim

" download dein.vim from github if not installed
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" begin settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " Let dein manage dein
    call dein#add(s:dein_repo_dir)
    " plugins list (toml)
    let g:rc_dir    = expand('$HOME/.dein')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    " load toml
    call dein#load_toml(s:toml,      {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})
    " end setting
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set mouse=""

hi clear TabLine

hi TabLine guifg=#FFFFFF guibg=#34559E 
hi TabLineFill guifg=#34559E guibg=#FFFFFF
hi TabLineSel guifg=#34559E guibg=#FFFFFF

" Show current buffer name on tab
function! s:tabpage_label(n)
  " use t:title if exists
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif
  " Get list of buffers inside a current tab
  let bufnrs = tabpagebuflist(a:n)
  " Highlight a current tab
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " show '+' if there are modified buffers
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  " Get current buffer
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() is 1-indexed
  let fname = pathshorten(bufname(curbufnr))

  let label = fname . mod

  return '%' . a:n . 'T' . hi . ' [' . label . '] ' . '%T%#TabLineFill#'
endfunction

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' '  " delimiter
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let hostname = ChompedSystem('hostname')
  let info = 'vim@' . hostname  " show whatever you want
  return tabpages . '%=%#TabLine#' . info  " show tab lists on leftside, informations on rightside
endfunction

autocmd BufNew * tab ba

if $TMUX != ""
    augroup titlesettings
        autocmd!
        autocmd BufEnter * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
        autocmd VimLeave * call system("tmux set automatic-rename on")
        autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
        autocmd focusgained * sleep 10m
        autocmd focusgained * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
        autocmd FocusLost * call system("tmux set automatic-rename on")
    augroup END
endif

set showtabline=2
set guioptions-=e
set tabline=%!MakeTabLine()
