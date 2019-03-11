if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'vim-ps1'
  packadd vim-ps1
endif
