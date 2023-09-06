require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "lua_ls", "rust_analyzer" },
	automatic_installation = true,
})
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()



local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})


local lsp = require("lspconfig")
-- Setup nvim-cmp for autocompletion
-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
--
-- local has_words_before = function()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--
-- cmp.setup({
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "cmp_tabnine" },
-- 		{ name = "nvim_lua" },
-- 		{ name = "luasnip" },
-- 		{ name = "path" },
-- 		{ name = "calc" },
-- 		{ name = "buffer" },
-- 	},
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-q>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-s>"] = cmp.mapping.complete(),
-- 		["<Tab>"] = cmp.mapping(function(fallback)
-- 			if luasnip.expand_or_jumpable() then
-- 				luasnip.expand_or_jump()
-- 			elseif has_words_before() then
-- 				cmp.complete()
-- 			else
-- 				fallback()
-- 			end
-- 		end, {
-- 			"i",
-- 			"s",
-- 		}),
--
-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
-- 			if luasnip.jumpable(-1) then
-- 				luasnip.jump(-1)
-- 			else
-- 				fallback()
-- 			end
-- 		end, {
-- 			"i",
-- 			"s",
-- 		}),
-- 	}),
-- 	preselect = "none",
-- 	view = {
-- 		entries = "native",
-- 	},
-- 	experimental = {
-- 		ghost_text = true,
-- 	},
-- })
--
-- -- setup cmp theme
-- vim.cmd([[
--     hi CmpItemAbbrMatch gui=bold
--     hi CmpItemAbbrMatchFuzzy gui=bold
-- ]])
--
-- vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
-- -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
-- vim.keymap.set("n", "K", function()
-- 	vim.lsp.buf.hover()
-- end, opts)
-- vim.keymap.set("n", "<leader>vws", function()
-- 	vim.lsp.buf.workspace_symbol()
-- end, opts)
-- vim.keymap.set("n", "<leader>vd", function()
-- 	vim.diagnostic.open_float()
-- end, opts)
-- vim.keymap.set("n", "[d", function()
-- 	vim.diagnostic.goto_next()
-- end, opts)
-- vim.keymap.set("n", "]d", function()
-- 	vim.diagnostic.goto_prev()
-- end, opts)
-- vim.keymap.set("n", "<leader>vca", function()
-- 	vim.lsp.buf.code_action()
-- end, opts)
-- vim.keymap.set("n", "<leader>vrr", function()
-- 	vim.lsp.buf.references()
-- end, opts)
-- vim.keymap.set("n", "<leader>vrn", function()
-- 	vim.lsp.buf.rename()
-- end, opts)
-- vim.keymap.set("i", "<C-h>", function()
-- 	vim.lsp.buf.signature_help()
-- end, opts)
--
-- vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

require("lspconfig").lua_ls.setup({})
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").tsserver.setup({
	-- capabilities = capabilities,
})
require("lspconfig").eslint.setup({
	-- capabilities = capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.completion.spell,
	},
})
