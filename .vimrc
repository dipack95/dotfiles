call plug#begin('~/.vim/plugged')
" Plugins
Plug 'valloric/youcompleteme'
Plug 'davidhalter/jedi-vim'
call plug#end()
set nocompatible
set hidden
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
