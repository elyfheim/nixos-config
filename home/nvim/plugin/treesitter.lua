vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
local parsers = {
	"lua",
	"typescript",
	"qmljs",
	"nix",
	"zig",
	"c",
	"cpp",
	"markdown",
	"python",
	"rust",
	"go",
	"javascript",
	"toml",
}
local treesitter = require("nvim-treesitter")
treesitter.install(parsers)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		treesitter.update()
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end
	end,
})
