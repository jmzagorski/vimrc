augroup gvimrc
  autocmd!
augroup END

" hide unnecessary gui in gVim
setglobal guioptions-=m  " remove menu bar
setglobal guioptions-=T  " remove toolbar
setglobal guioptions-=r  " remove right-hand scroll bar
setglobal guioptions-=L  " remove left-hand scroll bar
setglobal guioptions-=e  " remove left-hand scroll bar
if has('win32')
  setglobal guifont=Roboto\ Mono:h11,Iosevka:h11,JetBrains_Mono:h11,Cascadia_Code:h11,Consolas:h11
  autocmd gvimrc GUIEnter * simalt ~x
else
  setglobal guifont=Roboto\ Mono\ 11,Iosevka\ 11,Ubuntu\ Mono\ 11
endif

map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

setglobal visualbell
" must be in here and vimrc since it is reset after vimrc is set
" if not set you will get a flash when at beginning or ending of file
setglobal t_vb=
" shrinks the cmdheight, which looks bigger in gvim
setglobal linespace=0
