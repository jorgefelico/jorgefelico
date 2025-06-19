" Plugins
call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

" Set catppuccin-mocha color scheme
colorscheme catppuccin-mocha

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
