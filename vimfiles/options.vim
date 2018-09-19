"
" Options.vim
"

set nocompatible

" When opening a new file, if you have unsaved changes,
" there are no prompts, instead it saves the changed buffers
" silently, NOT the files
set hidden

" Backspace behaviour
set backspace=indent,eol,start

" Set line numbering
set nu

" Set automatic indentation
set ai

" Set syntax highlighting
syntax on

" Set size of an indentation
set sw=4

" Do incremental searches
set incsearch

" Highlight search results
set hlsearch

" Enable smart-indent
set smartindent

" Enable smart-tabs
set smarttab

" Highlights matching braces
set showmatch

" Number of spaces per tab
set softtabstop=4

" Use spaces instead of tabs
set expandtab

" Airline and Airline Theme Config
set laststatus=2
set ttimeoutlen=50

" Load Global YCM Extra Conf
let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'

set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.

