" Naïve autoload of packs
" See https://github.com/k-takata/minpac/issues/28
" And https://github.com/junegunn/vim-plug/blob/9813d5e/plug.vim#L271-L276

let s:dir = $MYVIMRCPATH . '/pack/minpac/opt/minpac'

" custom Plugin wrapper in case i switch out managers
command! -nargs=+ -bar Plugin call minpac#add(<args>) | call minautopac#add(<args>)
command! -nargs=? -bar PackUpdate call minpac#update(<args>)
command! PackClean call minpac#clean()

if !isdirectory(s:dir)
  silent! call mkdir(s:dir, 'p')
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', s:dir)
end

packadd minpac

if !exists('*minpac#init')
  echohl WarningMsg
  echom 'Skipping minpac setup. minpac package manager is not installed.'
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

runtime! OPT ftdetect/**/*.vim
runtime! OPT after/ftdetect/**/*.vim
runtime! rc/plugins/*.vim
