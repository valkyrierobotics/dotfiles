""" Reload vimrc on save of vimrc
au BufLeave $MYVIMRC :source $MYVIMRC

""" Change VIm root if we're using neovim (and handle custom settings)
if has('nvim')
    let s:editor_root=expand('~/.nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    set termguicolors
else
    set t_Co=256
    let s:editor_root=expand('~/.vim')
endif

filetype off

call plug#begin(s:editor_root . '/plugged')

""" For Plugin documentation visit the respective GitHub pages
if has('nvim')
    Plug 'shougo/deoplete.nvim'
else
    Plug 'Valloric/YouCompleteMe'
endif
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'klen/python-mode'
Plug 'vim-scripts/utl.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'vimoutliner/vimoutliner'
Plug 'wincent/command-t'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'vim-scripts/lucius'
Plug 'vim-scripts/pyte'
Plug 'google/vim-ft-bzl'
Plug 'rust-lang/rust.vim'

call plug#end()

map <F2> :NERDTreeToggle<CR>

nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=750

let g:airline#extension#tabline#enabled = 1

let g:airline_powerline_fonts = 1

let g:Powerline_symbols = 'fancy'

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'
let g:Tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'zathura'

""" VIm Settings
set showtabline=1
set wildmenu
set laststatus=2
set ruler

""" Setup colorscheme
if has("gui_running")
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
  colorscheme pyte
else
  let g:lucius_style = 'light'
  set background=light
  silent! colorscheme lucius
endif

if has('nvim')
  highlight Normal guifg=White guibg=None
endif

set laststatus=2

let g:gitgutter_highlight_lines = 0 "prevent gitgutter from actually highlighting

syntax on
filetype plugin on
filetype indent on
filetype on

set autoread "doesn't work very well, but useful for external commands"

set so=7 "scroll to middle of file"

set wildignore=*.o,*~,*.pyc "ignore compiled files

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set lazyredraw

set magic

""" Blink matching parentheses
set showmatch
set mat=2

set autoindent
set copyindent
set shiftround

cmap w!! w !sudo tee % >/dev/null

set encoding=utf8
set termencoding=utf-8

set number
set list

""" Define characters to show when you show formatting
"   Stolen from https://github.com/tpope/vim-sensible
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    	let &listchars = "tab:\u21e5,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    endif
endif

set nolist
nmap <silent> <leader>s :set nolist!<CR>

set hidden
set history=1000
set undolevels=1000
set nobackup
set noswapfile
set nowb

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap ; :

set splitbelow
set splitright
set smarttab
set expandtab
set hlsearch
set incsearch
set smartcase
set ignorecase
set wrap

set tabstop=4
set shiftwidth=2

let mapleader = ","

set wildmenu
set wildmode=list:longest

set title

"""""""""""""""""""""""
""" Python-mode

"   Keys:
"       K               Show python docs
"       <Ctrl-Space>    Rope autocomplete
"       <Ctrl-c>g       Rope goto definition
"       <Ctrl-c>d       Rope show documentation
"       <Ctrl-c>f       Rope find occurences
"       <Leader>b       Set, unset breakpoint
"       [[              Jump on previous class
"       ]]              Jump on next class
"       [M              Jump on previous class or method
"       ]M              Jump on next class or method
"""""""""""""""""""""""
let g:pymode_rope = 1
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0

""""""""""""""""""""""""
"   Visual mode
""""""""""""""""""""""""
"
" Pressing * or # searches for the current selection

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map j gj
map k gk

map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

map <leader>bd :Bclose<cr>

map <leader>ba :1,1000 bd!<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

""" Return to last position when editing
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

set viminfo^=%

map 0 ^

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'm+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m`<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()

""""""""""""""""""""""""
"   vimgrep searching and cope displaying
""""""""""""""""""""""""
"   gv vimgreps to selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

"   open vimgrep and place cursor
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

"   vimgrep in current file
map <leader><space> :vimgrep // <C-R>%<C-A><left><left><left><left><left><left><left><left><left><left>

"   <leader>r search and replace selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Display results of vimgrep in cope using <leader>cc
"
" Use <leader>n for next result
"
" Use <leader>p for previous result

map <leader>co :bot cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""
"   Spell checking
"""""""""""""""""""""""""
"Pressing <leader>ss toggles spell checking
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

syntax spell toplevel

"""""""""""""""""""""""""
"   Helper functions
"""""""""""""""""""""""""
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/' . l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/' . l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! " . l:currentBufNum)
  endif
endfunction

noremap <silent> <leader>w :call ToggleWrap()<CR>

function WrapOn()
  setlocal wrap linebreak nolist
  set virtualedit=
  setlocal display+=lastline
  noremap <buffer> <silent> <Up> g<Up>
  noremap <buffer> <silent> <Down> g<Down>
  noremap <buffer> <silent> <Home> g<Home>
  noremap <buffer> <silent> <End> g<End>
  inoremap <buffer> <silent> <Up> <C-o>gk
  inoremap <buffer> <silent> <Down> <C-o>gj 
  inoremap <buffer> <silent> <Home> <C-o>g<Home>
  inoremap <buffer> <silent> <End> <C-o>g<End>
endfunction

function WrapOff()
  setlocal nowrap
  set virtualedit=all
  silent! nunmap <buffer> <Up>
  silent! nunmap <buffer> <Down>
  silent! nunmap <buffer> <Home>
  silent! nunmap <buffer> <End>
  silent! iunmap <buffer> <Up>
  silent! iunmap <buffer> <Down>
  silent! iunmap <buffer> <Home>
  silent! iunmap <buffer> <End>
endfunction

function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call WrapOff()
  else
    echo "Wrap ON"
    call WrapOn()
  endif
endfunction

call WrapOn()

function SetXeTex()
      let g:Tex_CompileRule_pdf = 'xelatex -aux-directory=F:/Vim/my_latex_doc/temp --synctex=-1 -src-specials -interaction=nonstopmode $*'
endfunction

map <Leader>lx :<C-U>call SetXeTex()<CR>
