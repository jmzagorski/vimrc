Plugin 'Quramy/tsuquyomi', {'type': 'opt', 'for': 'typescript', 'do': '!sudo npm i -g typescript'}

let g:tsuquyomi_disable_quickfix = 1

autocmd vimrc FileType typescript nnoremap <buffer> gd :TsuDefinition<CR>
