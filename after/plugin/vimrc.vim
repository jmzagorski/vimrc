" Kind of a hack, but these are things i want done after the plugins load
" not sure where else to put this kind of logic
function! ReadOnly() abort
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" make sure this is the first thing on the status line after all plugins are loaded
set statusline^=\ %*
set statusline^=%{ReadOnly()}
