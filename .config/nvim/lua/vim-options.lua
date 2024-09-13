vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set number")
vim.cmd("set shiftwidth=4")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set updatetime=100")
vim.cmd("set nowrap")
vim.cmd("set wildignorecase")
vim.cmd("set clipboard=unnamed")
vim.cmd("set autoread")
vim.cmd("set nocompatible")
vim.cmd("set hlsearch")
vim.cmd("set title")
vim.cmd("set spell")
vim.cmd("set encoding=utf-8")
vim.cmd("set colorcolumn=80")
vim.cmd("set autoindent")
vim.cmd("set nostartofline")
vim.cmd("set tabpagemax=100")
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")
vim.cmd("set timeoutlen=500")

-- get rid of temporary files
vim.cmd("set nobackup")
vim.cmd("set nowritebackup")
vim.cmd("set noswapfile")

-- vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
-- vim.cmd("match ExtraWhitespace /s+$/")

-- filetype
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- fine tune
vim.cmd("nnoremap J mzJ`z")
vim.cmd("nnoremap n nzzzv")
vim.cmd("nnoremap N Nzzzv")
vim.cmd("nnoremap Y y$")
vim.cmd("nnoremap * *``")

-- easier moving of code blocks
vim.cmd("vnoremap < <gv")
vim.cmd("vnoremap > >gv")

-- leader key shortcuts
vim.g.mapleader = ","
vim.keymap.set("n", "<leader>q", ":q<cr>", {})   -- quit current
vim.keymap.set("n", "<leader>e", ":qa!<cr>", {}) -- quit all
vim.keymap.set("n", "<leader>n", ":tabnew<cr>", {})
vim.keymap.set("i", "<leader>n", "<c-c>:tabnew<cr>", {})
vim.keymap.set("n", "<leader>s", ":w<cr>", {})
vim.keymap.set("i", "<leader>s", "<c-c>:w<cr>", {})
vim.keymap.set("v", "<leader>s", ":sort<cr>", {})
vim.keymap.set("n", "<leader>v", ":vsplit<cr>", {})
vim.keymap.set("i", "<leader>v", "<c-c>:vsplit<cr>", {})
vim.keymap.set("n", "<leader>w", ":wincmd w<cr>", {})
vim.keymap.set("i", "<leader>w", "<c-c>:wincmd w<cr>", {})
vim.keymap.set("n", "<leader><space>", ":noh<cr>:call clearmatches()<cr>", {})

vim.keymap.set("n", "<leader>1", "1gt", {})
vim.keymap.set("n", "<leader>2", "2gt", {})
vim.keymap.set("n", "<leader>3", "3gt", {})
vim.keymap.set("n", "<leader>4", "4gt", {})

vim.keymap.set("", "<tab>", "<C-W>W:cd %:p:h<CR>:<CR>", {})

vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
-- vim.cmd("autocmd BufWritePre * %s/s+$//e")
