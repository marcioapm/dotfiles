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


" write temp files in /tmp
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//


" keybinds
set pastetoggle=<f3>
map <silent> <f7> <esc> :w<cr> <esc> :!./%<cr>
vmap <tab> >gv
vmap <s-tab> <gv
nmap <tab> >>
nmap <s-tab> <<


" ui changes
set cursorline
set laststatus=2

if has("gui_running")
  set mousefocus
endif


" remove trailing white spaces on save
au BufWritePre * %s/\s\+$//e
