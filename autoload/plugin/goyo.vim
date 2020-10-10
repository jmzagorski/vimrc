function! plugin#goyo#enter() abort
  if match(&runtimepath, "limelight") == -1
    packadd limelight.vim
    Limelight
  endif
endfunction

function! plugin#goyo#leave() abort
  if match(&runtimepath, "limelight") != -1
    Limelight!
  endif
endfunction

