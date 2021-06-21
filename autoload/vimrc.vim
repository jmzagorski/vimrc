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

function! vimrc#get_modifiable_flag(...) abort
  if &readonly  || !&modifiable
    return '-'
  else
    return ''
endfunction

function! vimrc#open_testfile(...) abort
  let testing = get(g:, 'vimrc_testing_' . &filetype, {})

  return expand("%:t:r") . testing.suffix
endfunction

function! vimrc#set_unicode(...) abort
  if &encoding !~? '^u'
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    setglobal encoding=utf-8
    scriptencoding utf-8
  endif
  set fileencoding=utf-8
  setglobal fileencodings=ucs-bom,utf-8,latin1
endfunction

function! vimrc#get_tabline(...) abort
  let s = ''

  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    " local work directory
    let lwd = fnamemodify(getcwd(winnr, tabnr), ':t')
    " if the current tab is in the loop, select it
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr
    let s .= ' ' . lwd . ' '

    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '+ ' | endif
  endfor

  let s .= '%#TabLineFill#'

  return s
endfunction
