Plugin 'w0rp/ale'

" less than ffff (in hex format): press u (lower case), followed by its four-digit hex representation.
" less than 7fffffff (in hex format): press U (upper case), followed by its eight-digit hex
let g:ale_sign_error = ':('
let g:ale_sign_warning = ':\'
let g:ale_sign_style_error = ':('
let g:ale_sign_style_warning = ':\'

let g:ale_linters = {
  \'cs': ['OmniSharp'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver', 'eslint'],
  \'rust': ['cargo', 'rls', 'rustfmt'],
  \'markdown':['vale'],
  \'text':['vale'],
  \'vimwiki':['vale'],
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'css': ['prettier'],
\    'scss': ['prettier'],
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
        \   '%d!%dX',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

setglobal statusline+=%=
setglobal statusline^=\ %{(exists('*ale#Env')?LinterStatus():'')}

nmap <silent> ]l <Plug>(ale_previous_wrap)
nmap <silent> [l <Plug>(ale_next_wrap)
nnoremap <LocalLeader>fx :ALEFix<CR>
nnoremap <LocalLeader>rs :ALEReset<CR>

let g:ale_markdown_vale_use_global = 1
let g:ale_text_vale_use_global = 1
let g:ale_vimwiki_vale_use_global = 1
" This is the path to the script above.
let g:ale_markdown_vale_executable = expand('~/valelint.sh')
let g:ale_text_vale_executable = 'home/jmzagorski/valelint.sh'
let g:ale_vimwiki_vale_executable = expand('~/valelint.sh')
" /data matches the path in Docker.
let g:ale_filename_mappings = {
\ 'vale': [
\   ['/home/jmzagorski', '/home/valeuser'],
\ ],
\}
