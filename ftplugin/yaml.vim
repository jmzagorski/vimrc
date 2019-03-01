if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'yaml-vim'
  packadd yaml-vim
endif

setlocal foldmethod=indent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
