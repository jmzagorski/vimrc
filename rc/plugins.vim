if &compatible
 set nocompatible
endif

" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call plugpac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()

call plugpac#begin()

runtime! macros/matchit.vim
