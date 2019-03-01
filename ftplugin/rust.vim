if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'rust-vim'
  packadd rust-vim
endif

if &runtimepath !~# 'vim-racer'
  packadd vim-racer
endif

nmap <buffer> gd <Plug>(rust-def)
nmap <buffer> gs <Plug>(rust-def-split)
nmap <buffer> gx <Plug>(rust-def-vertical)
nmap <buffer> <LocalLeader>gd <Plug>(rust-doc)
