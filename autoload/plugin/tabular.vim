function! plugin#tabular#AlignSqlTable()
  if exists('*Tabularize')
    :Tabularize /\v\s(,\s|"[^"]*")("[^"]*"|[A-Za-z]*)\zs
    :Tabularize /\v\([^\)]*\)
    :Tabularize /\v(not null|null)
  endif
endfunction
