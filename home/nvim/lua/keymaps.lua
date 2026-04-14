vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })
vim.keymap.set("n", "<c-h>", "<c-w><c-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<c-l>", "<c-w><c-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<c-j>", "<c-w><c-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<c-k>", "<c-w><c-k>", { desc = "move focus to the upper window" })
vim.keymap.set("i", "<m-bs>", "<c-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<c-bs>", "<c-w>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>v", "<cmd>:vsplit<cr>", { desc = "split vertically" })
vim.keymap.set("n", "<leader>h", "<cmd>:split<cr>", { desc = "split horizontally" })
vim.keymap.set("n", "<leader>a", "gvgg", { desc = "select all" })
vim.keymap.set("v", "p", "p", { noremap = true })
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
