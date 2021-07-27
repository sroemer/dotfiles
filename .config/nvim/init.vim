syntax enable
filetype plugin indent on



"------------------------------------------------------------------------------
" global vim settings
"------------------------------------------------------------------------------
set wildmenu                        " enable wildmenu
set wildmode=longest:full,full      " set completion mode

set title                           " set terminal title
set clipboard=unnamedplus           " use clipboard for all actions
set termguicolors                   " use 24bit rgb colors in terminal
set noerrorbells                    " no error sounds
set novisualbell                    " no blink on error

set confirm                         " show dialog when operation needs to be confirmed
set ruler                           " show cursor position in status bar
set number                          " show line numbers
set relativenumber                  " numbers relative to current cursor position

set hidden                          " allow hidden buffers
set showcmd                         " show command in bottom bar
set cursorline                      " highlight current line
set showmatch                       " highlight matching brackets

set wrap                            " wrap lines by default
set linebreak                       " ... at 'breakat'
set showbreak=↪                     " ... and show symbol in front

set backspace=indent,eol,start      " allow backspace over everything
set whichwrap+=<,>,[,]              " allow cursors to wrap lines

set ignorecase                      " ignore case for search ...
set smartcase                       " ... but only if no uppercase letter in pattern
set incsearch                       " move cursor to matching string
set hlsearch                        " highlight matches while typing
set wrapscan                        " searches wrap around at end of file

set nobackup                        " do not use backup files

set tabstop=4                       " number of spaces a tab counts for
set softtabstop=4                   " number of spaces a tab counts for in edition operations
set shiftwidth=4                    " number of spaces to use for auto indent
set expandtab                       " use spaces instead of tabs
set autoindent                      " do auto indent on new lines
set smartindent                     " ... and do it smart (c-like languages)

set foldenable						" enable folding
set foldmethod=syntax               " TODO
set foldlevelstart=5				" open most folds by default



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

" make Y consistent with C and D
nnoremap <silent> Y y$

" disable highliighting search results
nnoremap <silent> <Leader><space> :nohlsearch<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <silent> <Leader>? :nohlsearch<CR>

" toggle relative line numbering
nnoremap <silent> <Leader>n :setlocal relativenumber!<CR>

" toggle line wrapping
nnoremap <silent> <Leader>w :setlocal wrap!<CR>

" reindent whole file
nnoremap <silent> <Leader><TAB> :call MyPreserveState("normal gg=G")<CR>

" remove trailing whitespaces
nnoremap <silent> <Leader>$ :call MyPreserveState("%s/\\s\\+$//ge")<CR>

" fast switching between buffers
nnoremap <silent> <C-l> :bNext<CR>
nnoremap <silent> <C-Right> :bNext<CR>
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-Left> :bprevious<CR>

" moving lines up/down
nnoremap <silent> <C-k>   :m-2<CR>
nnoremap <silent> <C-UP>   :m-2<CR>
nnoremap <silent> <C-j> :m+1<CR>
nnoremap <silent> <C-DOWN> :m+1<CR>

" make backspace delete selection in visual mode
vnoremap <silent> <BS> d



"------------------------------------------------------------------------------
" highlighting
"------------------------------------------------------------------------------
hi Trailingwhitespaces guibg=red
match TrailingWhitespaces '\s\+$'



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
" plugins
"------------------------------------------------------------------------------
call plug#begin()
Plug 'tanvirtin/monokai.nvim'
Plug 'tpope/vim-repeat'
Plug 'tversteeg/registers.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/nvim-toggleterm.lua'
call plug#end()

" setup monokai colorscheme
colorscheme monokai

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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



"------------------------------------------------------------------------------
" end of init.vim
"------------------------------------------------------------------------------
