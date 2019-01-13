"the build will fail if no on linux or wsl windows
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')

nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

function! s:ripgrep_todo()
  command! Todo :Rg TODO | FIXME
endfunction

if executable('cargo')
  call dein#add('BurntSushi/ripgrep', {'build': 'cargo build --release'})
  call s:ripgrep_todo()
endif

" faster, but requires grep plugin
" command prompt in windows vs linux
if executable('rg')
  call s:ripgrep_todo()
elseif executable('Ack')
  if has('win32') || has('win64')
    command! Todo Ack! "TODO | FIXME | @todo"
  else
    command! Todo Ack! 'TODO\|FIXME\|@todo'
  endif
endif

