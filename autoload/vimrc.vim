function! vimrc#get_session_name(...) abort
  let l:file = empty(get(a:, 1)) ? g:vimrc_default_session_name : get(a:, 1)
  let l:replace = '/'
  if (exists('+shellslash') && &shellslash) || has('win16') || has('win32') || has('win64')
    let l:replace = '\\'
  endif
  " turn special characters into percent signs, similar to undo/swap
  let l:dir = substitute(getcwd(), '\(' . l:replace . '\|:\|\.\)', '%', 'g')

  return expand(g:vimrc_session_path . l:replace . l:dir . '_' . l:file . '.vim')
endfunction

function! vimrc#make_session(bang, file, cmd) abort
  let l:session_name = vimrc#get_session_name(a:file)

  if (a:bang)
    execute printf('%s! %s', a:cmd, escape(l:session_name, '%'))
  else
    execute printf('%s %s', a:cmd, escape(l:session_name, '%'))
  endif
endfunction

function! vimrc#open_project(bang, dir, ...) abort
  " get all session files as a list
  let l:files = globpath(g:vimrc_session_path, '*', 0, 1)
  let l:session_name = get(a:, 3, g:vimrc_default_session_name)
  call filter(l:files, 'v:val =~ ("' . a:dir . '_' . l:session_name . '")')

  if len(l:files) == 1
    execute printf('source %s', escape(get(l:files, 0), '%'))
  else
    echoerr printf("Zero or more sessions exists for project %s session %s", a:dir, l:session_name)
  endif
endfunction
