vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable({ "nil_ls", "lua_ls", "ts_ls", "clangd", "qmlls" })

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

vim.keymap.set("n", "<Leader>d", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>")

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
	sources = {
		default = { "lsp", "path", "lazydev" },
		providers = {
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	fuzzy = { implementation = "rust" },
})
