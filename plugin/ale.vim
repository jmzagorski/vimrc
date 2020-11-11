Plugin 'w0rp/ale'

" less than ffff (in hex format): press u (lower case), followed by its four-digit hex representation.
" less than 7fffffff (in hex format): press U (upper case), followed by its eight-digit hex
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '👀'
let g:ale_sign_style_error = '✗'
let g:ale_sign_style_warning = '👀'

let g:ale_linters = {
  \'cs': ['omnisharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver', 'eslint'],
  \'rust': ['cargo', 'rls', 'rustfmt'],
  \'markdown':['languagetool','proselint'],
  \'text':['languagetool','proselint'],
  \'vimwiki':['languagetool','proselint'],
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
let g:ale_rust_cargo_check_tests = 1
let b:ale_rust_rls_config = {
      \ 'rust': {
      \   'clippy_preference': 'on'
      \ }
\}

if has("unix")
  let g:ale_languagetool_executable = "/usr/bin/java"
  let g:ale_languagetool_options = "-jar ~/languagetool/languagetool-commandline.jar"
else
  let g:ale_languagetool_executable = "powershell"
  let g:ale_languagetool_options = "Invoke-WebRequest http://localhost:8010/v2/check?language=en-US&text='"
endif

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d👀 %d✗',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}

nmap <silent> ]l <Plug>(ale_previous_wrap)
nmap <silent> [l <Plug>(ale_next_wrap)
nnoremap <LocalLeader>fx :ALEFix<CR>
nnoremap <LocalLeader>rs :ALEReset<CR>
