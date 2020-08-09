syntax enable

set nu
set relativenumber
set incsearch
set nohlsearch
set showmatch
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set ignorecase
set smartcase
set splitbelow
set splitright
set backspace=indent,eol,start
set termguicolors
set scrolloff=8

"set line limit column"
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

"remove trailing whitespaces when saving"
autocmd BufWritePre * %s/\s\+$//e

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

"builder function for markdown composer plugin"
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction


"All plugins go within this call"
call plug#begin('~/.local/share/nvim/plugged')

"Auto completion engine for neovim"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"Autocomplete in Python"
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

"Status bar plugin"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Automatic quote and bracket completion"
Plug 'jiangmiao/auto-pairs'

"Automatic comment sign depending on the file"
Plug 'scrooloose/nerdcommenter'

"Automatic file formatting"
Plug 'sbdchd/neoformat'

"Fuzzy file search"
Plug 'ctrlpvim/ctrlp.vim'

"Highlight yanked area"
Plug 'machakann/vim-highlightedyank'

"Linter"
Plug 'neomake/neomake'

"Color Theme"
Plug 'morhetz/gruvbox'

"Syntax for multiple languages"
Plug 'sheerun/vim-polyglot'

"Sort imports in python"
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }

"Git support for vim"
Plug 'tpope/vim-fugitive'

"Semantic highlights for python"
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

"Markdown preview"
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

"Show undo tree visualization"
Plug 'mbbill/undotree'


"Smart code compose using AI"
if has('win32') || has('win64')
  Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

call plug#end()

"enable autocomplete when nvim starts"
let g:deoplete#enable_at_startup = 1
let g:pymode_rope = 0
"remove preview window when autocomplete exits"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"go through autocomplete suggestions with tab"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

"set vim airline theme"
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

"sort imports on saving file"
au BufWrite * :Isort

"format on save"
let g:neoformat_enabled_python = ['black']
au BufWrite * :Neoformat

"use riggrep for fuzzy file search"
if executable('rg')
    let g:rg_derive_root='true'
    let g:ctrlp_user_command = "rg %s --files --hidden --color=never --glob '!**/.git/**' --glob '!*pycache*'"
endif
let g:ctrlp_working_path_mode = 'c'

"set leader as space bar"
let mapleader = " "

"easier split creation"
nnoremap <silent> <Leader>[ : split<cr>
nnoremap <silent> <Leader>] : vsplit<cr>
"easier split navigations"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"easier split resize"
nnoremap <silent> <Leader>_ :res+5<cr>
nnoremap <silent> <Leader>- :res-5<cr>
nnoremap <silent> <Leader>+ :vertical resize+5<cr>
nnoremap <silent> <Leader>= :vertical resize-5<cr>
"easier file show"
nnoremap <leader>L :Lex <CR>
"easier undo tree show"
nnoremap <leader>tu :UndotreeShow<CR>
"move selected lines in visual mode up or down"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" 'Q' in normal mode enters Ex mode.
nmap Q <Nop>
"open terminal in a split
nnoremap <Leader>th :split <<bar> :resize 10 <bar> :term <cr>
nnoremap <Leader>tv :vsplit <<bar> :term <cr>
"easy terminal pane switch"
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-N><C-w>h
:tnoremap <C-j> <C-\><C-N><C-w>j
:tnoremap <C-k> <C-\><C-N><C-w>k
:tnoremap <C-l> <C-\><C-N><C-w>l

"configure netrw to look like Nerdtree"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -30
"augroup ProjectDrawer
  "autocmd!
  "autocmd VimEnter * :Lex
"augroup END

"linter configs"
let g:neomake_python_flake_maker = {
  \ 'args': [
  \ '-d', 'C0103, C0111',
  \ '-i', 'E203, E501',
  \ '-f', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }
let g:neomake_python_enabled_makers = ['flake8']
call neomake#configure#automake('nrwi', 500)

"yanking highlight duration"
let g:highlightedyank_highlight_duration = 250

"gruvbox theme settings"
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection=0
set background=dark
set t_Co=256
colorscheme gruvbox

"set custom colors of gruvbox theme according"
if g:colors_name == "gruvbox"
"highlight Normal ctermbg=233
highlight Normal ctermfg=223
endif

"set custom colors of semshi semantic highlights"
function MyCustomHighlights()
    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#5fafff
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    hi semshiAttribute       ctermfg=49  guifg=#00ffaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction

call deoplete#custom#var('tabnine', {
\ 'line_limit': 1000,
\ 'max_num_results': 3,
\ })

