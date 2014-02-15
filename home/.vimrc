" basics
set expandtab       " expand tabs
set tabstop=4       " tab size 4
set shiftwidth=4
set softtabstop=4
set shiftround
set smarttab
set smartindent
set cindent
set number          " line numbers
set nocompatible
set nowrap
set encoding=utf-8
set nofoldenable    " no folding
set ruler
set virtualedit=block
set noshowmode
set backspace=indent,eol,start
set complete-=i
set scrolloff=2
set sidescrolloff=10
set incsearch
set hlsearch
set display+=lastline
set autoread        " read files modified outside
set showmatch       " show matching brackets
set matchtime=2
set undofile        " persistent undo
set nostartofline
set ttyfast
set t_Co=256
syntax on


" temp directories
set undodir=$HOME/.vim/undo
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap


" keybinds
set pastetoggle=<f3>
map <f2> :NERDTreeToggle<cr>
map <f5> :GundoToggle<cr>
map <f4> :IndentGuidesToggle<cr>
map <silent> <f7> <esc> :w<cr> <esc> :!./%<cr>


" ui changes
set cursorline
set laststatus=2


" bundles
" -------

" vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'


" NERDtree - directory browsing
Bundle 'scrooloose/nerdtree'


" syntastic - syntax checker
Bundle 'scrooloose/syntastic'


" solarized - color theme
Bundle 'altercation/vim-colors-solarized'
set background=light
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized

if has("gui_running")
    set mousefocus
endif


" indent guides
Bundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors=1
let g:indent_guides_space_guide=1
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=30
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes=['help', 'nerdtree']


" fugitive - git integration
Bundle 'tpope/vim-fugitive'


" airline - status bar
Bundle 'bling/vim-airline'
let g:airline_powerline_fonts=1


" delimitMate - matches brackers, ...
Bundle 'Raimondi/delimitMate'


" gundo - easy undo
Bundle 'sjl/gundo.vim'


" required by vundle
filetype plugin on
filetype indent on


" auto reload .vimrc
"autocmd BufWritePost  ~/.vimrc source ~/.vimrc


" auto overrides
command! Q q
command! W w
