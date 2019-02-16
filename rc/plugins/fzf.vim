"the build will fail if no on linux or wsl windows
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')

nnoremap <C-p> :GFiles<CR>

function! s:ripgrep_todo()
  command! Todo :Rg TODO | FIXME
endfunction

if executable('cargo')
  call dein#add('BurntSushi/ripgrep', {'build': 'cargo build --release'})
  call s:ripgrep_todo()
endif

" faster, but requires grep plugin
" command prompt in windows vs linux
" for some reason rg was corrupting the heap in vim
if executable('rg') && !has('win32') && !has('win64')
  call s:ripgrep_todo()
  nnoremap <C-g> :Rg<CR>

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
elseif executable('Ack')
  if has('win32') || has('win64')
    command! Todo Ack! "TODO | FIXME | @todo"
  else
    command! Todo Ack! 'TODO\|FIXME\|@todo'
  endif
endif
