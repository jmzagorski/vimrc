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
let g:my_git_review_branch='main'

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
" command! -bar -nargs=? Greview execute 'args `git diff --name-only ' . (<q-args> == '' ? 'main' : <q-args>) . '...`'
command! -nargs=? -complete=customlist,fugitive#CompleteObject Greview :call ReviewBranch(<q-args>)

function! ReviewBranch(branch)
  if !empty(a:branch)
    echow 'Comparing against branch ' . a:branch
    let g:my_git_review_branch = a:branch
  endif

  " Get the list of changed files with paths
  let l:files = split(system('git diff --name-only ' . g:my_git_review_branch . '...'), "\n")

  " Remove empty entries and keep full paths
  let l:files = filter(l:files, 'v:val != ""')

  " Sort the files
  call sort(l:files)

  " Update the argument list with sorted files
  execute 'args ' . join(l:files, ' ')

  execute 'Gdiffsplit ' . g:my_git_review_branch
endfunction

function! DiffSplitWithBranch()
    let l:branch = input('Enter branch name: ')
    execute 'Gdiffsplit ' . l:branch
endfunction

nnoremap <leader>pr :execute 'Gdiffsplit ' . g:my_git_review_branch<CR>
nnoremap <leader>nd :NextDiff<CR>
nnoremap <leader>pd :PrevDiff<CR>
nnoremap <leader>gt :e ./.git/COMMIT_DRAFT.md<CR>

augroup GitDiffAutoMap
  autocmd!
  autocmd BufEnter * if &diff | nnoremap <buffer> ]a <C-W><C-O>:next<CR>:execute 'Gdiffsplit ' . g:my_git_review_branch<CR> |
augroup END
