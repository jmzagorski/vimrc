" Naïve autoload of packs
" See https://github.com/k-takata/minpac/issues/28
" And https://github.com/junegunn/vim-plug/blob/9813d5e/plug.vim#L271-L276

packadd minpac

if !exists('*minpac#init')
  echohl WarningMsg
  echom 'minpac package manager is not installed. Skipping minpac setup'
  echohl None
  finish
endif

" Lazy load packages that depend on file types
" XXX Some plugin use the ftplugin dir and will not work with packadd so make sure
" to not make them optional or they will not work
function! minautopac#add(repo, ...) abort
    let l:opts = get(a:000, 0, {})
    let l:name = substitute(a:repo, '^.*/', '', '')
    if has_key(l:opts, 'for')
      let l:ft = type(l:opts.for) == type([]) ? join(l:opts.for, ',') : l:opts.for
      " match it so it does not load twice for the same buffer
      execute printf('autocmd vimrc FileType %s if match(&runtimepath, "%s") == -1 | packadd %s | endif', l:ft, l:name, l:name)
    endif
endfunction

call minpac#init()

" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call minpac#add(<args>) | call minautopac#add(<args>)
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
