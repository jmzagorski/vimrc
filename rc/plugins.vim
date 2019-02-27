if &compatible
 set nocompatible
endif

let s:dir = $MYVIMRCPATH . '/pack/minpac/opt/minpac'

if !isdirectory(s:dir)
  silent! call mkdir(s:dir, 'p')
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', s:dir)
end

packadd minpac

if !exists('*minpac#init')
  echohl WarningMsg
  echom 'Skipping minpac setup. minpac package manager is not installed.'
  echohl None
  finish
endif

call minpac#init()

" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call plugpac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()

function! PackList(...)
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

command! -nargs=1 -complete=custom,PackList
      \ PackOpenDir call term_start(&shell,
      \    {'cwd': minpac#getpluginfo(<q-args>).dir,
      \     'term_finish': 'close'})

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

call plugpac#begin()
