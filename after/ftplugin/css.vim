if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'vim-css3-syntax'
  packadd vim-css3-syntax
endif

if &runtimepath !~# 'vim-jsbeautify'
  packadd vim-jsbeautify
endif

nnoremap <buffer> <c-f> :call CssBeautify()<CR>
