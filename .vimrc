syntax on

set visualbell
set tabstop=4 softtabstop=4
set expandtab
set smartindent
set shiftwidth=4
set number
set relativenumber
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
"lsp plugins"
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'mbbill/undotree'

call plug#end()

colorscheme gruvbox
set background=dark

let mapleader=" "
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j    
nnoremap <Leader>k <C-w>k    
nnoremap <Leader>l <C-w>l    
nnoremap <Leader>H <C-w>h
nnoremap <Leader>J <C-w>j    
nnoremap <Leader>K <C-w>k    
nnoremap <Leader>L <C-w>l    
inoremap <C-c> <Esc>
tnoremap <Esc> <C-\><C-n>

noremap <Leader>e :call ToggleNetrw()<CR>
"netrw will be the 25% of the screen"
let g:netrw_winsize = 25
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
