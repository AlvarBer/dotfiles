" Colors
" peachpuff, molokai, ron
colorscheme peachpuff                  " Pretty good coloring

syntax enable                          " Enable syntax processing

" Tabs/Spaces
set tabstop=4                          " Visual Spaces per tabs
set softtabstop=4                      " Number of spaces when editing

set number                             " Line numbers on the side

"set cursorline                        " Highlight current line

filetype indent on                     " Load filetype-specific indent files

set wildmenu                           " Visual autocomplete for command menu

set lazyredraw                         " Redraw only when we need to

set showmatch                          " Highlight matching [{()}]

" Search 
set incsearch                          " Search as characters are entered
set hlsearch                           " Highlight matches

" Turn off search highlight with space
nnoremap <leader><space> :nohlsearch<CR>

" Folds
set foldenable                         " Enable folding
set foldlevelstart=10                  " open most folds by default

set foldnestmax=10                     " 10 nested fold max

" Space open/closes folds
nnoremap <space> za

" Key mapping
let mapleader=","                      " Leader key is the comma

