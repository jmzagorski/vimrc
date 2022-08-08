Plugin 'vimwiki/vimwiki'

nnoremap <C--> <Plug>VimwikiRemoveHeaderLevel

let g:vimwiki_auto_header=1
let g:vimwiki_toc_header = 'README'

let g:vimwiki_list = [{'path': '~/projects/oesapps/presentations',
      \ 'syntax': 'markdown', 'ext': '.slide'}]
