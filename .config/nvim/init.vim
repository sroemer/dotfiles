"------------------------------------------------------------------------------
" plugins
"------------------------------------------------------------------------------
call plug#begin()
Plug 'tanvirtin/monokai.nvim'                                   " colorscheme
Plug 'kyazdani42/nvim-web-devicons'                             " icons - req. patched font
Plug 'tpope/vim-repeat'                                         " repeatable plugin commands
Plug 'tpope/vim-speeddating'                                    " <C-A>/<C-X> for date/times
Plug 'tversteeg/registers.nvim'                                 " show register content when accessing registers
Plug 'nvim-lua/popup.nvim'                                      " popup api - might be merged into nvim in the future
Plug 'nvim-lua/plenary.nvim'                                    " common functions used by several plugins
Plug 'windwp/nvim-autopairs'                                    " automatically add closing brackets etc.
Plug 'hoob3rt/lualine.nvim'                                     " statusline written in lua
Plug 'nvim-telescope/telescope.nvim'                            " fuzzy finder
Plug 'lewis6991/gitsigns.nvim'                                  " git decorations
Plug 'tveskag/nvim-blame-line'                                  " git blame for current line
Plug 'akinsho/nvim-toggleterm.lua'                              " terminal window
Plug 'kyazdani42/nvim-tree.lua'                                 " file explorer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     " treesitter for syntax highlight etc.
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
call plug#end()

" setup monokai colorscheme
colorscheme monokai

" show content of registers with a rounded border
let g:registers_window_border = "rounded"

" setup autopairs
lua require('nvim-autopairs').setup()

" setup lualine
lua << EOF
require('lualine').setup{
options = {
    theme = 'codedark',
    }
}
EOF

" setup gitsigns
lua require('gitsigns').setup()

" setup toggleterm
lua << EOF
require('toggleterm').setup{
open_mapping = [[<c-\>]],
direction = 'float',
close_on_exit = true, -- close the terminal window when the process exits
-- This field is only relevant if direction is set to 'float'
float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'rounded',
    -- width = 40,
    -- height = 20,
    winblend = 3,
    highlights = {
        border = 'Normal',
        background = 'Normal',
        }
    }
}
EOF

" setup nvim-tree
lua << EOF
require'nvim-tree'.setup()
EOF

" setup treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
ensure_installed = { "bash", "c", "cpp", "css", "html", "javascript", "lua", "make", "markdown", "python", "regex", "rust", "toml", "vim", "yaml" },

-- Install languages synchronously (only applied to `ensure_installed`)
sync_install = false,

highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },
}
EOF

" setup code completion with compe
lua << EOF
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        vsnip = true;
    };
}
EOF



"------------------------------------------------------------------------------
" global vim settings
"------------------------------------------------------------------------------
set wildmode=longest:full,full                  " set completion mode
set completeopt=menuone,noinsert,noselect       " rquired for nvim-compe

set title                                       " set terminal title
set clipboard=unnamedplus                       " use clipboard for all actions
set termguicolors                               " use 24bit rgb colors in terminal

set confirm                                     " show dialog when operation needs to be confirmed
set number                                      " show line numbers
set relativenumber                              " numbers relative to current cursor position

set cursorline                                  " highlight current line
set showmatch                                   " highlight matching brackets

" set nowrap                                    " do not wrap lines by default
set linebreak                                   " ... at 'breakat'
set showbreak=↪                                 " ... and show symbol in front

set whichwrap+=<,>,[,]                          " allow cursors to wrap lines

set ignorecase                                  " ignore case for search ...
set smartcase                                   " ... but only if no uppercase letter in pattern

set nobackup                                    " do not use backup files

set tabstop=4                                   " number of spaces a tab counts for
set softtabstop=4                               " number of spaces a tab counts for in editing operations
set shiftwidth=4                                " number of spaces to use for auto indent
set expandtab                                   " use spaces instead of tabs
set smartindent                                 " ... and do it smart (works for c-like languages)

set foldmethod=syntax                           " TODO: maybe switch to expr with treesitter
set foldlevelstart=5				            " open most folds by default



"------------------------------------------------------------------------------
" auto commands
"------------------------------------------------------------------------------
" disable relative line numbers in insert mode
au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber



"------------------------------------------------------------------------------
" key mappings
"------------------------------------------------------------------------------
let mapleader=","					" leader is comma

" disable highliighting search results
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" edit / source configuration file
nnoremap <silent> <Leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sc :source $MYVIMRC<CR>

" toggle relative line numbering
nnoremap <silent> <Leader>n :setlocal relativenumber!<CR>

" toggle line wrapping
nnoremap <silent> <Leader>w :setlocal wrap!<CR>

" reindent whole file
nnoremap <silent> <Leader>= :call MyPreserveState("normal gg=G")<CR>

" remove trailing whitespaces
nnoremap <silent> <Leader>$ :call MyPreserveState("%s/\\s\\+$//ge")<CR>

" fast switching between buffers
nnoremap <silent> <C-l> :bNext<CR>
nnoremap <silent> <C-h> :bprevious<CR>

" moving lines up/down
nnoremap <silent> <C-k>   :m-2<CR>
nnoremap <silent> <C-j> :m+1<CR>

" make backspace delete selection in visual mode
vnoremap <silent> <BS> d

" telescope plugin
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>    " req. ripgrep
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" blame line plugin
nnoremap <silent> <leader>b :ToggleBlameLine<CR>

" nvim tree plugin
nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR>

" nvim-compe / nvim-autopairs
inoremap <silent><expr> <CR> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))



"------------------------------------------------------------------------------
" helper functions
"------------------------------------------------------------------------------
function MyPreserveState(command)
    " Save the last search
    let last_search=@/
    " Save the current cursor position
    let save_cursor = getpos(".")
    " Save the window position
    normal H
    let save_window = getpos(".")
    call setpos('.', save_cursor)

    " Do the business:
    execute a:command

    " Restore the last_search
    let @/=last_search
    " Restore the window position
    call setpos('.', save_window)
    normal zt
    " Restore the cursor position
    call setpos('.', save_cursor)
endfunction




"------------------------------------------------------------------------------
" highlighting
"------------------------------------------------------------------------------
hi Trailingwhitespaces guibg=yellow
match TrailingWhitespaces '\s\+$'



"------------------------------------------------------------------------------
" end of init.vim
"------------------------------------------------------------------------------
