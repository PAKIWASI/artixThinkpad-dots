
local opt = vim.opt

opt.signcolumn = "yes:1"    -- Always show sign column
opt.termguicolors = true    -- Enable true colors

opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true
opt.infercase = true

opt.swapfile = false        -- Disable swap files
opt.backup = false
opt.writebackup = false

opt.clipboard = "unnamedplus"
opt.mouse = ""

opt.autoindent = true       -- Enable auto indentation
opt.expandtab = true        -- Use spaces instead of tabs
opt.tabstop = 4             -- Number of spaces for a tab
opt.softtabstop = 4         -- Number of spaces for a tab when editing
opt.shiftwidth = 4          -- Number of spaces for autoindent
opt.shiftround = true       -- Round indent to multiple of shiftwidth

opt.list = true             -- Show whitespace characters
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.numberwidth = 2         -- Width of the line number column

opt.wrap = false            -- Disable line wrapping
opt.cursorline = true       -- Highlight the current line
opt.scrolloff = 8           -- Keep 8 lines above and below the cursor

opt.inccommand = "nosplit"  -- Shows the effects of a command incrementally in the buffer

opt.undodir = os.getenv('HOME') .. '/.local/state/nvim/undodir'  -- Directory for undo files
opt.undofile = true         -- Enable persistent undo

opt.completeopt = { "menu", "menuone", "noselect" }
opt.winborder = "rounded"   -- Use rounded borders for windows
opt.hlsearch = true         -- Enable highlighting of search results
opt.incsearch = true   -- Show matches as you type

opt.updatetime = 250    -- for lsp/diagnostics
opt.timeoutlen = 300    -- wait for additional key else mapping ends

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"
opt.pumheight = 10

opt.cmdheight = 0       -- hide cmd until needed

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation

