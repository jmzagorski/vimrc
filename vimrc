let $MYVIMRCPATH=fnamemodify($MYVIMRC, ':h')
set nocompatible

augroup vimrc
  autocmd!
augroup END

""""""""""""""""""""""""
" GENERAL STUFF
""""""""""""""""""""""""
" FROM VIM 80 Defaults --------------------------------------------------------
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
let s:vim_defaults = expand('$VIMRUNTIME/defaults.vim')
if filereadable(s:vim_defaults)
  execute 'source ' . s:vim_defaults
endif

if has("vms")
  set nobackup		        " do not keep a backup file, use versions instead
else
  set backup		          " keep a backup file (restore to previous version)
  "for backups go local directory then home
  set backupdir=~/.backup//
  if !isdirectory($HOME . '/.backup')
    call mkdir($HOME . "/.backup")
  endif

  set directory=~/.swp//
  if !isdirectory($HOME . '/.swp')
    call mkdir($HOME . '/.swp')
  endif

  if has('persistent_undo')
    set undofile	        " keep an undo file (undo changes after closing)
    set undodir=~/.undo//
    if !isdirectory($HOME . '/.undo')
      call mkdir($HOME . '/.undo')
    endif
  endif
endif
" -----------------------------------------------------------------------------
let mapleader = ','
let maplocalleader = ','
set lazyredraw                               " don't redraw while executing macros
set fileformats=unix,mac,dos                 " Automatic end-of-file format detection
set smartindent                              " be smart about it
set expandtab                                " expand tabs to spaces
set smarttab                                 " no tabs
set tabstop=2
"important: keep next 2 lines the same values for spaces
set softtabstop=2                            " backspace will have same behavior
set shiftwidth=2                             " when pressing the < and > key
set backspace=indent,eol,start               " Allow backspacing over everything in insert mode
set clipboard^=unnamed,unnamedplus           " sync with clipboard
set hidden                                   " allow buffer switching without saving
set autoread                                 " reload files changed outside vim
set showcmd
set showfulltag
set nomodeline
set noerrorbells
set novisualbell
set history=1000                             " number of command lines to remember default is 20
" SEARCHING -----------------------------------------------------------------
set ignorecase                               " ignore case on searching
set infercase
set smartcase                                " do not ignore case when capitalization are in search
set noswapfile
set incsearch
set hlsearch
" enable menu at bottom of window (e.g. colorscheme <Tab>)
set wildmenu
" ignore case on buffer switching
set wildignorecase
set wildmode=list:longest,full
" makes vimgrep and searches faster since these are normally not your code
set wildignore+=*/node_modules/*
set wildignore+=*/.git/*
set wildignore+=*/obj/*
set wildignore+=*/bin/*
set wildignore+=*/jspm_packages/*
set wildignore+=*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/.mimosa
" -----------------------------------------------------------------------------
set exrc
set secure
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set virtualedit=block
" on vert split, split below
set splitbelow
" on horizontal split, split right
set splitright
set linebreak

" Default todo list
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" make sure our buffer is always up to date
autocmd vimrc CursorHold * silent! checktime

set path=.,,**

set breakindent
set showbreak=\\\ \ 
set diffopt+=iwhite

if executable('rg')
  setglobal grepprg=rg\ -H\ --no-heading\ --vimgrep
endif

""""""""""""""""""""""""
" VARIOUS MAPPINGS
""""""""""""""""""""""""
inoremap jk <ESC>
inoremap kj <ESC>
" keep the reverse search character since it is the comma and that is my leader
noremap \ ,

" expansion of active dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" expansion of active dir with file extension. Useful for Aurelia switching
" from view to view model files
cnoremap <expr> %T getcmdtype() == ':' ? expand('%:r').'.' : '%R'

" needs to be set before listchars
set encoding=utf8
set listchars=tab:¶\ ,eol:¬,trail:☠

" remap buffer switching left/right/up/down
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Enable folding with the spacebar
nnoremap <space> za

"yank from cursors to end of line
nnoremap Y y$

"keep cursor where it is while joining lines
nnoremap J mzJ`z

"center screen after moving
nnoremap } }zz

"find all occurences of word under cursor
nnoremap K :grep! "\b<cword>\b"<CR>:cw<CR>

" do nothing
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap Q <nop>

" Close the current buffer
map <leader>bd :Bclose<cr>

" switch to last open buffer
nnoremap <leader><leader> :b#<CR>

" easier sorting key stroke in visual mode
xnoremap <C-s> :sort ui<CR>
vnoremap // y/<C-R>"<CR>

" window sizing if there is one
if bufwinnr(1)
  nnoremap <S-Up> <C-W>+
  nnoremap <S-Down> <C-W>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>
endif


" Tabs -----------------------------------------------------------------------
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set showtabline=2
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''

  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    " local work directory
    let lwd = fnamemodify(getcwd(winnr, tabnr), ':t')
    " if the current tab is in the loop, select it
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr
    let s .= ' ' . lwd . ' '

    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '+ ' | endif
  endfor

  let s .= '%#TabLineFill#'

  return s
endfunction
" -----------------------------------------------------------------------------

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd vimrc BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" accessing and sourcing vimrc easily
nmap <silent> <leader>sv :source $MYVIMRC
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" dictionary complete word
inoremap <C-k> <C-x><C-k>

function! ConfirmDelete() abort
  if (confirm('Are you sure you want to delete ' . expand('%:p')))
    call delete(expand('%')) | bdelete!
  endif
endfunction

nnoremap <leader>rm :call ConfirmDelete()<cr>

" Abbreviations ---------------------------------------------------------------
iab <expr> dts strftime("%c")


""""""""""""""""""""""""
" UI STUFF
""""""""""""""""""""""""
" MUST BE BEFORE THE COLOR HIGHLIGHTING WHEN NOT USING MATCH
syntax on
set encoding=utf-8
"automatically highlight matching braces/brackets/etc.
set showmatch
"tens of a second to show matching parentheses
set matchtime=2
set showmode

" highlight white space at end of line and anything over 80 lines
highlight ExtraWhitespace ctermbg=red guibg=red

if has('matchadd')
  autocmd vimrc BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$', -1)
else
  match ExtraWhitespace /\s\+$/
  autocmd vimrc BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd vimrc InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd vimrc InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd vimrc InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd vimrc InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd vimrc BufWinLeave * call clearmatches()
endif

autocmd vimrc ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" show line numbers
set number
set lazyredraw
"enable folds by default
set foldenable
"fold via syntax of files
set foldmethod=syntax
"open all folds by default
set foldlevelstart=99
set foldnestmax=10
set synmaxcol=200                                   "only highlight first 200 line since this can slow vim

set timeoutlen=200
set ttimeoutlen=200

set mousehide                                       "hide when characters are typed
set ttyfast                                         "assume fast terminal connection
set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility

" make a mark for column 80
set colorcolumn=80,100

"" Terminal setttings {{{
if !has("gui_running")
  set noerrorbells novisualbell t_vb=
  set termencoding=utf8
  set t_ut= " setting for looking properly in tmux
  set t_BE= " disable bracketed-paste mode
  let &t_Co = 256
  " del key will be backspace, so stop that from happening
  inoremap <Char-0x07F> <BS>
  nnoremap <Char-0x07F> <BS>
  " src: https://conemu.github.io/en/VimXterm.html
  " trick to support 256 colors and scroll in conemu
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  inoremap <esc>[62~ <c-x><c-e>
  inoremap <esc>[63~ <c-x><c-y>
  nnoremap <esc>[62~ 3<c-e>
  nnoremap <esc>[63~ 3<c-y>
  if exists('$CONEMU')
    set term=xterm
    !chcp 65001
    " this gets rid of funny characters
  endif
endif

"tree
" new files are with %
let g:netrw_liststyle = 3
" open in previous window
let g:netrw_browse_split = 4
" split right
let g:netrw_altv = 1
let g:netrw_winsize = 25

"true colors
if (has('termguicolors'))
  set termguicolors
endif

" make sure this is the first thing on the status line after all plugins are loaded
set laststatus=2
set statusline=
set statusline+=\ [%n]                      " buffer number
set statusline+=\ %t                        " filename
set statusline+=\ %*                        " restore highlight
set statusline+=\ %M                        " modified flag
set statusline+=%=                          " end of left side
set statusline+=\ %{&fileformat}
set statusline+=\ %*                        " restore highlight
set statusline+=\|
set statusline+=\ %{(&fenc!=''?&fenc:&enc)} " file encoding
set statusline+=\ %*                        " restore highlight
set statusline+=\|
set statusline+=\ %{&ft!=#''?&ft:'no\ ft'}  " file type
set statusline+=\ %*                        " restore highlight
set statusline+=\|
set statusline+=\ %p%%                      " percentage in lines
set statusline+=\ %l,%c                     " current line & column
set statusline+=\ %*                        " restore highlight
set statusline+=\|


""""""""""""""""""""""""
" PLUGIN STUFF
""""""""""""""""""""""""
" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call plugpac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()

call plugpac#begin()

runtime! macros/matchit.vim
