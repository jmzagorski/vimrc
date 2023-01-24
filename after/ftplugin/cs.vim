if get(b:, 'current_compiler', '') ==# ''
  compiler dotnet
endif

" https://vi.stackexchange.com/questions/9936/set-tabulation-size-when-functions-parameters-are-written-on-multiple-lines
setlocal cinoptions=(4,W4
setlocal foldmethod=indent
let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

let g:vimrc_testing_cs = {
      \ 'suffix': 'Tests.cs'
\}

nnoremap <LocalLeader>tf :call vimrc#open_testfile("Tests.cs")<CR>
