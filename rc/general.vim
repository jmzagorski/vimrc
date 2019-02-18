" ---------------------- FROM VIM 80 Exmaple ----------------------
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
    call mkdir($HOME "/.backup")
  endif

  set directory=~/.swp//
  if !isdirectory($HOME . '/.swp')
    call mkdir($HOME . '/.swp')
  endif

  if has('persistent_undo')
    set undofile	        " keep an undo file (undo changes after closing)
    set undodir=~/.undo//
    if !isdirectory($HOME . '/.undo')
      call mkdir($HOME '/.undo')
    endif
  endif
endif

" ----------------------------------------------------------------

let mapleader = ','
let g:mapleader = ','
set spell
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
set tags=tags;/
set showfulltag
set modeline
set modelines=5
set noerrorbells
set novisualbell
set history=1000                             " number of command lines to remember default is 20
" ---------------------- SEARCHING ----------------------
set ignorecase                               " ignore case on searching
set smartcase                                " do not ignore case when capitalization are in search
set noswapfile
set incsearch
set hlsearch
" enable menu at bottom of window (e.g. colorscheme <Tab>)
set wildmenu
set wildmode=list:longest,full
" makes vimgrep and searches faster since these are normally not your code
set wildignore+=*/node_modules/*
set wildignore+=*/obj/*
set wildignore+=*/jspm_packages/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/.mimosa
" ---------------------- END SEARCHING ----------------------
set exrc
set secure
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set virtualedit=block
" on vert split, split below
set splitbelow
" on horizontal split, split right
set splitright
set linebreak
au BufRead *.spark set filetype=html

" Default todo list
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw
