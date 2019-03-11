if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'vim-markdown'
  packadd vim-markdown
endif
