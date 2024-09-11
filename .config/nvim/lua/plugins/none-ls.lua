return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                require("none-ls.diagnostics.flake8").with({
                    extra_args = { "--max-line-length", "88" },
                }),
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.erb_lint,
                -- null_ls.builtins.diagnostics.flake8.with({extra_args = {"--max-line-length","88"}}),
                null_ls.builtins.completion.spell,
            },
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
        -- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
