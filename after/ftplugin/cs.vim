if get(b:, 'current_compiler', '') ==# ''
  compiler msbuild
endif

" https://vi.stackexchange.com/questions/9936/set-tabulation-size-when-functions-parameters-are-written-on-multiple-lines
set cinoptions=(4,W4
set foldmethod=indent
let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

inoreabbr gan Guard.Against.Null(<var>).Expect(nameof(<var>));
inoreabbr gae Guard.Against.Empty(<var>).Expect(nameof(<var>));
