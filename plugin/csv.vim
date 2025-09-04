Plugin 'chrisbra/csv.vim'

let g:csv_nl = 1
let b:csv_headerline = 1
let g:csv_delim=','

autocmd vimrc Filetype csv call HighlightColumn(&diff)

function! HighlightColumn(diff)
    if a:diff
        if exists('g:csv_highlight_column')
		  unlet g:csv_highlight_column
        endif
    else
        if !exists('g:csv_highlight_column')
		  let g:csv_highlight_column = 'y'
        endif
    endif

endfunction
