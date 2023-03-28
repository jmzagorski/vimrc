Plugin 'OmniSharp/omnisharp-vim'

let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_loglevel = 'debug'

if has('patch-8.1.1880')
  setglobal completeopt=longest,menuone,popuphidden
  setglobal completepopup=highlight:Pmenu,border:off
else
  setglobal completeopt=longest,menuone,preview
  setglobal previewheight=5
endif

let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_timeout = 5
" Ask whether to stop the server on exit
let g:Omnisharp_stop_server = 1
let g:OmniSharp_diagnostic_showid = 1

let g:OmniSharp_diagnostic_exclude_paths = [
\ 'bin\\',
\ 'obj\\',
\ '[Tt]emp\\',
\ '\.nuget\\',
\ '\<AssemblyInfo\.cs\>'
\]

augroup vimrc_omnisharp_commands
  autocmd!

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> t<C-f> :OmniSharpRunTestsInFile<CR>
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>fu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>fi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>pd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>pi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>tl <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>dc <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>fs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>fx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>cf <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>nm <Plug>(omnisharp_rename)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>gcc <Plug>(omnisharp_global_code_check)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>ca <Plug>(omnisharp_code_actions)
  autocmd FileType cs nmap <silent> <buffer> <LocalLeader>ca. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs nmap <silent> <buffer> <Leader>rs <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ss <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>sp <Plug>(omnisharp_stop_server)
  autocmd FileType cs noremap <buffer> ]m :OmniSharpNavigateDown<cr>
  autocmd FileType cs nnoremap <buffer> [m :OmniSharpNavigateUp<cr>
  autocmd FileType cs nnoremap <buffer> ]M :OmniSharpNavigateDown<cr>
  autocmd FileType cs nnoremap <buffer> [M :OmniSharpNavigateUp<cr>

  autocmd FileType cs xnoremap <buffer> ]m :OmniSharpNavigateDown<cr>
  autocmd FileType cs xnoremap <buffer> [m :OmniSharpNavigateUp<cr>
  autocmd FileType cs xnoremap <buffer> ]M :OmniSharpNavigateDown<cr>
  autocmd FileType cs xnoremap <buffer> [M :OmniSharpNavigateUp<cr>

  autocmd FileType cs onoremap <buffer> ]m :OmniSharpNavigateDown<cr>
  autocmd FileType cs onoremap <buffer> [m :OmniSharpNavigateUp<cr>
  autocmd FileType cs onoremap <buffer> ]M :OmniSharpNavigateDown<cr>
  autocmd FileType cs onoremap <buffer> [M :OmniSharpNavigateUp<cr>
augroup END
