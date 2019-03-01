" continuously updated session files
Plugin 'tpope/vim-obsession'

" plugin might not be downloaded yet
set statusline+=%{ObsessionStatus()}
set statusline+=\ %*

let g:vimrc_session_path = $MYVIMRCPATH . '/sessions'
let g:vimrc_default_session_name = 'Session'

" global do no play well with packadd
if match(&sessionoptions, 'globals') != -1
  set sessionoptions-=globals
endif

" Makes a session based on the current working directory
command! -bang -bar -nargs=? MakeSession execute s:make_session(<bang>0, <q-args>, 'Obsession')
command! -bang -bar -nargs=? OpenSession execute s:make_session(<bang>0, <q-args>, 'source')
command! -bang -bar -nargs=+ OpenProject execute s:open_project(<bang>0, <q-args>)

" auto loads a sesssion if found for current working dir
autocmd vimrc VimEnter * nested
      \ if !argc() && empty(v:this_session) && filereadable(s:get_session_name()) |
      \   execute printf('source %s', fnameescape(s:get_session_name())) |
      \ endif

function! s:get_session_name(...) abort
  let l:file = empty(get(a:, 1)) ? g:vimrc_default_session_name : get(a:, 1)
  let l:replace = '/'
  if (exists('+shellslash') && &shellslash) || has('win16') || has('win32') || has('win64')
    let l:replace = '\\'
  endif
  " turn special characters into percent signs, similar to undo/swap
  let l:dir = substitute(getcwd(), '\(' . l:replace . '\|:\|\.\)', '%', 'g')

  return expand(g:vimrc_session_path . l:replace . l:dir . '_' . l:file . '.vim')
endfunction

function! s:make_session(bang, file, cmd) abort
  let l:session_name = s:get_session_name(a:file)

  if (a:bang)
    execute printf('%s! %s', a:cmd, escape(l:session_name, '%'))
  else
    execute printf('%s %s', a:cmd, escape(l:session_name, '%'))
  endif
endfunction

function! s:open_project(bang, dir, ...) abort
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
