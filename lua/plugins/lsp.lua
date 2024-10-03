-- Set up mini.deps
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Set up LSP, treesitter, and formatters and Mason for LSP and formatter management
-- Set up Mason for LSP and formatter management
add({ source = "williamboman/mason.nvim" })
-- For easy bridge between Mason and lspconfig
add({ source = "williamboman/mason-lspconfig.nvim" })
-- Easy config for Neovim LSP
add({ source = "neovim/nvim-lspconfig" })

now(function()
	require("mason").setup()
	require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "pyright", "ts_ls", "marksman", "html" } })
end)

later(function()
	local lspconfig = require("lspconfig")
	require("mason-lspconfig").setup_handlers({
		function(server)
			lspconfig[server].setup({})
		end,
	})
end)

-- Set up formatters
add({ source = "stevearc/conform.nvim" })
add({ source = "zapling/mason-conform.nvim", depends = { "williamboman/mason.nvim", "stevearc/conform.nvim" } })
now(function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black", stop_after_first = true },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		},
	})

	-- Automatically install missing formatter using Mason
	require("mason-conform").setup()
end)

-- Set up treesitter for advanced syntax highlighting and make Neovim language-aware.
add({ source = "nvim-treesitter/nvim-treesitter" })
now(function()
	require("nvim-treesitter.install").prefer_git = false
	vim.cmd("TSUpdate")
	require("nvim-treesitter.configs").setup({ auto_update = true })
end)
