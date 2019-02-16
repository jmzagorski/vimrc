call dein#add('scrooloose/syntastic')

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_auto_jump = 0
let g:syntastic_error_symbol = "xx"
let g:syntastic_warning_symbol = "∆∆"
let g:syntastic_style_error_symbol = '☠☠'
let g:syntastic_style_warning_symbol = '!?'
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_sql_checkers = ['tsqllint']
nmap <leader>sc :SyntasticCheck<CR>

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
hi SpellBad term=reverse ctermbg=darkgreen
