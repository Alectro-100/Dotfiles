call plug#begin('/usr/share/nvim/NVIM')

    Plug 'rust-lang/rust.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-commentary'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Plug 'puremourning/vimspector'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tomasr/molokai'

call plug#end()

colorscheme molokai
syntax enable
set relativenumber
set guicursor=n-v-c-sm:block
set signcolumn=no
set termguicolors
set shiftwidth=4
set expandtab
set tabstop=4
set number
filetype plugin indent on

command! RunCpp w | !gcc -x c++ -pedantic -std=c++20 -lstdc++ -fno-elide-constructors -Wall -Wextra -O0 "%" -o "%:r" && ./"%:r" ; rm ."/%:r"
command! RunC w | !gcc -pedantic -Wall -Wextra -O0 "%" -o "%:r" && ./"%:r" ; rm ./"%:r"
command! InstallPlug call InstallPlug()

let mapleader = '\'

nnoremap <silent><leader>t :tabnew<CR>
nnoremap <silent><leader>n :tabNext<CR>
nnoremap <silent><leader>q :tabclose<CR>

nnoremap <silent><A-k> :move .-2 <CR>==
vnoremap <silent><A-k> :move '<-2 <CR>gv=gv
inoremap <silent><A-k> <ESC>:move .-2<CR>==gi

nnoremap <silent><A-j> :move .+1 <CR>==
vnoremap <silent><A-j> :move '>+1 <CR>gv=gv
inoremap <silent><A-j> <ESC>:move .+1<CR>==gi

" Force F1 to do nothing
nnoremap <silent> <F1> <Nop>
inoremap <silent> <F1> <Nop>
vnoremap <silent> <F1> <Nop>

nnoremap <silent><S-CR> :normal! o <CR>
nnoremap <silent><C-S-CR> :normal! O <CR>
nnoremap <silent><C-n> :Telescope find_files <CR>
nnoremap <silent><C-Space> :NERDTreeToggle<CR>
nnoremap <silent><F2> <CMD>if &wrap <BAR> set nowrap <CR> <BAR> else <BAR> set wrap <CR> <BAR> endif <CR><CR>
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:vimspector_enable_mappings = 'HUMAN'

function! InstallPlug()
    call system('curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endfunction

