local keymap = vim.keymap.set

-- Find keymap
keymap("n", "<leader><leader>", function()
	require("fzf-lua").files()
end, { desc = "Find File" })

keymap("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Find Files" })

keymap("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Find Buffer" })

keymap("n", "<leader>fg", function()
	require("fzf-lua").live_grep_native()
end, { desc = "Live Grep Current Directory" })

keymap("n", "<leader>fh", function()
	require("fzf-lua").oldfiles()
end, { desc = "Find Help" })

keymap("n", "<leader>?", function()
	require("fzf-lua").helptags()
end, { desc = "Find Help" })

keymap("n", "<leader>fs", function()
	require("fzf-lua").workspace_symbols()
end, { desc = "Show all Symbol" })

keymap("n", "<leader>fd", function()
	require("fzf-lua").diagnostic_workspace()
end, { desc = "Show Diagnose" })

vim.keymap.set("n", "<leader>fc", function()
	local config_dir = vim.fn.expand("~/.config/nvim")
	require("fzf-lua").files({ cwd = config_dir })
end, { desc = "Find Config" })

-- Buffer keymap
keymap("n", "<leader>bq", "<cmd>bd<cr>", { desc = "Close Buffer" })
keymap("n", "<leader>bd", "<cmd>%bd|e#<cr>", { desc = "Close other Buffers" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- LSP keymap
keymap("n", "<leader>cs", function()
	require("fzf-lua").document_symbols()
end, { desc = "Show all Symbols wn File" })

keymap("n", "<leader>cr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename Symbols" })

keymap("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Code Actions" })

keymap("n", "<leader>cd", function()
	require("fzf-lua").diagnostic_document()
end, { desc = "Show Diagnose in File" })

keymap("n", "<leader>cf", function()
	require("conform").format()
end, { desc = "Format Document" })

-- Session keymap
keymap("n", "<leader>sw", function()
	vim.cmd("wa")
	local cwd = vim.fn.getcwd()
	local last_folder = cwd:match("([^/]+)$")
	require("mini.sessions").write(last_folder)
end, { desc = "Save Session" })

keymap("n", "<leader>ss", function()
	vim.cmd("wa")
	require("mini.sessions").select()
end, { desc = "Load Session" })

keymap("n", "<leader>sd", function()
	for session_name, _ in pairs(require("mini.sessions").detected) do
		require("mini.sessions").delete(session_name, { force = true })
	end
end, { noremap = true, desc = "Delete All Sessions" })

-- Window Navigation
keymap("n", "<leader>l", "<cmd>wincmd l<cr>", { desc = "Focus Left" })
keymap("n", "<leader>k", "<cmd>wincmd k<cr>", { desc = "Focus Up" })
keymap("n", "<leader>j", "<cmd>wincmd j<cr>", { desc = "Focus Down" })
keymap("n", "<leader>h", "<cmd>wincmd h<cr>", { desc = "Focus Right" })

keymap("n", "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Focus Left" })
keymap("n", "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Focus Up" })
keymap("n", "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Focus Down" })
keymap("n", "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Focus Right" })

keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = "Close Window" })
keymap("n", "<leader>ws", "<cmd>wincmd s<cr>", { desc = "Split Window Horizontally" })
keymap("n", "<leader>wv", "<cmd>wincmd v<cr>", { desc = "Split Window Vertically" })

-- Dependencies keymap
keymap("n", "<leader>dm", "<cmd>Mason<cr>", { desc = "Open Mason" })
keymap("n", "<leader>du", "<cmd>DepsUpdate<cr>", { desc = "Update Plugins" })
keymap("n", "<leader>dc", "<cmd>DepsClean<cr>", { desc = "Clean Plugins" })

-- Misc keymap
keymap("n", "<leader>q", "<cmd>wqa<cr>", { desc = "Quit" })
keymap("n", "yY", "<cmd>%y<cr>", { desc = "Yank Buffer" })
keymap("n", "YY", "<cmd>%y+<cr>", { desc = "Yank Buffer to OS Clipboard" })
keymap("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "Mini Files" })
keymap("x", "<leader>p", '"_dP', { desc = "paste without overwriting" })

-- Wipe all data
vim.keymap.set("n", "<leader>x", function()
	local confirm = vim.fn.input("Are you sure you want to wipe all Neovim data (y/n): ")
	if confirm:lower() == "y" then
		local data_home = vim.fn.stdpath("data")
		local state_home = vim.fn.stdpath("state")

		local remove_command = "rm -rf"

		-- Remove data directory
		local data_result = vim.fn.system(remove_command .. ' "' .. data_home .. '"')

		-- Remove state directory
		local state_result = vim.fn.system(remove_command .. ' "' .. state_home .. '"')

		if vim.v.shell_error ~= 0 then
			print("\nError wiping data. Check permissions and try again.")
			print("Data removal output: " .. data_result)
			print("State removal output: " .. state_result)
		else
			print("\nData wiped successfully. Please restart Neovim.")
		end
	else
		print("\nOperation cancelled.")
	end
end, { noremap = true, desc = "Wipe All Data" })

-- For better ergonomics
keymap("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
keymap("n", "<leader>/", function()
	require("fzf-lua").lines()
end, { desc = "Fuzzy Find in File" })
