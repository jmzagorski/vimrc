Plugin 'w0rp/ale'

let g:ale_sign_error = "xx"
let g:ale_sign_warning = "∆∆"

let g:ale_linters = {
  \'cs': ['OmniSharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver'],
  \'rust': ['cargo', 'rustfmt']
\}

nnoremap gd :ALEGoToDefinition<CR>
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
