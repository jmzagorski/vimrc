Plugin 'Jorengarenar/miniSnip'

" TODO bug, singular in docs
let g:miniSnip_dirs=[ $MYVIMRCPATH . '/after/mysnippets' ]
let g:miniSnip_ext="snippet"
let g:miniSnip_opening="${"
let g:miniSnip_closing="}"
let g:miniSnip_finalOp="{0"
let g:miniSnip_finalEd="}"

nnoremap <Tab><Tab> :call miniSnip#expand()<CR>
