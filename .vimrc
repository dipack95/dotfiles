" Vim-Plug configuration
call plug#begin('~/.vim/plugged')
" Plugins
Plug 'valloric/youcompleteme'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
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

" Setting colorscheme
colorscheme 256-grayvim

" Start NerdTree on Startup
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline and Airline Theme Config
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='cool'

" Gvimrc settings
if has("gui_running")
    set guifont=Menlo\ 10
endif
