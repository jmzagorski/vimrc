Plugin 'junegunn/goyo.vim'

function! s:goyo_enter()
  if match(&runtimepath, "limelight") != -1
    Limelight
  endif
endfunction

function! s:goyo_leave()
  if match(&runtimepath, "limelight") != -1
    Limelight!
  endif
endfunction

autocmd vimrc User GoyoEnter nested call <SID>goyo_enter()
autocmd vimrc User GoyoLeave nested call <SID>goyo_leave()
map <expr> <Leader>gy exists('#goyo') ? ":Goyo!<cr>" : ":Goyo<cr>"
