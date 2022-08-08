" load slides specific syntax

if filereadable("syntax.vim")
  source syntax.vim
elseif filereadable("../syntax.vim")
  source ../syntax.vim
endif
