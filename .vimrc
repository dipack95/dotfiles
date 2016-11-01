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

" Setting terminal colors to 256
" set t_Co=256
" Setting colorscheme
colorscheme badwolf 

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

" Start NerdTree on Startup
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline and Airline Theme Config
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='badwolf'

" Gvimrc settings
if has("gui_running")
    set guifont=Menlo\ 10
endif
