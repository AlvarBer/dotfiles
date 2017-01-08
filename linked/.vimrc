" Álvaro Bermejo .vimrc
" Minimal & functional

set nocompatible                       " Allows all kinds of shenanigans

" Visuals {{{
syntax enable                         " Enable syntax processing

let c_syntax_for_h = 1                " C syntax for .h files
" peachpuff, molokai, badwolf
colorscheme molokai                   " Pretty good colouring

set number                            " Line numbers on the side
set so=7                              " Lines cursor uses as offset when moving

set laststatus=2                      " Powerline

set showcmd                           " Show last command
"set cursorline                       " Highlight current line
set wildmenu                          " visual auto complete for command menu
set showmatch                         " highlight matching [{()}]

set nowrap                            " Don't warp text around
"}}}

" Indentation {{{
set tabstop=4                          " Visual Spaces per tab
set softtabstop=4                      " Number of spaces inserted when editing
set shiftwidth=4                       " Defines what an indentation level is
set smarttab                           " Tab for indent, space for alignment

filetype indent on                     " Load file type specific indent files
"}}}

" Key Mapping {{{
set mouse=                             " Disable mouse

let mapleader = "-"                    " Leader key is the minus sign
let maplocalleader = "--"              " Local leader is twice the leader

" Vertical move by visual line
nnoremap <up> gk
nnoremap <down> gj

" Move to beginning/end of line
noremap B ^
noremap E $

" Toggle Spell check with S, suggestions with s
" First :set spell spelllang=en_gb
noremap S :set spell!<cr>
noremap s z=

" Add word with <leader>s
noremap <leader>s zg

" Open NerdTree with q
noremap q :NERDTreeToggle<cr>

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

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " File browser
Plug 'vim-airline/vim-airline'         " Powerline
let g:airline_powerline_fonts = 1      " Powerline symbols
Plug 'vim-airline/vim-airline-themes'  " Powerline themes
let g:airline_theme='powerlineish'     " Powerlinish look
Plug 'vim-scripts/TagHighlight'        " Tag highlighting
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' " Automatic Tags
let g:easy_tags_by_filetype=1          " Tags by filetype
let g:easy_tags_async = 1              " Asynchronous tagging
let g:easy_tags_events = ['BufWritePost', 'CursorHold', 'CursorHoldI']

call plug#end()
"}}}

" Others {{{
set modeline                          " This allows us to set files for this
set modelines=1                       " specific file
set encoding=utf8                     " Set utf8 as standard encoding (en_US)
"}}}

" vim:foldmethod=marker:foldlevel=0
