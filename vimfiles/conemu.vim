"
" ConEmu.vim
" General fixes and other things to make Vim 
" play nice with Windows and ConEmu
"

if !empty($CONEMUBUILD)
    
    " Fix to properly display symbols in ConEmu
    " on Windows
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"

    " Fix to make Backspace function normally
    " in ConEmu on Windows
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
endif
