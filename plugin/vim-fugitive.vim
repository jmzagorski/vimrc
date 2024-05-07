Plugin 'tpope/vim-fugitive'

augroup vimrc_fugitive_commands
  autocmd!
  if !has('win32')
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  else
    autocmd BufReadPost fugitive:\\* setlocal bufhidden=delete
  endif
augroup END

setglobal statusline^=\ %{(exists('*FugitiveHead')?FugitiveHead():'')}

let g:fugitive_summary_format='%an:\ %s'

setglobal tags^=./.git/tags;

nnoremap <Leader>gs :vert Git<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gl :0Gclog
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gc :Git commit<CR>
command! -bar -nargs=? Gbranch :Git checkout -b <q-args>
command! -bar Gpushnewbranch execute(':Git push -u origin ' . FugitiveHead())
command! -bar Gpullstash execute(':Git stash | Git pull | Git stash pop')
command! -bar -nargs=? Greview execute 'args `git diff --name-only ' . (<q-args> == '' ? 'main' : <q-args>) . '...`'

function! DiffSplitWithBranch()
    let l:branch = input('Enter branch name: ')
    execute 'Gdiffsplit ' . l:branch
endfunction

nnoremap <leader>pr :Gdiffsplit main
