" ================ General Setting ==================
set nocompatible             " get rid of Vi compatibility mode
set exrc                     " allow per project vim conf.
set secure                   " but, be secure on it
filetype plugin indent on    " filetype detection[ON] plugin[ON] indent[ON]
syntax enable                " enable syntax highlighting (previously syntax on).
set number                   " show line numbers
set nowrap                   " do not wrap lines
set cursorline               " show cursor lines
set clipboard=unnamed        " for macOS Sierra, solve clippboard error when used with 'tmux' 
set noswapfile               " do not make swap files
set hidden                   " keep the changed buffer without saving
set title                    " set the terminal title
set laststatus=2             " last window always has a statusline
set ruler                    " show me where i am
set visualbell               " do not bother my coworkers
" ================ Search ===========================
set ignorecase               " case-insensitive search
set smartcase                " only if upper-case character NOT exists
set nohlsearch               " don't continue to highlight searched phrases.
set incsearch                " but do highlight as you type your search.
" ================ Indentation ======================
set expandtab                " use spaces instead of tabs
" ================ Scrolling ========================
set scrolloff=8              " start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" ================ Appearance =======================
set t_Co=256                 " enable 256-color mode.
set list listchars=tab:\ \ ,trail:·
" ================ Etc... ===========================
set history=1000             " remember more
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*~  " stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif
set shortmess=atI
" ================ Key mapping ======================
let mapleader=","            " change leader key. this have to be set before plugins
" swap 'goto' marked position key between 'current file' and 'global'
nnoremap ' `
nnoremap ` '
" ================ Platform Specifics ===============
if has('gui_running')        " gvim
  colorscheme desert
else
  colorscheme desert
end
let OS=substitute(system('uname -s'),"\n","","")
if (OS == "Darwin")
    " do something that only makes sense on a Mac
endif
" ================ Plugins ==========================
" specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'sheerun/vim-polyglot'  " Syntax highlighting
" Add plugins to &runtimepath
call plug#end()
