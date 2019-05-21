Plugin 'w0rp/ale'

let g:ale_sign_error = "xx"
let g:ale_sign_warning = "∆∆"

let g:ale_linters = {
  \'cs': ['OmniSharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver'],
  \'rust': ['cargo', 'rustfmt']
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['prettier'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\}

" let g:ale_fix_on_save = 1

nnoremap gd :ALEGoToDefinition<CR>
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
