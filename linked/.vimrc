" Álvaro Bermejo .vimrc
" Minimal & functional

" Visuals {{{
syntax enable                         " Enable syntax processing

" peachpuff, molokai, badwolf
colorscheme badwolf                   " Pretty good coloring

set number                            " Line numbers on the side
set so=7                              " Lines cursor uses as offset when moving
"set cursorline                       " Highlight current line
"}}}

" Indentation {{{
set tabstop=4                          " Visual Spaces per tabs
set softtabstop=4                      " Number of spaces when editing
set shiftwidth=4                       " Defines what an indentation level is

filetype indent on                     " Load filetype-specific indent files
" }}}

" Key Mapping {{{
let mapleader="-"                      " Leader key is the minus sign

" Vertical move by visual line
nnoremap <up> gk
nnoremap <down> gj

" Move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ won't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]
"}}} 

" Search {{{
set incsearch                          " Search as characters are entered
set hlsearch                           " Highlight matches
set ignorecase                         " Ignore case when searching
set smartcase                          " Pattern having uppercase won't ignore

" Turn off search highlight with space
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Fold {{{
set foldenable                         " Enable folding
set foldlevelstart=10                  " open most folds by default
set foldnestmax=10                     " 10 nested fold max
set foldmethod=indent                  " fold based on indent level

" Space open/closes folds
nnoremap <space> za
" }}}

" Others {{{
set modeline                          " This allows us to set files for this
set modelines=1                       " specific file
set encoding=utf8                     " Set utf8 as standard encoding (en_US)
" }}}

" vim:foldmethod=marker:foldlevel=0
