-- Set up mini.nvim collection including mini.deps the package manager

-- mini.nvim install
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up mini.deps
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

require("mini.deps").setup({ path = { package = path_package } })

-- mini.nvim plugins
later(function()
	require("mini.ai").setup()
	require("mini.align").setup()
	require("mini.bracketed").setup()
	require("mini.bufremove").setup()
	require("mini.comment").setup()
	require("mini.completion").setup()
	require("mini.cursorword").setup()
	require("mini.diff").setup()
	require("mini.extra").setup()
	require("mini.files").setup()
	require("mini.fuzzy").setup()
	require("mini.git").setup()
	require("mini.icons").setup({})
	require("mini.jump").setup()
	require("mini.move").setup()
	require("mini.operators").setup()
	require("mini.pairs").setup()
	require("mini.splitjoin").setup()
	require("mini.statusline").setup()
	require("mini.surround").setup()
	require("mini.tabline").setup()
	require("mini.trailspace").setup()
	require("mini.visits").setup()

	-- Presets for QoL Neovim options
	require("mini.basics").setup({
		mappings = {
			move_with_alt = true,
		},
	})

	require("mini.clue").setup({
		triggers = {
			-- Leader trggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			{ mode = "n", keys = "\\" },

			-- Bult-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},

		clues = {
			{ mode = "n", keys = "<Leader>b", desc = "Buffer" },
			{ mode = "n", keys = "<Leader>f", desc = "Find" },
			{ mode = "n", keys = "<Leader>w", desc = "Window" },
			{ mode = "n", keys = "<Leader>c", desc = "Code/LSP" },
			{ mode = "n", keys = "<Leader>s", desc = "Session" },
			{ mode = "n", keys = "<Leader>m", desc = "Multicursor" },
			{ mode = "n", keys = "<Leader>d", desc = "Dependencies" },
			require("mini.clue").gen_clues.g(),
			require("mini.clue").gen_clues.builtin_completion(),
			require("mini.clue").gen_clues.marks(),
			require("mini.clue").gen_clues.registers(),
			require("mini.clue").gen_clues.windows(),
			require("mini.clue").gen_clues.z(),
		},
		window = {
			delay = 300,
		},
	})

	require("mini.hipatterns").setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
		},
	})

	require("mini.indentscope").setup({
		draw = {
			animation = function()
				return 1
			end,
		},
		symbol = "│",
	})

	-- Set up mini.notify, from echasnovski's personal configuration
	local filterout_lua_diagnosing = function(notif_arr)
		local not_diagnosing = function(notif)
			return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
		end
		notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
		return MiniNotify.default_sort(notif_arr)
	end
	require("mini.notify").setup({
		content = { sort = filterout_lua_diagnosing },
		window = { config = { border = "solid" } },
	})
	vim.notify = MiniNotify.make_notify()

	require("mini.misc").setup()
	MiniMisc.setup_restore_cursor()
end)

now(function()
	local base16 = require("mini.base16")
	-- Clear highlights on search when pressing <Esc> in normal mode
	-- Set after mini.base16 is loaded
	vim.cmd.colorscheme("minischeme")

	-- Set up sessions before dashboard
	require("mini.sessions").setup()
	-- Set up dashboard
	local starter = require("mini.starter")
	starter.setup({
		autoopen = true,
		items = {
			-- recent files
			starter.sections.recent_files(5, false, false),
			starter.sections.sessions(5, true),
			{
				name = "Config Files",
				action = function()
					local config_dir = vim.fn.expand("~/.config/nvim")
					require("fzf-lua").files({ cwd = config_dir })
				end,
				section = "Search",
			},
		},
		header = [[
	 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
	 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
	 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
	 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
	 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
	 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
		]],
		footer = "", -- hide usage help shown by default
	})
end)
