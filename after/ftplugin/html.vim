if &runtimepath !~# 'vim-jsbeautify'
  packadd vim-jsbeautify
endif

" TODO does not work
nnoremap <buffer> <c-f> :call HtmlBeautify()<CR>
