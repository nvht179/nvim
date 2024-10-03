-- Set up mini.deps
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local keymap = vim.keymap.set

-- Set up multicursors
add({ source = "jake-stewart/multicursor.nvim" })
later(function()
	local mc = require("multicursor-nvim")

	mc.setup({
		shallowUndo = false,
	})

	-- Add or skip cursor above/below the main cursor.
	keymap({ "n", "v" }, "<up>", function()
		mc.lineAddCursor(-1)
	end)
	keymap({ "n", "v" }, "<down>", function()
		mc.lineAddCursor(1)
	end)
	keymap({ "n", "v" }, "<m-up>", function()
		mc.lineSkipCursor(-1)
	end)
	keymap({ "n", "v" }, "<m-down>", function()
		mc.lineSkipCursor(1)
	end)

	-- Add or skip adding a new cursor by matching the current word/selection
	keymap({ "n", "v" }, "<m-n>", function()
		mc.matchAddCursor(1)
	end)
	keymap({ "n", "v" }, "<m-s>", function()
		mc.matchSkipCursor(1)
	end)
	keymap({ "n", "v" }, "<m-N>", function()
		mc.matchAddCursor(-1)
	end)
	keymap({ "n", "v" }, "<m-S>", function()
		mc.matchSkipCursor(-1)
	end)

	-- Delete the main cursor.
	keymap({ "n", "v" }, "<m-x>", mc.deleteCursor)

	-- Add and remove cursors with control + left click.
	keymap("n", "<m-leftmouse>", mc.handleMouse)

	keymap("n", "<esc>", function()
		-- Set nohlsearch to here highlighting search here
		-- Will not work if set elsewhere
		vim.cmd("nohlsearch")
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		else
			-- Default <esc> handler.
		end
	end)

	-- Append/insert for each line of visual selections.
	keymap("v", "I", mc.insertVisual)
	keymap("v", "A", mc.appendVisual)

	-- Rotate visual selection contents.
	-- Will not work in normal mode due to nil value cursor
	keymap({ "v" }, "<M-t>", function()
		mc.transposeCursors(1)
	end)
	keymap("v", "<M-T>", function()
		mc.transposeCursors(-1)
	end)

	-- Organize the multicursor settings into one menu
	keymap({ "n", "v" }, "<leader>mn", function()
		mc.matchAddCursor(1)
	end, { desc = "Add Next Matching Cursor" })
	keymap({ "n", "v" }, "<leader>ms", function()
		mc.matchSkipCursor(1)
	end, { desc = "Skip Next Matching Cursor" })
	keymap({ "n", "v" }, "<leader>mN", function()
		mc.matchAddCursor(-1)
	end, { desc = "Add Prev Matching Cursor" })
	keymap({ "n", "v" }, "<leader>mS", function()
		mc.matchSkipCursor(-1)
	end, { desc = "Skip Prev Matching Cursor" })
	keymap({ "n", "v" }, "<leader>ma", function()
		mc.matchAddCursor(1)
	end, { desc = "Add Cursor Under" })
	keymap({ "n", "v" }, "<leader>ms", function()
		mc.matchSkipCursor(1)
	end, { desc = "Skip Cursor Under" })
	keymap({ "n", "v" }, "<leader>mA", function()
		mc.matchAddCursor(-1)
	end, { desc = "Add Cursor Above" })
	keymap({ "n", "v" }, "<leader>mS", function()
		mc.matchSkipCursor(-1)
	end, { desc = "Skip Cursor Above" })
	require("mini.sessions").setup()
	keymap({ "n", "v" }, "<leader>md", mc.deleteCursor, { desc = "Delete Current Cursor" })
end)

