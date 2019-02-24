Plugin 'tpope/vim-fugitive'

autocmd vimrc BufReadPost fugitive://* set bufhidden=delete

" plugin might not be downloaded yet
if exists('*FugitiveHead')
  set statusline^=\ %{FugitiveHead()}
endif
