Plugin 'tpope/vim-fugitive'

if has('win32')
  autocmd vimrc BufReadPost fugitive://* set bufhidden=delete
else
  autocmd vimrc BufReadPost fugitive:\\* set bufhidden=delete
endif

set statusline^=\ %{(exists('*FugitiveHead')?FugitiveHead():'')}
