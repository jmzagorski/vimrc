if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

if &runtimepath !~# 'omnisharp-vim'
  packadd omnisharp-vim
endif

if &runtimepath !~# 'vim-csharp'
  packadd vim-csharp
endif

" Show type information automatically when the cursor stops moving
autocmd vimrc CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

" The following commands are contextual, based on the cursor position.
nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> <LocalLeader>fi :OmniSharpFindImplementations<CR>
nnoremap <buffer> <LocalLeader>ft :OmniSharpFindType<CR>
nnoremap <buffer> <LocalLeader>fs :OmniSharpFindSymbol<CR>
nnoremap <buffer> <LocalLeader>fu :OmniSharpFindUsages<CR>

" Finds members in the current buffer
nnoremap <buffer> <LocalLeader>fm :OmniSharpFindMembers<CR>

" Cursor can be anywhere on the line containing an issue
nnoremap <buffer> <LocalLeader>x  :OmniSharpFixIssue<CR>
nnoremap <buffer> <LocalLeader>fx :OmniSharpFixUsings<CR>
nnoremap <buffer> <LocalLeader>tt :OmniSharpTypeLookup<CR>
nnoremap <buffer> <LocalLeader>dc :OmniSharpDocumentation<CR>

" Navigate up and down by method/property/field
nnoremap <buffer> <LocalLeader>k :OmniSharpNavigateUp<CR>
nnoremap <buffer> <LocalLeader>j :OmniSharpNavigateDown<CR>
