" Author: Ben Yip (yebenmy@protonmail.com)
" URL:    https://github.com/bennyyip/plugpac.vim
" ---------------------------------------------------------------------
let s:TYPE = {
      \   'string':  type(''),
      \   'list':    type([]),
      \   'dict':    type({}),
      \   'funcref': type(function('call'))
      \ }

function! plugpac#begin()
  let s:lazy = { 'ft': {}, 'map': {}, 'cmd': {} }
  let s:repos = {}

  if exists('#PlugPac')
    augroup PlugPac
      autocmd!
    augroup END
    augroup! PlugPac
  endif

  call s:setup_command()
endfunction

function! plugpac#end()
  for [l:name, l:cmds] in items(s:lazy.cmd)
    for l:cmd in l:cmds
      execute printf("command! -nargs=* -range -bang %s packadd %s | call s:do_cmd('%s', \"<bang>\", <line1>, <line2>, <q-args>)", l:cmd, l:name, l:cmd)
    endfor
  endfor

  for [l:name, l:maps] in items(s:lazy.map)
    for l:map in l:maps
      for [l:mode, l:map_prefix, l:key_prefix] in
            \ [['i', '<C-O>', ''], ['n', '', ''], ['v', '', 'gv'], ['o', '', '']]
        execute printf(
        \ '%snoremap <silent> %s %s:<C-U>packadd %s<bar>call <SID>do_map(%s, %s, "%s")<CR>',
        \  l:mode, l:map, l:map_prefix, l:name, string(l:map), l:mode != 'i', l:key_prefix)
      endfor
    endfor
  endfor

  runtime! OPT ftdetect/**/*.vim
  runtime! OPT after/ftdetect/**/*.vim
endfunction

" https://github.com/k-takata/minpac/issues/28
function! plugpac#add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')

  if has_key(l:opts, 'on')
    let l:opts['type'] = 'opt'
  endif

  if has_key(l:opts, 'on')
    for l:cmd in s:to_a(l:opts.on)
      if l:cmd =~? '^<Plug>.\+'
        if empty(mapcheck(l:cmd)) && empty(mapcheck(l:cmd, 'i'))
          call s:assoc(s:lazy.map, l:name, l:cmd)
        endif
      elseif cmd =~# '^[A-Z]'
        if exists(":".l:cmd) != 2
          call s:assoc(s:lazy.cmd, l:name, l:cmd)
        endif
      else
        call s:err('Invalid `on` option: '.cmd.
              \ '. Should start with an uppercase letter or `<Plug>`.')
      endif
    endfor
  endif

  let s:repos[a:repo] = l:opts
endfunction

function! s:assoc(dict, key, val)
  let a:dict[a:key] = add(get(a:dict, a:key, []), a:val)
endfunction

function! s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:err(msg)
  echohl ErrorMsg
  echom '[plugpac] '.a:msg
  echohl None
endfunction

function! s:do_cmd(cmd, bang, start, end, args)
  exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

function! s:do_map(map, with_prefix, prefix)
  let extra = ''
  while 1
    let c = getchar(0)
    if c == 0
      break
    endif
    let l:extra .= nr2char(c)
  endwhile

  if a:with_prefix
    let prefix = v:count ? v:count : ''
    let prefix .= '"'.v:register.a:prefix
    if mode(1) == 'no'
      if v:operator == 'c'
        let prefix = "\<esc>" . prefix
      endif
      let prefix .= v:operator
    call feedkeys(prefix, 'n')
  endif
  call feedkeys(substitute(a:map, '^<Plug>', "\<Plug>", '') . extra)
endfunction

function! s:plugin_list(...)
  call s:init_minpac()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

function! s:setup_command()
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

function! s:init_minpac()
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
  catch e
    echohl WarningMsg
    echom '[plugpac] Skipping minpac installation. Plugins will not be installed'
    " TODO rethrow e
    echohl None
  endtry

endfunction