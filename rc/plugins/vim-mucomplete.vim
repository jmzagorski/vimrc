call dein#add('lifepillar/vim-mucomplete')

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1
set completeopt-=preview
set completeopt+=longest,menuone,noselect
