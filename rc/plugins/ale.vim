Plugin 'w0rp/ale'

let g:ale_sign_error = "xx"
let g:ale_sign_warning = "∆∆"
let g:ale_set_loclist = 0

let g:ale_linters = {
  \'cs': ['OmniSharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver'],
  \'rust': ['cargo', 'rustfmt']
\}

autocmd FileType cs nnoremap <buffer> gd :ALEGoToDefinition<CR>
