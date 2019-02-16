call dein#add('tpope/vim-fugitive')
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline^=\ %{FugitiveHead()}
