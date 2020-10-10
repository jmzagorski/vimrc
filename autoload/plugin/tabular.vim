function! plugin#tabular#AlignSqlTable() abort
  if exists('*Tabularize')
    :Tabularize /\v\s(,\s|"[^"]*")("[^"]*"|[A-Za-z_]*)\zs
    :Tabularize /\v\([^\)]*\)
    :Tabularize /\v(not null|null)
  endif
endfunction
