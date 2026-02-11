vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>o', ':source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v' }, '<A-j>', ':m .+1<CR>')
vim.keymap.set({ 'n', 'v' }, '<A-k>', ':m .-2<CR>')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/mg979/vim-visual-multi" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/mvllow/modes.nvim" },
	{ src = "https://github.com/nvimdev/dashboard-nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/ntpeters/vim-better-whitespace" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then return end
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.cmd("colorscheme vague")

require("mason").setup({})
require("nvim-treesitter").setup({})
require("mini.pick").setup({})
require("nvim-autopairs").setup({})
require("nvim-highlight-colors").setup({})
require("lualine").setup({
	options = {
		theme = "vague"
	}
})
require("blink.cmp").setup({})
require("modes").setup({})
require("dashboard").setup({})
require("gitsigns").setup({})

vim.lsp.enable({
	"lua_ls", "pywright", "html", "cssls", "ts_ls", "jsonls"
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local n_lines = vim.api.nvim_buf_line_count(0)
		local last_line = vim.api.nvim_buf_get_lines(0, n_lines - 1, n_lines, true)[1]
		if last_line and last_line ~= "" then
			vim.api.nvim_buf_set_lines(0, n_lines, n_lines, true, { "" })
		end
	end,
})

