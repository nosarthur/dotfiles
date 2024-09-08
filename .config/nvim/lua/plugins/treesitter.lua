return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
                highlight = { enable = true },
                indent = { enable = true },
                matchup = {
                    enable = true, -- mandatory, false will disable the whole extension
                    disable = { "c", "ruby" }, -- optional, list of language that will be disabled
                    -- [options]
                },
            })
        end,
    },
}
