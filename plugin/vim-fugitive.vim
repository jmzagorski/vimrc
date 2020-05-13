Plugin 'tpope/vim-fugitive'

if !has('win32')
  autocmd vimrc BufReadPost fugitive://* set bufhidden=delete
else
  autocmd vimrc BufReadPost fugitive:\\* set bufhidden=delete
endif

set statusline^=\ %{(exists('*FugitiveHead')?FugitiveHead():'')}

set tags^=./.git/tags;

nnoremap <Leader>gs :vert Git<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gl :0Gclog
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gc :Gcommit<CR>
