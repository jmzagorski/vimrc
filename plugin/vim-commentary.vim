Plugin 'tpope/vim-commentary'

autocmd FileType cs setlocal commentstring=//\ %s
" use ' since vbs files are considered vb too
autocmd FileType vb setlocal commentstring=\'\ %s
