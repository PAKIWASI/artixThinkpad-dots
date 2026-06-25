
-- measuring startup time
require("utils.startup").start = vim.loop.hrtime()


require('configs')

require('keymaps')

require('autocmds')

require('plugins') -- time measured till end of this (dashboard)

require('lsp')


vim.notify(require("utils.startup").format2())  -- actual final time as a notification

