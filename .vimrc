" ================ General Setting ==================
" Detect OS {{{
  let s:OS = substitute(system('uname -s'),"\n","","")
  let s:is_mac = (s:OS == "Darwin")
  let s:is_macvim = has('gui_macvim')
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
" }}}
set nocompatible             " get rid of Vi compatibility mode
set exrc                     " allow per project vim conf.
set secure                   " but, be secure on it
set title                    " set the terminal title
set number                   " show line numbers
set nowrap                   " do not wrap lines
set cursorline               " show cursor lines
if exists ('$TMUX')
  set clipboard=unnamed      " for macOS Sierra, solve clippboard error when used with 'tmux' 
else
  set clipboard=
endif
if s:is_windows && !s:is_cygwin
  set shell=c:\windows\system32\cmd.exe
endif
set mouse=a                  " enable mouse
set mousehide                " hide when typed
set noswapfile               " do not make swap files
set hidden                   " keep the changed buffer without saving
set laststatus=2             " last window always has a statusline
set ruler                    " show me where i am
set visualbell               " do not bother my coworkers
" ================ Search ===========================
set ignorecase               " case-insensitive search
set smartcase                " only if upper-case character NOT exists.
set nohlsearch               " don't continue to highlight searched phrases.
set incsearch                " but do highlight as you type your search.
" ================ Indentation ======================
" default
set expandtab                " use spaces instead of tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
" file type specific
" au FileType cpp setl ts=2 sts=2 sw=2
au FileType python setl ts=4 sts=4 sw=4
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
" search for visually selected text.
vnoremap // y/<C-R>"<CR>
" ================ Platform Specifics ===============
if has('gui_running')        " gvim
  colorscheme desert
else
  colorscheme desert
end
" ================ Plugins ==========================
" vim-plug {{{
" specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
" Plug 'sheerun/vim-polyglot'  " Syntax highlighting
" Plug 'shougo/denite.nvim'    " Dark powered asynchronous unite all interfaces for Neovim/Vim8
" Add plugins to &runtimepath
" call plug#end()
" }}}
" INIT dein {{{
  set rtp+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim
  call dein#begin(expand('~/.vim/dein/')) " plugins' root path
  call dein#add('Shougo/dein.vim')
" }}}
" CORE plugins {{{
  call dein#add('Shougo/denite.nvim') " {{{
    " Change navi. key mappings.
    call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
    call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
    " Key bindings
    nnoremap <C-p> :Denite file_rec<CR>
    nnoremap <space>s :Denite buffer<CR>
  " }}}
  call dein#add('bling/vim-airline') " {{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '¦'
    let g:airline#extensions#tabline#buffer_idx_mode = 1
  " }}}
" }}}
" SYNTAX HIGHLIGHTING {{{
  call dein#add('sheerun/vim-polyglot')
" }}}
" SCM plugins {{{
  call dein#add('tpope/vim-fugitive') " {{{
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>gr :Gremove<CR>
    autocmd BufReadPost fugitive://* set bufhidden=delete
  " }}}
" }}}
" autocmd {{{
  " go back to previous position of cursor if any
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe 'normal! g`"zvzz' |
    \ endif

  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType vim setlocal fdm=indent keywordprg=:help
" }}}
" FINI dein {{{
  call dein#end()
  autocmd VimEnter * call dein#call_hook('post_source')
  filetype plugin indent on    " filetype detection[ON] plugin[ON] indent[ON]
  syntax enable                " enable syntax highlighting (previously syntax on).
" }}}