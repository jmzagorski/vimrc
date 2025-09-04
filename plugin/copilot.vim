Plugin 'github/copilot.vim'

imap <silent><script><expr> <CR> copilot#Accept("\<CR>")
imap <C-\> <Plug>(copilot-suggest)
let g:copilot_no_tab_map = v:true
