local nproc = tonumber(vim.fn.system({"nproc"})) or 1
local njobs = math.max(1, nproc - 1)
local clangd_jflag = "-j=" .. njobs
local shell_jflag = " -j" .. njobs

---@type vim.lsp.Config
local config = {    -- we do this because we want to register the autocmd after the config
    cmd = {
        "clangd",
        "--enable-config",
        "--background-index",
        clangd_jflag,
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--fallback-style=llvm",
        "--query-driver=/usr/bin/clang*",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    -- capabilities = {
    --     offsetEncoding = { "utf-8", "utf-16" },
    -- },
    single_file_support = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = {'*.c', '*.h', '*.cpp', '*.hpp'},
    group = vim.api.nvim_create_augroup("ClangdAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "clangd" then return end

        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        local float = require("utils.win").float;

        map("<leader>ch", function()
            require("utils.src_header_switcher").switcher(ev.buf)
        end, "Switch Source/Header")

        map("<leader>cc", function()
            local ft = vim.bo.filetype
            vim.ui.input({ prompt = "File Name/Class Name: " }, function(input)
                if input and input ~= "" then
                    if ft == "c" or ft == "h" then
                        Snacks.terminal("Cpair " .. input, { win = float })
                    else
                        Snacks.terminal("CPPpair " .. input, { win = float})
                    end
                end
            end)
        end, "Create Source/Header Pair")

        map("<leader>cb", function()
            Snacks.terminal("ninja -C build" .. shell_jflag .. "; exec $SHELL", { win = float })
        end, "Build Project (Ninja)")

        map("<leader>cx", function()
            Snacks.terminal("./build/main; exec $SHELL", { win = float})
        end, "Run Project")

        map("<leader>cX", function()
            Snacks.terminal("ninja -C build" .. shell_jflag .. " && ./build/main; exec $SHELL", { win = float})
        end, "Build and Run")
    end,
})

return config
