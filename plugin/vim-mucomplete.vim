Plugin 'lifepillar/vim-mucomplete'

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect
set shortmess+=c
set belloff+=ctrlg

" use ultisnips if available first, then file, then whatever the default is setup as
" note keyn is local match
let g:mucomplete#chains.default = ['ulti', 'file'] + g:mucomplete#chains.default

autocmd vimrc BufEnter * if &ft ==# 'cs' | MUcompleteAutoOn | else | MUcompleteAutoOff | endif

" Ultisnip config so they do not mess up this plugin
let g:UltiSnipsExpandTrigger = "<f5>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
