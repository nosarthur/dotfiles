call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'andymass/vim-matchup'
Plug 'dyng/ctrlsf.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-swap'
Plug 'majutsushi/tagbar'
Plug 'neovimhaskell/haskell-vim'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'ojroques/vim-oscyank'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'brentyi/isort.vim'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdtree'
call plug#end()

let g:seoul256_background = 235
colo seoul256

let g:lightline = { 'colorscheme': 'seoul256', }
let g:markdown_folding=1
let g:markdown_enable_folding = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"automatic reload of .vimrc
autocmd! bufwritepost .vimrc source %

set clipboard=unnamed

set number
"set relativenumber
set autoread
set nocompatible
set hlsearch
set laststatus=2
set spell
set title
set encoding=utf-8
set colorcolumn=81
set autoindent
"set smartindent
set nostartofline
set tabpagemax=100
"set cursorline

set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smartcase
set updatetime=100
set nowrap
set wildignorecase

set foldmethod=indent
"set foldmethod=syntax
"set foldmethod=manual
set nofoldenable
"set foldlevel=2

set timeoutlen=500

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWritePre * %s/\s\+$//e

" set autochdir
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>

let mapleader = ","
noremap <Leader>q :q<CR> " Quit current window
noremap <Leader>e :qa!<CR> " Quit all windows

nnoremap <leader>b :vsp ~/.bashrc<cr>
inoremap <leader>b <C-c>:vsp ~/.bashrc<cr>
nnoremap <leader>c :vsp $MYVIMRC<cr>
inoremap <leader>c <C-c>:vsp $MYVIMRC<cr>
vnoremap <leader>c :OSCYankVisual<CR>
nnoremap <leader>g :G<cr>
inoremap <leader>g <C-c>:G<cr>
nnoremap <leader>n :tabnew<cr>
inoremap <leader>n <C-c>:tabnew<cr>
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>
vnoremap <Leader>s :sort<CR>
nnoremap <leader>v :vsplit<cr>
inoremap <leader>v <C-c>:vsplit<cr>
nnoremap <leader>w :wincmd w<cr>
inoremap <leader>w <C-c>:wincmd w<cr>
" nnoremap <leader>y :Goyo<cr>
" inoremap <leader>y <C-c>:Goyo<cr>
noremap <Leader><space> :noh<CR>:call clearmatches()<cr>
"nnoremap <leader>c gaip*,<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt

nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap Y y$
nnoremap * *``
"nmap <space> ciw

syntax enable

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" get rid of temporary files
set nobackup
set nowritebackup
set noswapfile

filetype on
filetype plugin on
filetype indent on

" recursive find
set path+=**

" command hint
set wildmenu
set wildmode=longest:list,full

" coc
autocmd FileType python let b:coc_root_patterns = ['.git', 'setup.py',]

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
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
"nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" fix coc.nvim box color
highlight Pmenu ctermbg=black ctermfg=yellow

autocmd FileType haskell autocmd BufWritePre <buffer> call CocAction('format')
let g:haskell_indent_disable=1


augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

augroup isort_on_save
  autocmd!
  autocmd BufWritePre *.py call isort#Isort(0, line('$'), v:null, v:false)
augroup end

nmap <leader>a :CtrlSF -R ""<Left>
" nmap <leader>b :BLines<CR>
nmap <leader>d :GitGutterFold<CR>
nmap <leader>k :GitGutterStageHunk<CR>
nmap <leader>f :GFiles!<CR>
"nmap <leader>l :Lines!<CR>
nmap <leader>o :Files!<CR>
nmap <leader>r :Rg!<CR>
nmap <leader>t :TagbarToggle<CR>
nmap <leader>m :History<cr>
nmap <leader>h :NERDTreeToggle<CR>

" tnoremap <silent> <leader>h  <C-\><C-n>:FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>


let g:floaterm_opener='vsplit'
let g:floaterm_height=0.9
let g:floaterm_width=0.8
let g:floaterm_keymap_toggle = '<Leader>,'


let g:tex_conceal = ""
let g:ctrlsf_confirm_save=0

let g:go_list_type = "quickfix"

let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert ='<C-q>'
let g:AutoPairsShortcutFastWrap='<C-s>'

let g:goyo_width=110

"let g:indent_guides_enable_on_vim_startup = 1
let g:indentLine_fileTypeExclude = ['json', 'markdown']

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" augroup maegz
"   " Remove all gzip autocommands
"   au!

"   " Enable editing of gzipped files
"   "       read: set binary mode before reading the file
"   "             uncompress text in buffer after reading
"   "      write: compress file after writing
"   "     append: uncompress file, append, compress file
"   autocmd BufReadPre,FileReadPre        *.maegz,*.phypo set bin
"   autocmd BufReadPost,FileReadPost      *.maegz,*.phypo let ch_save = &ch|set ch=2
"   autocmd BufReadPost,FileReadPost      *.maegz,*.phypo '[,']!gunzip
"   autocmd BufReadPost,FileReadPost      *.maegz,*.phypo set nobin
"   autocmd BufReadPost,FileReadPost      *.maegz,*.phypo let &ch = ch_save|unlet ch_save
"   autocmd BufReadPost,FileReadPost      *.maegz,*.phypo execute ":doautocmd BufReadPost " . expand("%:r")

"   autocmd BufWritePost,FileWritePost    *.maegz,*.phypo !mv <afile> <afile>:r
"   autocmd BufWritePost,FileWritePost    *.maegz,*.phypo !gzip <afile>:r
"   autocmd BufWritePost,FileWritePost    *.maegz,*.phypo !mv <afile>:r.gz <afile>:r.maegz

"   autocmd FileAppendPre                 *.maegz,*.phypo !gunzip <afile>
"   autocmd FileAppendPre                 *.maegz,*.phypo !mv <afile>:r <afile>
"   autocmd FileAppendPost                *.maegz,*.phypo !mv <afile> <afile>:r
"   autocmd FileAppendPost                *.maegz,*.phypo !gzip <afile>:r
"   autocmd FileAppendPost                *.maegz,*.phypo !mv <afile>:r.gz <afile>:r.maegz
"  augroup END

