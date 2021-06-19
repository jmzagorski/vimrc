" Environment Variables {{{
let $MYVIMRCPATH=fnamemodify($MYVIMRC, ':h')
" }}}

"{{{ vimrc autocommands
augroup vimrc
  autocmd!
  " open quickfix/locationlix automatically
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
  autocmd FileType * execute 'setlocal dict+='.$MYVIMRCPATH.'/words/'.&filetype.'.txt'
augroup END
"}}}

" {{{ VIM 80 Defaults
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
  set backupdir=$MYVIMRCPATH/.backup//
  if !isdirectory($MYVIMRCPATH . '/.backup')
    call mkdir($MYVIMRCPATH . "/.backup")
  endif

  set directory=$MYVIMRCPATH/.swp//
  if !isdirectory($MYVIMRCPATH . '/.swp')
    call mkdir($MYVIMRCPATH . '/.swp')
  endif

  if has('persistent_undo')
    set undofile
    set undodir=$MYVIMRCPATH/.undo//
    if !isdirectory($MYVIMRCPATH . '/.undo')
      call mkdir($MYVIMRCPATH . '/.undo')
    endif
  endif
endif
" }}}

" {{{ Variables & Options
set thesaurus+=~/.thesaurus.txt
set lazyredraw
set fileformats=unix,mac,dos
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set autoindent
set smarttab
set number relativenumber
set backspace=indent,eol,start
" sync with clipboard
set clipboard^=unnamed,unnamedplus
set hidden
set autoread
set showcmd
set showfulltag
set nomodeline
set history=200
set viminfo+=n$MYVIMRCPATH/.viminfo
set secure
set virtualedit=block
set splitbelow
set splitright
" needs to be set before listchars
if has("multi_byte")
  if &encoding !~? '^u'
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
    scriptencoding utf-8
  endif
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif
set listchars=tab:...,space:.,nbsp:~,trail:_,precedes:>,extends:<
set noerrorbells visualbell t_vb=
" }}}

"{{{ Commands
command! Todo noautocmd grep -i \"TODO\|FIXME\"
"}}}

"{{{ SEARCHING
set path+=**
set ignorecase
set infercase
set smartcase
set incsearch
set hlsearch
set wildmenu
set wildignorecase
set wildmode=list:longest,full
set wildignore+=*/node_modules/*,*/.git/*,*/obj/*,*/bin/*,*/wwwroot/*,*/dist/*
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
else
  let &grepprg='grep -n -R --exclude=' . shellescape(&wildignore) . ' $*'
endif
" midtext search
vnoremap // y/<C-R>"<CR>
"find all occurences of word under cursor
nnoremap K :grep! -i "\b<cword>\b"<CR>:cw<CR>
nnoremap <C-]> g<C-]>
"}}}

" {{{ Mappings
" expansion of active dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" expansion of active dir without file extension.
cnoremap <expr> %T getcmdtype() == ':' ? expand('%:r').'.' : '%R'
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nnoremap Y y$
nnoremap <leader><leader> <C-^>
" window sizing if there is one
if bufwinnr(1)
  nnoremap <S-Up> <C-W>+
  nnoremap <S-Down> <C-W>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>
endif
"}}}

"{{{ Tabs
cnoreabbrev <expr> tabnew (getcmdtype() ==# ':' && getcmdline() =~# '^tabnew') ? 'tabnew \| lcd' : 'tabnew'
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
cnoreabbrev grpe grep
cnoreabbrev Ggrpe Ggrep
cnoreabbrev GIt Git
cnoreabbrev todo Todo
" }}}

" {{{ UI
if exists('+breakindent')
  set breakindent
  set showbreak=\\\ \ 
endif
set diffopt+=iwhite
" MUST BE BEFORE THE COLOR HIGHLIGHTING WHEN NOT USING MATCH
syntax on
set cursorline
set showmatch
set showmode
  " highlight white space at end of line and anything over 80 lines
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
augroup end
if has('folding')
  "open all folds by default
  set foldlevelstart=99
endif
set synmaxcol=200
"unix/windows compatibility
if has('mksession')
  if has('win32')
    set viewoptions+=unix,slash
  endif
endif
set colorcolumn=80,100
" make sure this is the first thing on the status line after all plugins are loaded
set laststatus=2
set statusline=
set statusline+=%{vimrc#get_modifiable_flag()}
set statusline+=\ [%n]                       " buffer number
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
if (has('termguicolors'))
  set termguicolors
endif
if &term=="win32"
  :silent execute "!chcp 65001"
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

" {{{ Abbreviation
cnoreabbrev tf <C-R>=vimrc#open_testfile()<CR>
"}}}

" {{{ Plugins
" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call plugpac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()
call plugpac#begin()
runtime! macros/matchit.vim
" }}}
