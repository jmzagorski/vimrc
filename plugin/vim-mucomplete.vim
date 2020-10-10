Plugin 'lifepillar/vim-mucomplete'

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 50
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect
set shortmess+=c
set belloff+=ctrlg

let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }

" use ultisnips if available first, then file, then whatever the default is setup as
" note keyn is local match
let g:mucomplete#chains.default = ['ulti', 'file'] + g:mucomplete#chains.default
let g:mucomplete#chains.sql = ['file', 'sqla', 'keyn']

autocmd vimrc BufEnter * if &ft ==# 'cs' | MUcompleteAutoOff | else | MUcompleteAutoOn | endif

" Ultisnip config so they do not mess up this plugin
let g:UltiSnipsExpandTrigger = "<f5>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"

let g:AutoPairsMapSpace = 0
imap <silent> <expr> <space> pumvisible()
    \ ? "<space>"
    \ : "<c-r>=AutoPairsSpace()<cr>"

