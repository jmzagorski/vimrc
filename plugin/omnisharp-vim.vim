Plugin 'nickspoons/omnisharp-vim', { 'type': 'opt', 'branch': 'highlight-syn-options' }

" OmniSharp won't work without this setting
filetype plugin on

let wsldir = expand('/mnt/c/Users/$USERNAME/.omnisharp/omnisharp-roslyn/')

if isdirectory(wsldir)
  let g:OmniSharp_server_path = wsldir . 'OmniSharp.exe'
  let g:OmniSharp_translate_cygwin_wsl = 1
endif

let g:OmniSharp_server_type = 'roslyn'
" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5
let g:Omnisharp_stop_server = 1  " Ask whether to stop the server on exit
" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5
let g:OmniSharp_want_snippet=1

" Contextual code actions (requires fzf, CtrlP or unite.vim)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <Leader>rl :OmniSharpReloadSolution<CR>
nnoremap <Leader>cf :OmniSharpCodeFormat<CR>
" Load the current .cs file to the nearest project
nnoremap <Leader>tp :OmniSharpAddToProject<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>rs :OmniSharpRestartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

" Enable snippet completion, requires completeopt-=preview
let g:OmniSharp_want_snippet=1