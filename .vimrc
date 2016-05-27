filetype off
" Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugins
Plugin 'davidhalter/jedi-vim'
Plugin 'Valloric/YouCompleteMe'
" End Plugins
call vundle#end()
filetype plugin indent on

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
