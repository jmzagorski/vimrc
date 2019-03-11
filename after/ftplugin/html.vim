if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'html5.vim'
  packadd html5.vim
endif

if &runtimepath !~# 'vim-jsbeautify'
  packadd vim-jsbeautify
endif

nnoremap <buffer> <c-f> :call HtmlBeautify()<CR>
