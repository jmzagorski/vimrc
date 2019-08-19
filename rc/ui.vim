" MUST BE BEFORE THE COLOR HIGHLIGHTING WHEN NOT USING MATCH
syntax on
set encoding=utf-8
"automatically highlight matching braces/brackets/etc.
set showmatch
"tens of a second to show matching parentheses
set matchtime=2

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
set foldlevel=2
let g:xml_syntax_folding=1                          "enable xml folding
set synmaxcol=200                                   "only highlight first 200 line since this can slow vim

set timeoutlen=200
set ttimeoutlen=200

set mousehide                                       "hide when characters are typed
set ttyfast                                         "assume fast terminal connection
set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility

" auto wrap lines at 80
"set textwidth=80
" make a mark for column 80
set colorcolumn=80,100

" Equal splits
" autocmd vimrc VimResized * wincmd =


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

"explorer
"let g:netrw_banner = 0
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

set background=light
set cursorline

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

function! MyTabLine()
  let s = ''

  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr
    let n = tabpagewinnr(tabnr,'$')

    if n > 1 | let s .= ':' . n | endif

    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
    let bufmodified = getbufvar(bufnr, "&mod")

    if bufmodified | let s .= '+ ' | endif
  endfor

  let s .= '%#TabLineFill#'

  return s
endfunction

set tabline=%!MyTabLine()"
