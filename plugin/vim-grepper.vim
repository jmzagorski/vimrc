" use your favorite grep tool
Plugin 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']  }

" by default ignore case
command! -nargs=+ Rg :GrepperRg <args>
command! Todo :Rg -i "todo|fixme"
nnoremap <leader>gg :Grepper -tool rg<cr>
