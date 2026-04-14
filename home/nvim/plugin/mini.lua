vim.pack.add({ "https://github.com/nvim-mini/mini.files" })
local files = require("mini.files")
files.setup({
	mappings = {
		close = "<leader>w",
	},
	options = {
		use_as_default_explorer = false,
	},
})
vim.keymap.set("n", "<leader>w", function()
	files.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open mini.files" })
