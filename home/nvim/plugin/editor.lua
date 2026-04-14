vim.pack.add({
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})
require("lualine").setup({
	options = {
		component_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "filetype" },
		lualine_y = {},
		lualine_z = { "location" },
	},
})
require("nvim-autopairs").setup()
local flash = require("flash")
vim.keymap.set("n", "s", function()
	flash.jump()
end)
vim.keymap.set("n", "S", function()
	flash.treesitter()
end)

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		style_preset = 2,
		close_icon = " ",
		buffer_close_icon = " ",
		indicator = {
			style = "icon",
		},
		custom_filter = function(buf_number)
			local buf_name = vim.fn.bufname(buf_number)

			if buf_name:match("IN") or buf_name:match("OUT") then
				return false
			end
			return true
		end,
	},
})

local bufferline = require("bufferline")
vim.keymap.set("n", "<S-h>", function()
	bufferline.cycle(-1)
end, { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", function()
	bufferline.cycle(1)
end, { desc = "Next Buffer" })

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><Space>", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "/", function()
	builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
end, { desc = "[/] Fuzzily search in current buffer" })

require("neoscroll").setup({
	duration_multiplier = 0.5,
})
