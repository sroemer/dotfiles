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
Plug 'windwp/nvim-ts-autotag'                                   " automatically close and rename tags
Plug 'hoob3rt/lualine.nvim'                                     " statusline written in lua
Plug 'nvim-telescope/telescope.nvim'                            " fuzzy finder
Plug 'lewis6991/gitsigns.nvim'                                  " git decorations
Plug 'tveskag/nvim-blame-line'                                  " git blame for current line
Plug 'akinsho/nvim-toggleterm.lua'                              " terminal window
Plug 'kyazdani42/nvim-tree.lua'                                 " file explorer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     " treesitter for syntax highlight etc.
Plug 'SmiteshP/nvim-gps'                                        " show context (function etc.) in statusline
Plug 'p00f/nvim-ts-rainbow'                                     " rainbow parentheses
Plug 'neovim/nvim-lspconfig'                                    " configurations for builtin language server client
Plug 'simrat39/rust-tools.nvim'                                 " extra tools for rust development
Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " auto-completion with coc
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*', 'do': 'make install_jsregexp'}
Plug 'rafamadriz/friendly-snippets'                             " snippet collection
Plug 'phaazon/hop.nvim', { 'branch': 'v2' }                     " hop around - easy motions
Plug 'romgrk/barbar.nvim'                                       " tab bar on top of the screen
Plug 'nvim-neorg/neorg'
call plug#end()

" use monokai colorscheme
colorscheme monokai

" show content of registers with a rounded border
lua << EOF
local registers = require("registers")
registers.setup {
    window = { border = "rounded" }
}
EOF

" setup autopairs
lua require('nvim-autopairs').setup {}

" setup lualine
lua << EOF
local gps = require("nvim-gps")
require('lualine').setup {
    options = { theme = 'codedark', },
    sections = { lualine_c = { { gps.get_location, cond = gps.is_available, }, }, },
}
EOF

" setup gitsigns
lua require('gitsigns').setup {}

" setup toggleterm
lua << EOF
require('toggleterm').setup {
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
        },
    },
}
EOF

" setup nvim-tree
lua require('nvim-tree').setup {}

" setup treesitter
lua << EOF
require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "bash", "c", "cmake", "cpp", "css", "diff", "git_rebase", "html", "javascript", "json", "lua", "make", "markdown", "markdown_inline", "python", "regex", "rust", "scss", "toml", "vim", "yaml" },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- autotag
    autotag = {
        enable = true,
    },
    -- highlighting
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    -- rainbow parentheses
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
}
EOF

" setup nvim-gps for showing context in statusbar
lua require("nvim-gps").setup()

" setup lsp - using servers for bash,  c/c++, python and rust
lua << EOF
require('lspconfig').awk_ls.setup {}
require('lspconfig').bashls.setup {}
require('lspconfig').cssls.setup {}
require('lspconfig').clangd.setup {}
require('lspconfig').jsonls.setup {}
require('lspconfig').html.setup {}
require('lspconfig').pyright.setup {}
require('lspconfig').rust_analyzer.setup {}
require('lspconfig').yamlls.setup {}
require('lspconfig').arduino_language_server.setup {}
require('lspconfig').diagnosticls.setup{
    filetypes = { "sh" },
    init_options = {
        linters = require('user/diagnosticls-linters'),
        filetypes = { sh = "shellcheck" },
    },
}
EOF

" setup rust-tools
lua require('rust-tools').setup {}

" setup hop
lua require('hop').setup {}

lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
    }
}
EOF


"------------------------------------------------------------------------------
" global vim settings
"------------------------------------------------------------------------------
set wildmode=longest:full,full                  " set completion mode
set completeopt=menuone,noinsert,noselect       " required for nvim-cmp

set title                                       " set terminal title
set clipboard=unnamedplus                       " use clipboard for all actions
set termguicolors                               " use 24bit rgb colors in terminal
set mouse+=a                                    " enable mouse support

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

set foldmethod=expr                             " using folding expr ...
set foldexpr=nvim_treesitter#foldexpr()         " ... based on treesitter
set foldlevelstart=5                            " open most folds by default



"------------------------------------------------------------------------------
" auto commands
"------------------------------------------------------------------------------
" disable relative line numbers in insert mode
au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber



"------------------------------------------------------------------------------
" key mappings
"------------------------------------------------------------------------------
let mapleader=","                    " leader is comma

" disable highlighting search results
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" edit / source configuration file
nnoremap <silent> <Leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sc :source $MYVIMRC<CR>
nnoremap <silent> <Leader>eb :e ~/.bashrc<CR>
nnoremap <silent> <Leader>ep :e ~/.bash_profile<CR>

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
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" blame line plugin
nnoremap <silent> <leader>b :ToggleBlameLine<CR>

" nvim tree plugin
nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR>

" hop around
nnoremap <silent> <Leader>hw :HopWord<CR>
nnoremap <silent> <Leader>hW :HopWordCurrentLine<CR>
nnoremap <silent> <Leader>hc :HopChar1<CR>
nnoremap <silent> <Leader>hC :HopChar1CurrentLine<CR>

" save file as root
cmap w!! w !sudo -A tee > /dev/null %<CR>

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



"------------------------------------------------------------------------------
" highlighting
"------------------------------------------------------------------------------
" fix neorg bold and italic for neorg
hi @text.strong cterm=bold gui=bold
hi @text.emphasis cterm=italic gui=italic

hi Trailingwhitespaces guibg=yellow
match TrailingWhitespaces '\s\+$'



"------------------------------------------------------------------------------
" end of init.vim
"------------------------------------------------------------------------------
