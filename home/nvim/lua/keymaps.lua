vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("i", "<M-BS>", "<C-W>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>v", "<cmd>:vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>h", "<cmd>:split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>a", "GVgg", { desc = "Select all" })
vim.keymap.set("v", "p", "P", { noremap = true })
vim.keymap.set("n", "<leader>bd", function()
	pcall(vim.cmd, "bdelete! " .. vim.api.nvim_get_current_buf())
end)
vim.keymap.set("n", "<leader>bo", function()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if b ~= current_buf then
			pcall(vim.cmd, "bdelete! " .. b)
		end
	end
end)
