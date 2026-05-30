
-- measuring startup time
require("utils.startup").start = vim.loop.hrtime()

require('configs')

require('keymaps')

require('autocmds')

require('plugins') -- time measured till end of this

require('lsp')


