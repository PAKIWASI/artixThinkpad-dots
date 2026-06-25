-- colorscheme: lavinder.nvim
vim.pack.add({
    {
        src = "https://codeberg.org/jthvai/lavender.nvim",
        version = "stable"
    }
})
require('plugins.lavender')


-- mason
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require('plugins.mason')


-- lspconfig
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })


-- mason-lspconfig bridge
vim.pack.add({ "https://github.com/williamboman/mason-lspconfig.nvim" })
require('plugins.mason-lspconfig')


-- nvim-dap setup
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
vim.pack.add({ "https://github.com/theHamsta/nvim-dap-virtual-text" })
require("plugins.dap")


-- blink.cmp
vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1")
    }
})
require('plugins.blink')


-- treesitter
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main"
    }
})
require("plugins.treesitter")


-- git signs
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require('gitsigns').setup({})


-- oil.nvim - THE GOAT
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
vim.pack.add({ "https://github.com/FerretDetective/oil-git-signs.nvim" })
require('plugins.oil')


-- grug-far - regex based, project wide search and replace
vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })
require("plugins.grug-far")


-- ccc - color picker
vim.pack.add({ "https://github.com/uga-rosa/ccc.nvim" })
require("plugins.ccc")


-- mini plugins - small, effective plugins
vim.pack.add({ "https://github.com/echasnovski/mini.pairs" })
vim.pack.add({ "https://github.com/echasnovski/mini.move" })
vim.pack.add({ "https://github.com/echasnovski/mini.surround" })
require("plugins.mini")


-- flash - move like flash
vim.pack.add({ "https://github.com/folke/flash.nvim" })
require("plugins.flash")


-- lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("plugins.lualine")


-- bufferline
vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("plugins.bufferline")


-- which-key
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("plugins.which-key")


-- todo-coments
vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
require("plugins.todo-comments")


-- markview.nivm
vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })
require("plugins.markview")


-- TODO:
local disabled_built_ins = {
    "gzip",
    "zipPlugin",
    "tarPlugin",
    "netrw",
    "netrwPlugin",
    "tutor_mode_plugin"
}

for _, plugin in ipairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end


-- dev plugin
vim.opt.runtimepath:append("~/Documents/projects/lua/noted.nvim")
require("noted").setup({})


-- Snacks slop - too much shit but I depend on it
vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })
require("plugins.snacks") -- last because dashboard measures startup time


