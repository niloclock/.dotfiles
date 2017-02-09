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
""set cursorline             " show cursor lines
if exists ('$TMUX')
  set clipboard=unnamed      " for macOS Sierra, solve clippboard error when used with 'tmux' 
else
  set clipboard=unnamed
endif
if s:is_windows && !s:is_cygwin
  set shell=c:\windows\system32\cmd.exe
endif
set mouse=a                  " enable mouse
set mousehide                " hide when typed
set noswapfile               " do not make swap files
set hidden                   " keep the changed buffer without saving
set fileformats+=mac         " add mac to auto-detection of file format line endings
set laststatus=2             " last window always has a statusline
""set ruler                    " show me where i am (comment out. vim-airline override this)
set visualbell               " do not bother my coworkers
""set tags+=~/.tags/**/tags    " my all tag files are placed in ~/.tags/.. <-- reflect real path
" neovim specific -----------------------------------
if has('nvim')
  set termguicolors          " make more colorful
endif
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
autocmd FileType python setl ts=4 sts=4 sw=4
autocmd FileType rust setl ts=4 sts=4 sw=4
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
set shortmess=ato
" completion menu
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" ================ Key mapping ======================
let mapleader=","            " change leader key. this have to be set before plugins
" swap 'goto' marked position key between 'current file' and 'global'
nnoremap ' `
nnoremap ` '
" search for visually selected text.
vnoremap // y/<C-R>"<CR>
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
" ================ Platform Specifics ===============
if has('gui_running')        " gvim
  colorscheme desert
else
""colorscheme desert
end
" ================ Functions ========================
function! s:get_path_if_exists(bin)
  echom "Finding path for ".a:bin
  if !executable(a:bin)
    return ""
  endif
  let l:bin_path = system("which ".a:bin)
  return l:bin_path
endfunction
" ================ Plugins ==========================
" specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" START vim-plug {{{
call plug#begin('~/.config/nvim/plugged')
" }}}
" Make sure you use single quotes
" Add plugins to &runtimepath
" CORE plugins {{{
  Plug 'Shougo/denite.nvim'
  Plug 'bling/vim-airline'
  Plug 'benekastah/neomake', { 'for': ['rust'] }
" }}}
" SCM {{{
  Plug 'tpope/vim-fugitive'
" }}}
" SYNTAX HIGHLIGHTING {{{
  "Plug 'scrooloose/syntastic'
  Plug 'sheerun/vim-polyglot'
" }}}
" LANGUAGE SUPPORTS {{{
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
  " Use mckinnsb's fork of rust.vim to solve syntastics error
  " When the rust.vim fix that, get back to offical
  " Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'mckinnsb/rust.vim', { 'for': 'rust' }
" }}}
" FINISH vim-plug {{{
call plug#end()
" }}}
" Plugin setting {{{
  " Plug 'Shougo/denite.nvim' {{{
    " Key bindings
    nnoremap <C-p> :Denite file_rec<CR>
    nnoremap <leader><C-p> :Denite buffer<CR>
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
  " }}}
  " Plug 'bling/vim-airline' {{{
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#left_sep=' '
    let g:airline#extensions#tabline#left_alt_sep='¦'
    let g:airline#extensions#tabline#buffer_idx_mode=1
    let g:airline#extensions#neomake#enabled=1
  " }}}
  " Plug 'tpope/vim-fugitive' {{{
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
  " Plug 'racer-rust/vim-racer' {{{
    let g:racer_cmd = "~/.cargo/bin/racer"
    let g:racer_experimental_completer = 1
    autocmd FileType rust nmap gd <Plug>(rust-def)
    autocmd FileType rust nmap gs <Plug>(rust-def-split)
    autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
    autocmd FileType rust nmap gm <Plug>(rust-doc)
  " }}}
  " Plug 'rust-lang/rust.vim' {{{
  let g:rustfmt_autosave = 1
  " }}}
" }}}
" autocmd {{{
augroup aug4u
  " clear up
  autocmd!
  " common {{{
  " go back to previous position of cursor if any
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe 'normal! g`"zvzz' |
    \ endif
  " }}}
  " vim {{{
  autocmd FileType vim setlocal fdm=indent keywordprg=:help
  " }}}
  " python {{{
  autocmd FileType python setlocal foldmethod=indent
  " }}}
  " rust {{{
  " rusty-tags
  autocmd BufRead *.rs setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
  autocmd BufWrite *.rs silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&"
  " neomake
  autocmd BufRead,BufWrite *.rs Neomake! cargo
  " }}}
augroup END
" }}}
filetype plugin indent on    " filetype detection[ON] plugin[ON] indent[ON]
syntax enable                " enable syntax highlighting (previously syntax on).
