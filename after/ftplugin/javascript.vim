if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'vim-javascript'
  packadd vim-javascript
endif

if &runtimepath !~# 'vim-jsbeautify'
  packadd vim-jsbeautify
endif

nnoremap <buffer> <c-f> :call JsBeautify()<CR>
