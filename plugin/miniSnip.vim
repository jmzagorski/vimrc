Plugin 'Jorengarenar/miniSnip'

" TODO bug, singular in docs
let g:miniSnip_dirs=[ $MYVIMRCPATH . '/after/mysnippets' ]
let g:miniSnip_ext="snippet"
let g:miniSnip_trigger="<C-s>"

function! LoadTemplate() abort
  let buf = expand('%:t')
  let ft = getbufvar(buf, '&filetype')
  let skeleton = $MYVIMRCPATH .'/after/mysnippets/'.ft.'/skeleton.snippet'
  if filereadable(skeleton)
    exec "norm! i " . 'skeleton' . "\<C-r>=miniSnip#trigger()\<CR>"
  endif
endfunction

autocmd vimrc BufNewFile * call LoadTemplate()
autocmd vimrc FileType typescript let b:miniSnip_opening="{{" | let b:miniSnip_closing="}}"
autocmd vimrc FileType cs let b:miniSnip_opening="{{" | let b:miniSnip_closing="}}"
autocmd vimrc FileType sql let b:miniSnip_opening="${" | let b:miniSnip_closing="}"
