Plugin 'w0rp/ale'

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '☠'
let g:ale_sign_style_error = '✗'
let g:ale_sign_style_warning = '☠'
" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linters = {
  \'cs': ['OmniSharp'],
  \'javascript': ['eslint'],
  \'typescript': ['eslint'],
  \'rust': ['cargo', 'rustfmt']
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\}

" let g:ale_fix_on_save = 1

nnoremap gd :ALEGoToDefinition<CR>
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
