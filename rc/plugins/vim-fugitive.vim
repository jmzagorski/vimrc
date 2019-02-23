Plugin 'tpope/vim-fugitive'

autocmd vimrc BufReadPost fugitive://* set bufhidden=delete

set statusline^=\ %{FugitiveHead()}
