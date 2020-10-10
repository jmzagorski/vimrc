function! plugpac#begin() abort
  let s:repos = {}
  call s:setup_commands()
endfunction

function! plugpac#end() abort
  runtime! OPT ftdetect/**/*.vim
  runtime! OPT after/ftdetect/**/*.vim
endfunction

function! s:plugin_list(...) abort
  call s:init_minpac()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

function! plugpac#add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let s:repos[a:repo] = l:opts
endfunction

function! s:setup_commands() abort
  command! -bar -nargs=+ Pack call plugpac#add(<args>)
  command! -bar PackInstall call s:init_minpac() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))
  command! -bar PackUpdate  call s:init_minpac() | call minpac#update('', {'do': 'call minpac#status()'})
  command! -bar PackClean   call s:init_minpac() | call minpac#clean()
  command! -bar PackStatus  call s:init_minpac() | call minpac#status()
  command! -nargs=1 -complete=custom,s:plugin_list PackOpenDir
    \ call term_start(&shell,
    \    {'cwd': minpac#getpluginfo(<q-args>).dir,
    \     'term_finish': 'close'})
endfunction

function! s:init_minpac() abort
  try
    let s:dir = $MYVIMRCPATH . '/pack/minpac/opt/minpac'

    " TODO dont check for directory check for init function,
    " maybe try to packadd it first
    if !isdirectory(s:dir) && !exists('*minpac#init')
      if confirm('minpac is not installed. Would you like to install it now?', "&Yes\n&No", 2) == 1
        if executable('git')
          silent! call mkdir(s:dir, 'p')
          silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', s:dir)
        else
          throw '[plugpac] Git is not installed. minpac cannot be installed'
        endif
      endif
    endif

    packadd minpac
    call minpac#init()
    for [repo, opts] in items(s:repos)
      call minpac#add(repo, opts)
    endfor
  catch /.*/
    echohl WarningMsg
    echom '[plugpac] Skipping minpac installation. Plugins will not be installed'
    throw v:exception
    echohl None
  endtry
endfunction
