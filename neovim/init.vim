" Plugin manager (vim-plug)
call plug#begin('/usr/share/nvim/NVIM')
    " Rust syntax and highlighting support
    Plug 'rust-lang/rust.vim'
    " Auto-completion, diagnostics, and more
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Easy commenting of code
    Plug 'tpope/vim-commentary'
    " Enhanced C++ syntax highlighting
    Plug 'octol/vim-cpp-enhanced-highlight'
    " File explorer sidebar
    Plug 'preservim/nerdtree'
    " Status line plugin for a more beautiful interface
    Plug 'vim-airline/vim-airline'
    " Utility library for Lua plugins
    Plug 'nvim-lua/plenary.nvim'
    " Fuzzy finder for files, buffers, etc.
    Plug 'nvim-telescope/telescope.nvim'
    " Debugging with vimspector
    " Plug 'puremourning/vimspector'
    " Molokai colorscheme
    Plug 'tomasr/molokai'
    " gruvbox colorscheme
    Plug 'morhetz/gruvbox'
    " nightwolf colorscheme
    Plug 'ricardoraposo/nightwolf.nvim'

call plug#end()

" Set color scheme to
colorscheme gruvbox
" Enable syntax highlighting
syntax enable
" Set tab width to 4 spaces
set tabstop=4
" Set the shift width for indentation
set shiftwidth=4
" Use spaces instead of tabs
set expandtab
" Enable line numbering
set number
" Set relative line numbers
set relativenumber
" Set cursor style for different modes (Normal, Visual, etc.)
set guicursor=n-v-c-sm:block
" Disable sign column (useful for reducing screen clutter)
set signcolumn=no
" Enable 24-bit RGB color support for terminals
set termguicolors
" Set mouse to insert mode
set mouse=i
" Enable cursorline (optional)
set cursorline
" Enable filetype-specific plugins and indentation
filetype plugin indent on

" Enable swap files (saves the cursor position and other information)
set swapfile
" Enable shada (persistent history and cursor position saving)
set shada='1000,f0,h
" Automatically jump to the last cursor position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\" | zz" | endif
autocmd BufRead,BufNewFile *.conf set filetype=dosini


" Custom commands for compiling and running C/C++ code
command! RunCpp w | !gcc -x c++ -pedantic -std=c++20 -lstdc++ -fno-elide-constructors -Wall -Wextra -O0 "%" -o "%:r" && ./"%:r" ; rm ."/%:r"
command! RunC w | !gcc -pedantic -Wall -Wextra -O0 "%" -o "%:r" && ./"%:r" ; rm ./"%:r"

" Install vim-plug (plugin manager)
command! InstallPlug call InstallPlug()

let mapleader = '\'

" Open new tab, switch to next tab, and close current tab
nnoremap <silent><leader>t :tabnew<CR>
nnoremap <silent><leader>n :tabmove<CR>
nnoremap <silent><leader>p :tabprevious<CR>
nnoremap <silent><leader>q :tabclose<CR>

" Move lines up/down in normal, visual, and insert modes
nnoremap <silent><A-j> :move .+1 <CR>==
vnoremap <silent><A-j> :move '>+1 <CR>gv=gv
inoremap <silent><A-j> <ESC>:move .+1 <CR>==gi

nnoremap <silent><A-k> :move .-2 <CR>==
vnoremap <silent><A-k> :move '<-2 <CR>gv=gv
inoremap <silent><A-k> <ESC>:move .-2 <CR>==gi

" Disable F1 key (bind to no operation)
nnoremap <silent> <F1> <Nop>
inoremap <silent> <F1> <Nop>
vnoremap <silent> <F1> <Nop>

" Create new line below (Shift + Enter)
nnoremap <silent><S-CR> :normal! o <CR>
" Create new line above (Ctrl + Shift + Enter)
nnoremap <silent><C-S-CR> :normal! O <CR>
" Open Telescope file search
nnoremap <silent><C-n> :Telescope find_files <CR>
" Toggle NerdTree with Ctrl + Space
nnoremap <silent><C-Space> :NERDTreeToggle<CR>
" Toggle wrap and nowrap with F2

" Toggle wrap and nowrap with F2
nnoremap <silent><F2> :call ToggleWrap() <CR>
" call ToggleWrap()
command! ToggleWrap :call ToggleWrap()

" Confirm Coc completion (when pop-up menu is visible) in insert mode
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:vimspector_enable_mappings = 'HUMAN'

function! InstallPlug()
    call system('curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endfunction

function! ToggleWrap()
    if &wrap
        set nowrap
    else
        set wrap
    endif
endfunction

