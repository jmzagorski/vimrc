let $MYVIMRCPATH=fnamemodify($MYVIMRC, ':h')
if &compatible
  set nocompatible
endif

"{{{ vimrc autocommands
augroup vimrc
  autocmd!
  " make sure our buffer is always up to date
  autocmd CursorHold * silent! checktime
  " In the quickfix window, <CR> is used to jump to the error under the
  " cursor, so undefine the mapping there.
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  " open quickfix/locationlix automatically
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
  " Default split when open quickfix
  autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L
  autocmd FileType * execute 'setlocal dict+='.$MYVIMRCPATH.'/words/'.&filetype.'.txt'
augroup END
"}}}

" {{{ VIM 80 Defaults
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
  set backupdir=$VIM/.backup//
  if !isdirectory($VIM . '/.backup')
    call mkdir($VIM . "/.backup")
  endif

  set directory=$VIM/.swp//
  if !isdirectory($VIM . '/.swp')
    call mkdir($VIM . '/.swp')
  endif

  if has('persistent_undo')
    set undofile
    set undodir=$VIM/.undo//
    if !isdirectory($VIM . '/.undo')
      call mkdir($VIM . '/.undo')
    endif
  endif
endif
" }}}

" {{{ Variables & Options
let mapleader = ','
let maplocalleader = ','
set thesaurus+=~/.thesaurus.txt
" don't redraw while executing macros
set lazyredraw
" Automatic end-of-file format detection
set fileformats=unix,mac,dos
" expand tabs to spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
" no tabs
set smarttab
set relativenumber
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" sync with clipboard
set clipboard^=unnamed,unnamedplus
" allow buffer switching without saving
set hidden
" reload files changed outside vim
set autoread
set showcmd
set showfulltag
set nomodeline
set noerrorbells
set novisualbell
" number of command lines to remember default is 20
set history=1000
 " set vim info in vim directory, out of sight
set viminfo+=n$VIM/viminfo
set exrc
set secure
set virtualedit=block
" on vert split, split below
set splitbelow
" on horizontal split, split right
set splitright
set linebreak
set winfixwidth
" needs to be set before listchars
set encoding=utf8
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
" }}}

"{{{ Commands
command! Todo noautocmd grep  -i \"TODO\|FIXME\"
"}}}

"{{{ SEARCHING
set path+=**
set ignorecase
set infercase
" do not ignore case when capitalization are in search
set smartcase
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
set wildignore+=*/wwwroot/*
set wildignore+=*/dist/*
set wildignore+=*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/.mimosa
if executable('rg')
  setglobal grepprg=rg\ -H\ --no-heading\ --vimgrep
else
  setglobal grepprg=grep\ -n\ -r\ $*\ /dev/null
endif
vnoremap // y/<C-R>"<CR>
"}}}

" {{{ Mappings
" keep the reverse search character since it is the comma and that is my leader
inoremap kj <esc>
nnoremap \ ,
" expansion of active dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" expansion of active dir without file extension.
cnoremap <expr> %T getcmdtype() == ':' ? expand('%:r').'.' : '%R'
" remap buffer switching left/right/up/down
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
" Enable folding with the spacebar
nnoremap <space> za
"yank from cursors to end of line
nnoremap Y y$
"keep cursor where it is while joining lines
nnoremap J mzJ`z
"center screen after moving
nnoremap } }zz
"find all occurences of word under cursor
nnoremap K :grep! -i "\b<cword>\b"<CR>:cw<CR>
" do nothing
nnoremap <F1> <nop>
nnoremap Q <nop>
" Close the current buffer
nnoremap <leader>bd :Bclose<cr>
" switch to last open buffer
nnoremap <leader><leader> :b#<CR>
" window sizing if there is one
if bufwinnr(1)
  nnoremap <S-Up> <C-W>+
  nnoremap <S-Down> <C-W>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>
endif
nnoremap <Leader>vr :silent vertical resize 60<CR>
" accessing and sourcing vimrc easily
nnoremap <silent> <leader>sv :source $MYVIMRC
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

function! ConfirmDelete() abort
  if (confirm('Are you sure you want to delete ' . expand('%:p')))
    call delete(expand('%')) | bdelete!
  endif
endfunction
nnoremap <leader>rm :call ConfirmDelete()<cr>
"}}}

"{{{ Tabs
cnoreabbrev <expr> tabnew (getcmdtype() ==# ':' && getcmdline() =~# '^tabnew') ? 'tabnew \| lcd' : 'tabnew'
cnoreabbrev grpe grep
cnoreabbrev Ggrpe Ggrep
cnoreabbrev GIt Git
cnoreabbrev todo Todo
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set showtabline=2
function! MyTabLine() abort
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
set tabline=%!MyTabLine()
"}}}

" {{{ Abbreviations
iab <expr> dts strftime("%c")
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() =~# '^grep') ? 'silent grep' : 'grep'
" }}}

" {{{ UI
set breakindent
set showbreak=\\\ \ 
set diffopt+=iwhite
" MUST BE BEFORE THE COLOR HIGHLIGHTING WHEN NOT USING MATCH
syntax on
set encoding=utf-8
set cursorline
"automatically highlight matching braces/brackets/etc.
set showmatch
"tens of a second to show matching parentheses
set matchtime=2
set showmode
highlight ExtraWhitespace ctermbg=red guibg=red
augroup vimrc_ui
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  if has('matchadd')
    autocmd BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$', -1)
  else
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
  endif
  " highlight white space at end of line and anything over 80 lines
augroup end
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
"only highlight first 200 line since this can slow vim
set synmaxcol=200
set timeoutlen=200
set ttimeoutlen=200
"hide when characters are typed
set mousehide
"assume fast terminal connection
set ttyfast
"unix/windows compatibility
set viewoptions=folds,options,cursor,unix,slash
" make a mark for column 80
set colorcolumn=80,100
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
"}}}

" {{{ Terminal
if !has("gui_running")
  set noerrorbells novisualbell t_vb=
  set termencoding=utf8
endif
"true colors
if (has('termguicolors'))
  set termguicolors
endif
" }}}

" {{{ Browser
let g:netrw_banner=0
"tree
let g:netrw_liststyle = 3
" open in previous window
let g:netrw_browse_split = 4
" split right
let g:netrw_altv = 1
let g:netrw_winsize = 25
" FIXME might be a bug, does not work in windows
let g:netrw_browsex_viewer="firefox"
"}}}

" {{{ Plugins
" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call plugpac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()
call plugpac#begin()
runtime! macros/matchit.vim
" }}}

" {{{ Templates
function! LoadTemplate() abort
  let buf = expand('%:t')
  " grab all parts after first dot, allows for spec.ts file for example
  let parts = split(buf, '\.')[1:]
  let skeleton = $MYVIMRCPATH .'/templates/skeleton.' . join(parts, '.')
  if filereadable(skeleton)
    execute '0read ' . skeleton
  endif
endfunction

" dont add the read file as alternative buffer (skeleton)
set cpoptions-=a

" autocmd vimrc BufNewFile *	execute '-1r ' . $MYVIMRCPATH . '/templates/skeleton.' . &ft
autocmd vimrc BufNewFile * call LoadTemplate()
"}}}
