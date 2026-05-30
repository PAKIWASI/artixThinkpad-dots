require("snacks").setup({
    picker       = { enabled = true },
    image        = { enabled = false },
    notifier     = { enabled = true },
    words        = { enabled = true },
    bigfile      = { enabled = true },
    indent       = { enabled = true },
    scroll       = { enabled = true },
    input        = { enabled = true },
    quickfile    = { enabled = true },
    scope        = { enabled = true },
    statuscolumn = { enabled = true },
    lazygit      = { enabled = true },
    dashboard    = {
        preset = {
            keys = {
                { key = "f", desc = "Find File", icon = " ", action = function() Snacks.picker.smart() end },
                { key = "n", desc = "New File", icon = " ", action = function() vim.cmd("ene | startinsert") end },
                { key = "g", desc = "Find Text", icon = " ", action = function() Snacks.picker.grep() end },
                { key = "r", desc = "Recent Files", icon = " ", action = function() Snacks.picker.recent() end },
                { key = "p", desc = "Projects", icon = " ", action = function() Snacks.picker.projects() end },
                {
                    key = "c",
                    desc = "Config",
                    icon = " ",
                    action = function()
                        Snacks.picker.files({
                            cwd = vim.fn
                                .stdpath("config")
                        })
                    end
                },
                { key = "P", desc = "Pack", icon = " ", action = function() vim.pack.update() end },
                { key = "m", desc = "Mason", icon = " ", action = function() vim.cmd("Mason") end },
                { key = "q", desc = "Quit", icon = " ", action = function() vim.cmd("qa") end },
            },
            header = [[
█     █░ ▄▄▄        ██████  ██▓ ██▒   █▓ ██▓ ███▄ ▄███▓
▓█░ █ ░█░▒████▄    ▒██    ▒ ▓██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▒█░ █ ░█ ▒██  ▀█▄  ░ ▓██▄   ▒██▒ ▓██  █▒░▒██▒▓██    ▓██░
░█░ █ ░█ ░██▄▄▄▄██   ▒   ██▒░██░  ▒██ █░░░██░▒██    ▒██
░░██▒██▓  ▓█   ▓██▒▒██████▒▒░██░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▓░▒ ▒   ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░░▓     ░ ▐░  ░▓  ░ ▒░   ░  ░
▒ ░ ░    ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░   ░ ░░   ▒ ░░  ░      ░
░   ░    ░   ▒   ░  ░  ░   ▒ ░     ░░   ▒ ░░      ░
    ░          ░  ░      ░   ░        ░   ░         ░
                                    ░
        ]],
        },
        sections = {
            { section = "header" },
            { section = "keys",  gap = 1, padding = 1 },
            {
                text = {
                    { require("utils.startup").format(), hl = "SnacksDashboardFooter" },
                },
                padding = 1,
            },
        },
    },
})

vim.notify = Snacks.notifier

local map = vim.keymap.set

-- Top pickers
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })

-- find
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fF", function() Snacks.picker.files({ cwd = "~" }) end, { desc = "Find Files (Home)" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

-- git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
map("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- gh
-- map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
-- map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
-- map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub PRs (open)" })
-- map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub PRs (all)" })

-- grep
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep Word" })

-- search
map("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
map("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP (via snacks picker)
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
-- map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
-- map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "Calls Incoming" })
-- map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "Calls Outgoing" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- other
map("n", "<leader>uz", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
map("n", "<leader>uZ", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
map("n", "<leader>un", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>uN", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- terminals
map("n", "<leader>bt", function()
    Snacks.terminal(nil, {
        cwd = vim.fn.expand("%:p:h"),
        win = { position = "bottom", height = 0.5 },
    })
end, { desc = "Terminal (bottom) cwd" })

map("n", "<leader>ft", function()
    Snacks.terminal(nil, {
        cwd = vim.fn.expand("%:p:h"),
        win = require("utils.win").float,
    })
end, { desc = "Floating Terminal (cwd)" })

map("n", "<leader>fT", function()
    Snacks.terminal(nil, {
        cwd = require("utils.root").get(),
        win = require("utils.win").float,
    })
end, { desc = "Floating Terminal (cwd)" })

