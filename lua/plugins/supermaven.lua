-- Set up mini.deps
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = "supermaven-inc/supermaven-nvim" })
later(function()
	require("supermaven-nvim").setup({})
end)
