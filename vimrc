augroup vimrc
  autocmd!
augroup END

" let $MYVIMRCPATH=expand("%:p")
let $MYVIMRCPATH=fnamemodify($MYVIMRC, ':h')

"{{{ Metadata
setglobal viminfo+=n$MYVIMRCPATH/.viminfo

if has("vms")
  setglobal nobackup
else
  setglobal backup
  "for backups go local directory then home
  setglobal backupdir=$MYVIMRCPATH/.backup//
  if !isdirectory($MYVIMRCPATH . '/.backup')
    call mkdir($MYVIMRCPATH . "/.backup")
  endif

  setglobal directory=$MYVIMRCPATH/.swp//
  if !isdirectory($MYVIMRCPATH . '/.swp')
    call mkdir($MYVIMRCPATH . '/.swp')
  endif

  if has('persistent_undo')
    set undofile
    setglobal undodir=$MYVIMRCPATH/.undo//
    if !isdirectory($MYVIMRCPATH . '/.undo')
      call mkdir($MYVIMRCPATH . '/.undo')
    endif
  endif
endif

setglobal secure
setglobal noerrorbells visualbell t_vb=
"}}}
"
"{{{ Visuals / UI
setglobal lazyredraw
set number relativenumber
setglobal splitbelow
setglobal splitright
if exists('+breakindent')
  set breakindent
  setglobal showbreak=\\\ \ 
endif
setglobal diffopt+=iwhite
" MUST BE BEFORE THE COLOR HIGHLIGHTING WHEN NOT USING MATCH
syntax on
set cursorline
setglobal showmatch
setglobal showmode
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
  setglobal foldlevelstart=99
endif
set synmaxcol=200
"unix/windows compatibility
if has('mksession')
  if has('win32')
    setglobal viewoptions+=unix,slash
  endif
endif
set colorcolumn=80,100
" make sure this is the first thing on the status line after all plugins are loaded
setglobal laststatus=2
setglobal statusline=
setglobal statusline+=%{vimrc#get_modifiable_flag()}
setglobal statusline+=\ [%n]                       " buffer number
setglobal statusline+=\ %t                        " filename
setglobal statusline+=\ %*                        " restore highlight
setglobal statusline+=\ %M                        " modified flag
setglobal statusline+=%=                          " end of left side
setglobal statusline+=\ %{&fileformat}
setglobal statusline+=\ %*                        " restore highlight
setglobal statusline+=\|
setglobal statusline+=\ %{(&fenc!=''?&fenc:&enc)} " file encoding
setglobal statusline+=\ %*                        " restore highlight
setglobal statusline+=\|
setglobal statusline+=\ %{&ft!=#''?&ft:'no\ ft'}  " file type
setglobal statusline+=\ %*                        " restore highlight
setglobal statusline+=\|
setglobal statusline+=\ %p%%                      " percentage in lines
setglobal statusline+=\ %l,%c                     " current line & column
setglobal statusline+=\ %*                        " restore highlight
setglobal statusline+=\|
"}}}

"{{{ Editing
setglobal thesaurus+=~/.vim/thesaurus
setglobal dictionary+=/usr/share/dict/words
autocmd vimrc FileType * execute 'setlocal dict+='.$MYVIMRCPATH.'/words/'.&filetype.'.txt'

set softtabstop=4
set shiftwidth=4
set expandtab
setglobal smarttab
setglobal shiftround
set autoindent
" sync with clipboard
setglobal clipboard^=unnamed,unnamedplus
set nomodeline
setglobal backspace=indent,eol,start
setglobal virtualedit=block
"}}}

"{{{ Buffers
setglobal hidden
"}}}
"
"{{{ Windows
if bufwinnr(1)
  nnoremap <S-Up> <C-W>+
  nnoremap <S-Down> <C-W>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>
endif
"}}}

"{{{ Files
setglobal autoread
setglobal fileformats=unix,mac,dos

" needs to be set before listchars
if has("multi_byte")
  call vimrc#set_unicode()

  scriptencoding=&encoding
endif
" listchars is here since it needt to be after unicode is set, just in case a
" unicode char is used
setglobal listchars=tab:...,space:.,nbsp:~,trail:_,precedes:>,extends:<
"}}}

"{{{ Ouput
setglobal showcmd
"}}}
"
"{{{ Search
autocmd vimrc QuickFixCmdPost [^l]* cwindow
autocmd vimrc QuickFixCmdPost l* lwindow
setglobal path+=**
setglobal ignorecase
set infercase
setglobal smartcase
setglobal incsearch
setglobal hlsearch
setglobal wildmenu
setglobal wildignorecase
setglobal wildmode=list:longest,full
setglobal wildignore+=*/node_modules/*,*/.git/*,*/obj/*,*/bin/*,*/wwwroot/*,*/dist/*
setglobal showfulltag
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
else
  set grepprg=grep\ -rn\ --exclude-dir=node_modules\ --exclude-dir=.git\ $*
endif
" midtext search
vnoremap // y/<C-R>"<CR>
command! Todo noautocmd grep -i \"TODO\|FIXME\"
nnoremap S :grep! -i "\b<cword>\b"<CR>:cw<CR>
"find all occurences of word under cursor in tags
nnoremap <C-]> g<C-]>
"}}}

"{{{ Navigation
" expansion of active dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" expansion of active dir without file extension.
cnoremap <expr> %T getcmdtype() == ':' ? expand('%:r').'.' : '%R'
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nnoremap <leader><leader> <C-^>
nnoremap Y y$
"}}}

"{{{ Tabs
cnoreabbrev <expr> tabnew (getcmdtype() ==# ':' && getcmdline() =~# '^tabnew') ? 'tabnew \| lcd' : 'tabnew'
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd vimrc TabLeave * let g:lasttab = tabpagenr()
setglobal showtabline=2
setglobal tabline=%!vimrc#get_tabline()
"}}}

" {{{ Misc. Abbreviations
iabbrev <expr> dts strftime("%c")
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() =~# '^grep') ? 'silent grep' : 'grep'
cnoreabbrev grpe grep
cnoreabbrev Ggrpe Ggrep
cnoreabbrev GIt Git
cnoreabbrev todo Todo
cnoreabbrev tf <C-R>=vimrc#open_testfile()<CR>
" }}}

" {{{ Terminal
if (has('termguicolors'))
  setglobal termguicolors
endif
" }}}

" {{{ Browsing
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

" vim:set foldmethod=marker foldlevelstart=0
