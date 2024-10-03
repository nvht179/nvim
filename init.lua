require("opts")
require("keymaps")

-- require all lua files in plugins/
-- mini.deps should be loaded first
require("plugins.mini")
local fd = vim.loop.fs_scandir(vim.fn.stdpath("config") .. "/lua/plugins/")
for name in
	function()
		return vim.loop.fs_scandir_next(fd)
	end
do
	require("plugins." .. name:gsub(".lua\z", ""))
end
