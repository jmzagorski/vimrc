function! plugin#goyo#enter()
  if match(&runtimepath, "limelight") != -1
    Limelight
  endif
endfunction

function! plugin#goyo#leave()
  if match(&runtimepath, "limelight") != -1
    Limelight!
  endif
endfunction

