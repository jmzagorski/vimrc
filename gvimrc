augroup gvimrc
  autocmd!
augroup END

" hide unnecessary gui in gVim
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar
set guioptions-=e  " remove left-hand scroll bar
if has('win32')
  set guifont=Roboto\ Mono:h11,Iosevka:h11,JetBrains_Mono:h11,Cascadia_Code:h11,Consolas:h11
  autocmd gvimrc GUIEnter * simalt ~x
else
  set guifont=Roboto\ Mono\ 11,Iosevka\ 11,Ubuntu\ Mono\ 11
endif

map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

set visualbell t_vb=
