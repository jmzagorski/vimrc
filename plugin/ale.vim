Plugin 'w0rp/ale'

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '👀'
let g:ale_sign_style_error = '✗'
let g:ale_sign_style_warning = '👀'
" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linters = {
  \'cs': ['omnisharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver', 'eslint'],
  \'rust': ['cargo', 'rls', 'rustfmt'],
  \'markdown':['languagetool','proselint'],
  \'text':['languagetool','proselint']
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'scss': ['prettir'],
\    'html': ['prettier'],
\    'rust': ['rustfmt']
\}
let g:ale_lint_delay=1000
nnoremap gd :ALEGoToDefinition<CR>
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let b:ale_rust_rls_config = {
      \ 'rust': {
      \   'clippy_preference': 'on'
      \ }
\}

if has("unix")
  let g:ale_languagetool_executable = "/usr/bin/java"
  let g:ale_languagetool_options = "-jar ~/languagetool/languagetool-commandline.jar"
endif
