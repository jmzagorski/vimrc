Plugin 'mattn/emmet-vim'

let g:user_emmet_leader_key = '<C-e>'

" get the current line under the cursor
" match the regex and then expand it with emmet or jump to the next
function! s:zen_html_tab() abort
	let line = getline('.')
	if match(line, '<.*>') < 0
		return "\<c-e>,"
	endif
	return "\<c-e>n"
endfunction

autocmd vimrc FileType html,cjsx,jsx,rs imap <buffer><expr><tab> <sid>zen_html_tab()
