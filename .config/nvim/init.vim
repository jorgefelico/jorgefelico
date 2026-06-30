" Plugins
call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Core Completion Engine
Plug 'hrsh7th/nvim-cmp'

" Completion Sources
Plug 'hrsh7th/cmp-nvim-lsp'   " LSP completions
Plug 'hrsh7th/cmp-buffer'     " Text from current buffer
Plug 'hrsh7th/cmp-path'       " File system paths

" Snippet Engine (Required by nvim-cmp to function)
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Optional: Built-in LSP support to feed the completion
Plug 'neovim/nvim-lspconfig'
filetype plugin indent on

call plug#end()

lua << EOF
-- Set completeopt for a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Handles code snippets
    end,
  },
  mapping = {
    -- Use Ctrl + j to move DOWN the autocomplete list
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Use Ctrl + k to move UP the autocomplete list
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Scroll documentation windows
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    -- Cancel/close the popup window
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    -- Confirm selection with Enter
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
  }, 
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Language Server suggestions
    { name = 'vsnip' },    -- Snippets
  }, {
    { name = 'buffer' },   -- Text inside current file
    { name = 'path' },     -- Directory/file paths
  })
})

-- Advertise nvim-cmp capabilities to your language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 1. Pass your nvim-cmp capabilities to the native config layer
vim.lsp.config('*', {
  capabilities = capabilities
})

-- 2. Enable your language servers here
vim.lsp.enable('clangd')

EOF

" Set catppuccin-mocha color scheme
colorscheme catppuccin-mocha

" My Vim Stuff
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
let g:hybrid_reduced_contrast = 1
let g:hybrid_custom_term_colors = 1

map <C-n> :NERDTreeToggle<CR>
set number

" Set Proper Tabs
set tabstop=4
set shiftwidth=4

set t_Co=256

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
