if &compatible
 set nocompatible
endif

source $MYVIMRCPATH/rc/minautopac.vim

runtime! OPT ftdetect/**/*.vim
runtime! OPT after/ftdetect/**/*.vim
runtime! rc/plugins/*.vim

filetype plugin indent on
syntax enable

runtime! macros/matchit.vim

" some plugins name (e.g. Dockerfile.vim) may have similar names in their ftdetch files
autocmd vimrc BufRead,BufNewFile *.vim set ft=vim

function! ReadOnly() abort
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" make sure this is the first thing on the status line after all plugins are loaded
set statusline^=%{ReadOnly()}
set statusline+=\ %*
