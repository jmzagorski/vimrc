" continuously updated session files
Plugin 'tpope/vim-obsession'

" plugin might not be downloaded yet
setglobal statusline+=\ %{(exists('*ObsessionStatus')?ObsessionStatus():'')}

if has("unix")
  let g:vimrc_session_path = $MYVIMRCPATH . '/sessions'
else
  let g:vimrc_session_path = $LOCALAPPDATA . '/vim/sessions'
endif

let g:vimrc_default_session_name = 'Session'

" global do no play well with packadd
if match(&sessionoptions, 'globals') != -1
  setglobal sessionoptions-=globals
endif

" Makes a session based on the current working directory
command! -bang -bar -nargs=? MakeSession execute vimrc#make_session(<bang>0, <q-args>, 'Obsession')
command! -bang -bar -nargs=? OpenSession execute vimrc#make_session(<bang>0, <q-args>, 'source')
command! -bang -bar -nargs=+ OpenProject execute vimrc#open_project(<bang>0, <q-args>)

" auto loads a sesssion if found for current working dir
autocmd vimrc VimEnter * nested
      \ if !argc() && empty(v:this_session) && filereadable(vimrc#get_session_name()) |
      \   execute printf('source %s', fnameescape(vimrc#get_session_name())) |
      \ endif
