-- Set up mini.deps
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Set up fzf-lua for fuzzy finders
add({ source = "ibhagwan/fzf-lua", depends = { "echasnovski/mini.icons" } })
later(function()
	require("fzf-lua").setup({ "fzf-native" })
end)
add({ source = "folke/flash.nvim" })
later(function()
	vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
		require("flash").jump()
	end, { desc = "Flash" })
	vim.keymap.set("o", "r", function()
		require("flash").remote()
	end, { desc = "Remote Flash" })
end)
