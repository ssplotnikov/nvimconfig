-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -- use({
    --     "williamboman/mason.nvim",
    --     "williamboman/mason-lspconfig.nvim",
    --     "neovim/nvim-lspconfig",
    -- })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })
    -- use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context")
    use({
        "jose-elias-alvarez/null-ls.nvim",
        -- config = function()
        --     require("null-ls").setup()
        -- end,
        requires = { "nvim-lua/plenary.nvim" },
    })
    -- use(
    --
    --     { "hrsh7th/nvim-cmp" },
    --     { "hrsh7th/cmp-buffer" },
    --     { "hrsh7th/cmp-path" },
    --     { "saadparwaiz1/cmp_luasnip" },
    --     { "hrsh7th/cmp-nvim-lsp" },
    --     { "hrsh7th/cmp-nvim-lua" },
    --
    --     -- Snippets
    --     { "L3MON4D3/LuaSnip" },
    --     { "rafamadriz/friendly-snippets" }
    -- )

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    })
    --     use(
    --
    --     {
    -- "jay-babu/mason-null-ls.nvim",
    --     requires = {
    --       "williamboman/mason.nvim",
    --       "jose-elias-alvarez/null-ls.nvim",
    --     },
    --     }
    --     )
    --
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    -- use({
    --     "akinsho/git-conflict.nvim",
    --     tag = "*",
    --     config = function()
    --         require("git-conflict").setup()
    --     end,
    -- })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    })
    use({
        "nvimdev/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lspsaga").setup({})
        end,
    })
    -- use('MunifTanjim/prettier.nvim')
end)
