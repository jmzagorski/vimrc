" hide unnecessary gui in gVim
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar
set guioptions-=e  " remove left-hand scroll bar
set hlsearch
if has('gui_win32')
  set guifont=Cascadia_Code:h10
else
  set guifont=Cascadia\ Code\ 10
endif
if !has('windows')
  " does not work on windows
  set transparency=2
endif
"ligature support for Fira Code
set renderoptions=type:directx
set encoding=utf-8

" if windows...
if has('win32') || has('win64')
    " start maximized
    autocmd GUIEnter * simalt ~x
endif

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" terminal color
set t_Co=16

" accessing and sourcing gvimrc easily
nmap <silent> <leader>sgv :source $MYGVIMRC
nmap <silent> <leader>egv :e $MYGVIMRC<CR>

" No beep sound
set noerrorbells
set visualbell t_vb=

"enable mouse
set mouse=a

map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
