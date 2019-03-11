if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'yats.vim'
  packadd yats.vim
endif

nnoremap <buffer> gd :ALEGoToDefinition<CR>
