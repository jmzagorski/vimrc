if &runtimepath !~# 'vim-jsbeautify'
  packadd vim-jsbeautify
endif

nnoremap <buffer> <c-f> :call JsBeautify()<CR>
