local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")



-- verify C/C++ adapter exists
local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
if vim.fn.executable(codelldb_path) ~= 1 then
    vim.notify("codelldb is not installed", vim.log.levels.ERROR)
    return
end

-- C/C++ Adapter
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
    },
}


-- default debug build/main
local function get_path()
    local path = vim.fn.input("Path to exe: (root)/")
    if path == "" then
        path = "build/main"
    end
    return vim.fn.getcwd() .. "/" .. path
end


-- C/C++ Configuration with ASan support
dap.configurations.c = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = get_path,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        -- ASan environment variables
        env = {
            -- Allow debugger to work with ASan
            ASAN_OPTIONS = "detect_leaks=1:halt_on_error=0:abort_on_error=0",
            LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
        },
        -- Important for ASan debugging
        initCommands = {
            -- Handle ASan signals gracefully
            "settings set target.process.stop-on-exec false",
        },
    },
    {
        name = "Launch (ASan - no halt)",
        type = "codelldb",
        request = "launch",
        program = get_path,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        env = {
            -- Continue execution after ASan error
            ASAN_OPTIONS = "detect_leaks=1:halt_on_error=0:abort_on_error=0:log_path=" ..
                vim.fn.getcwd() .. "/asan.log",
            LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
        },
        initCommands = {
            "settings set target.process.stop-on-exec false",
        },
    },
    {
        name = "Launch (ASan - halt on error)",
        type = "codelldb",
        request = "launch",
        program = get_path,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        env = {
            -- Stop on ASan error for debugging
            ASAN_OPTIONS = "detect_leaks=1:halt_on_error=1:abort_on_error=1",
            LSAN_OPTIONS = "suppressions=" .. vim.fn.getcwd() .. "/lsan.supp",
        },
    },
}
dap.configurations.cpp = dap.configurations.c




-- DAP UI


dap_virtual_text.setup({
    -- virt_text_pos = 'eol',
})

ui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.40 },
                { id = "breakpoints", size = 0.20 },
                { id = "stacks",      size = 0.20 },
                { id = "watches",     size = 0.20 },
            },
            size = 0.30,  -- width as fraction of total
            position = "left",
        },
        {
            elements = {
                { id = "repl",    size = 0.60 },  -- give repl more space
                { id = "console", size = 0.40 },
            },
            size = 0.30,  -- height as fraction of total
            position = "bottom",
        },
    },
})

-- Breakpoint Signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped',
    { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStopped' })
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e3440' })

-- Auto open/close
dap.listeners.before.launch.dapui_config = function()
    ui.open()
    vim.o.mouse = "a"  -- enable mouse
end

dap.listeners.before.attach.dapui_config = function()
    ui.open()
    vim.o.mouse = "a"
end

dap.listeners.after.event_terminated.dapui_config = function()
    ui.close()
    vim.o.mouse = ""   -- disable mouse
end

dap.listeners.after.event_exited.dapui_config = function()
    ui.close()
    vim.o.mouse = ""
end


local map = vim.keymap.set
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = "Breakpoint Condition" })
map("n", "<leader>dc", function() dap.continue() end, { desc = "Run/Continue" })
map("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
map("n", "<leader>dg", function() dap.goto_() end, { desc = "Go to Line (No Execute)" })
map("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
map("n", "<leader>dj", function() dap.down() end, { desc = "Down" })
map("n", "<leader>dk", function() dap.up() end, { desc = "Up" })
map("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
map("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
map("n", "<leader>dO", function() dap.step_over() end, { desc = "Step Over" })
map("n", "<leader>dp", function() dap.pause() end, { desc = "Pause" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
map("n", "<leader>ds", function() dap.session() end, { desc = "Session" })
map("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
map("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
map({"n", "v"}, "<leader>de", function() ui.eval() end,     { desc = "Eval" })
local dapui_open = false
map("n", "<leader>du", function()
    ui.toggle({})
    dapui_open = not dapui_open
    vim.o.mouse = dapui_open and "a" or ""
end, { desc = "Dap UI" })

-- map("n", "<leader>dr", function()
--     dap.repl.toggle({
--         height = 20,
--         width = 80,
--     }, "split")   -- "split", "vsplit", or "tabedit"
-- end, { desc = "Toggle REPL" })

