call dein#add('lifepillar/vim-mucomplete')

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect
set shortmess+=c
set belloff+=ctrlg

let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }
let g:mucomplete#chains = { 'sql' : ['file', 'sqla', 'keyn'] }

autocmd BufEnter * if &ft ==# 'cs' | MUcompleteAutoOn | else | MUcompleteAutoOff | endif
