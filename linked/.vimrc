" Álvaro Bermejo .vimrc
" Minimal & functional

" Visuals {{{
syntax enable                         " Enable syntax processing

" peachpuff, molokai, badwolf
colorscheme badwolf                   " Pretty good colouring

set number                            " Line numbers on the side
set so=7                              " Lines cursor uses as offset when moving
set ruler
set rulerformat=%l,%c                 " Show line,col number on ruler
set showcmd                           " Show last command
"set cursorline                       " Highlight current line
set wildmenu                          " visual auto complete for command menu
set showmatch                         " highlight matching [{()}]
"}}}

" Indentation {{{
set tabstop=4                          " Visual Spaces per tab
set softtabstop=4                      " Number of spaces inserted when editing
set shiftwidth=4                       " Defines what an indentation level is

filetype indent on                     " Load file type specific indent files
"}}}

" Key Mapping {{{
let mapleader = "-"                    " Leader key is the minus sign
let maplocalleader = "--"

" Vertical move by visual line
nnoremap <up> gk
nnoremap <down> gj

" Move to beginning/end of line
noremap B ^
noremap E $

" Spell check with S, suggestions with s
noremap S :set spell spelllang=en_gb<cr>
noremap s z=
noremap <leader>s zg
noremap <leader>S :set nospell<cr>

" Open NerdTree with q
noremap q :NERDTree<cr>

" $/^ won't do anything
noremap $ <nop>
noremap ^ <nop>
noremap -- <nop>
"}}} 

" Search {{{
set incsearch                          " Search as characters are entered
set hlsearch                           " Highlight matches
set ignorecase                         " Ignore case when searching
set smartcase                          " Pattern having upper-case won't ignore

" Turn off search highlight with space
nnoremap <leader><space> :nohlsearch<CR>
"}}}

" Folds {{{
set foldenable                         " Enable folding
set foldlevelstart=10                  " open most folds by default
set foldnestmax=10                     " 10 nested fold max
set foldmethod=indent                  " fold based on indent level

" Space open/closes folds
nnoremap <space> za
"}}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

call plug#end()
"}}}

" Others {{{
set modeline                          " This allows us to set files for this
set modelines=1                       " specific file
set encoding=utf8                     " Set utf8 as standard encoding (en_US)
"}}}

" vim:foldmethod=marker:foldlevel=0
