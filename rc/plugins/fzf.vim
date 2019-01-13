"the build will fail if no on linux or wsl windows
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')

nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

if executable('cargo')
  call dein#add('BurntSushi/ripgrep', {'build': 'cargo build --release'})
  s:ripgrep_todo();
endif

" faster, but requires grep plugin
" command prompt in windows vs linux
if executable('rg')
  s:ripgrep_todo();
endif

function! s:ripgrep_todo()
  if has('win32') || has('win64')
    command! Todo Rg "TODO | FIXME | @todo"
  else
    command! Todo Rg 'TODO\|FIXME\|@todo'
  endif
endfunction
