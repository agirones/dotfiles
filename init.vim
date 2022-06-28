"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc
"call plug#begin('~/.vim/plugged')
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
"Plug 'nvim-lua/plenary.nvim'
"call plug#end()


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

" wrap text for text files
autocmd Filetype tex set wrap linebreak 
autocmd Filetype text set wrap linebreak 

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

"lsp plugins"
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" For ultisnips user.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

"For snips 
Plug 'sirver/ultisnips'

"Latex integration
Plug 'lervag/vimtex'

Plug 'mbbill/undotree'

"Fuzzy finder telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()
lua require'lspconfig'.pyright.setup{capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())}
set completeopt=menu,menuone,noselect

colorscheme gruvbox
set background=dark

"vimtex concealment
set conceallevel=1
let g:tex_conceal='abdmg'

"snippets configuration
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/ultisnips/mysnippets']

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
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

"makes okular the pdf viewer for vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })
EOF

lua << EOF
require('telescope').setup{
  defaults = {
    -- ...
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    }
  },
  extensions = {
    -- ...
  }
}
EOF
