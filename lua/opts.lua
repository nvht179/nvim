-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Sync clipboard between OS and Neovim.
-- opt.clipboard = 'unnamedplus'

-- Make line numbers default
opt.number = true

-- Use relative line numbers
opt.relativenumber = true

opt.cursorline = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Configure indentation
opt.shiftwidth = 4
opt.tabstop = 4

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Set cursor behavior: line in insert (default) and enable blinking
opt.guicursor = table.concat({
	"n-v-c:block",
	"i-ci-ve:ver25-blinkwait1000-blinkon500-blinkoff500",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait1000-blinkon500-blinkoff500-Cursor/lCursor",
	"sm:block-blinkwait1000-blinkon500-blinkoff500",
}, ",")

local keymap = vim.keymap.set

-- Configure in multicursor plugin
-- keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
