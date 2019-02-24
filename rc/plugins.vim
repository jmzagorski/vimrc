if &compatible
 set nocompatible
endif

source $MYVIMRCPATH/rc/minautopac.vim

filetype plugin indent on
syntax enable

runtime! macros/matchit.vim

function! ReadOnly() abort
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" make sure this is the first thing on the status line after all plugins are loaded
set statusline^=%{ReadOnly()}
set statusline+=\ %*
