function! has#colorscheme(name)
  return !empty(globpath(&rtp, 'colors/'.a:name.'.vim'))
endfunction
