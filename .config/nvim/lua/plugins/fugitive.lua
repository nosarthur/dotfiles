return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>g", ":G<cr>", {})
        vim.keymap.set("i", "<leader>g", "<c-c>:G<cr>", {})
    end,
}
