-- local null_ls = require("null-ls")
--
-- null_ls.setup({
--     sources = {
--         -- null_ls.builtins.diagnostics.stylelint,
--         null_ls.builtins.diagnostics.jsonlint,
--         -- null_ls.builtins.diagnostics.eslint_d,
--         null_ls.builtins.formatting.stylua,
--         -- null_ls.builtins.formatting.prettierd,
--         null_ls.builtins.completion.spell,
--     },
--     -- on_attach = function(client, bufnr)
--     --     if client.supports_method("textDocument/formatting") then
--     --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--     --         vim.api.nvim_create_autocmd("BufWritePre", {
--     --             group = augroup,
--     --             buffer = bufnr,
--     --             callback = function()
--     --                 -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--     --                 vim.lsp.buf.format()
--     --             end,
--     --         })
--     --     end
--     -- end,
-- })
-- -- local eslint = require("eslint")
--
-- null_ls.setup()
--
-- -- eslint.setup({
-- --     bin = 'eslint', -- or `eslint_d`
-- --     code_actions = {
-- --         enable = true,
-- --         apply_on_save = {
-- --             enable = true,
-- --             types = { "directive", "problem", "suggestion", "layout" },
-- --         },
-- --         disable_rule_comment = {
-- --             enable = true,
-- --             location = "separate_line", -- or `same_line`
-- --         },
-- --     },
-- --     diagnostics = {
-- --         enable = true,
-- --         report_unused_disable_directives = false,
-- --         run_on = "type", -- or `save`
-- --     },
-- -- })
-- ---------------------------------------------------------
-- --
-- -- NULL LS is for hooking up non-LSP tools to the LSP UX
-- --
-- --
-- -- Be sure to :checkhealth to see if any underlying tools are missing
-- --
-- -- pnpm add --global @fsouza/prettierd cspell typescript
-- --
-- ---------------------------------------------------------
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- -- TODO: figure out how to wire up ember-template-lint
-- local lsp_formatting = function(buffer)
--     vim.lsp.buf.format({
--         filter = function(client)
--             -- By default, ignore any formatters provider by other LSPs
--             -- (such as those managed via lspconfig or mason)
--             -- Also "eslint as a formatter" doesn't work :(
--             return client.name == "null-ls"
--         end,
--         bufnr = buffer,
--     })
-- end
--
-- -- Format on save
-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
-- local on_attach = function(client, buffer)
--     -- the Buffer will be null in buffers like nvim-tree or new unsaved files
--     if (not buffer) then
--         return
--     end
--
--     if client.supports_method("textDocument/formatting") then
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = buffer,
--             callback = function()
--                 lsp_formatting(buffer)
--             end,
--         })
--     end
-- end
--
-- null_ls.setup({
--     sources = {
--         -- Prettier, but faster (daemonized)
--         null_ls.builtins.formatting.prettierd.with({
--             filetypes = {
--                 "scss", "css", "json", "jsonc", "javascript", "typescript",
--                 "javascript.glimmer", "typescript.glimmer",
--                 "handlebars"
--             }
--         }),
--
--         -- Code actions for staging hunks, blame, etc
--         null_ls.builtins.code_actions.gitsigns,
--         null_ls.builtins.completion.luasnip,
--         -- null_ls.builtins.diagnostics.stylelint,
--
--         -- Spell check that has better tooling
--         -- all stored locally
--         -- https://github.com/streetsidesoftware/cspell
--         null_ls.builtins.diagnostics.cspell.with({
--             -- This file is symlinked from my dotfiles repo
--             extra_args = { "--config", "~/.cspell.json" }
--         }),
--         null_ls.builtins.code_actions.cspell.with({
--             -- This file is symlinked from my dotfiles repo
--             extra_args = { "--config", "~/.cspell.json" }
--         })
--         -- null_ls.builtins.completion.spell,
--     },
--     on_attach = on_attach
-- })
--
-- local eslint = require('lspconfig').eslint
-- local lspconfig = require('lspconfig')
--
-- lspconfig.stylelint_lsp.setup {
--     filetypes = { "css", "less", "scss" },
--     settings = {
--         filetypes = { "css", "less", "scss" },
--         stylelintplus = {
--             autoFixOnSave = true,
--             autoFixOnFormat = true,
--             filetypes = { "css", "less", "scss" },
--         }
--     },
-- }
-- require 'lspconfig'.jsonls.setup {}
--
--
--
-- eslint.setup({
--     on_attach = function(client, bufnr)
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             buffer = bufnr,
--             command = "EslintFixAll",
--         })
--     end,
-- })
-- local status, null_ls = pcall(require, "null-ls")
-- if (not status) then return end
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
-- end
--
-- null_ls.setup {
--     sources = {
--         null_ls.builtins.formatting.prettierd,
--         null_ls.builtins.diagnostics.eslint_d.with({
--             diagnostics_format = '[eslint] #{m}\n(#{c})'
--         }),
--         null_ls.builtins.diagnostics.fish
--     },
--     on_attach = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                     lsp_formatting(bufnr)
--                 end,
--             })
--         end
--     end
-- }
--
-- vim.api.nvim_create_user_command(
--     'DisableLspFormatting',
--     function()
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
--     end,
--     { nargs = 0 }
-- )
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = async })
                end,
                desc = "[lsp] format on save",
            })
        end

        if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
        end
    end,
})

local prettier = require("prettier")

prettier.setup({
    bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
})
prettier.setup({
    ["null-ls"] = {
        condition = function()
            return prettier.config_exists({
                -- if `false`, skips checking `package.json` for `"prettier"` key
                check_package_json = true,
            })
        end,
        runtime_condition = function(params)
            -- return false to skip running prettier
            return true
        end,
        timeout = 5000,
    }
})
prettier.setup({
    cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        -- jsx_bracket_same_line = false,
        jsx_single_quote = false,
        print_width = 80,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = false,
        tab_width = 2,
        trailing_comma = "es5",
        use_tabs = false,
        vue_indent_script_and_style = false,
    },
})
