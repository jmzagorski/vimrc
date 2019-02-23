let $MYVIMRCPATH=fnamemodify($MYVIMRC, ':h')
set nocompatible

augroup vimrc
  autocmd!
augroup END

source $MYVIMRCPATH/rc/general.vim
source $MYVIMRCPATH/rc/mappings.vim
source $MYVIMRCPATH/rc/ui.vim
source $MYVIMRCPATH/rc/plugins.vim
