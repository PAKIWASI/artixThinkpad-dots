
require("oil").setup({
    default_file_explorer = true,
    columns = { "git_status", "icon" },
    view_options = {
        show_hidden = true,
    },
    win_options = {
        signcolumn = "yes:2",
    },
    keymaps = {
        ["<CR>"] = {
            callback = function()
                local oil = require("oil")
                local entry = oil.get_cursor_entry()
                if entry and entry.type == "file" then
                    local dir = oil.get_current_dir()
                    local filepath = dir .. entry.name
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.bo[buf].filetype
                        if ft ~= "oil" and ft ~= "image" then
                            vim.api.nvim_set_current_win(win)
                            vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                            return
                        end
                    end
                    vim.cmd("wincmd l")
                    if vim.bo.filetype == "oil" then
                        vim.cmd("vsplit")
                    end
                    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                else
                    oil.select()
                end
            end,
            desc = "Open file",
        },
    },
})

require("oil-git-signs").setup({
    git_shell_cmd = {
        "git", "-c", "status.relativePaths=false",
        "status", "--short", "--untracked-files=all", "--ignored",
    },
})

local map = vim.keymap.set

map("n", "<leader>oo", function() require("oil").open() end,  { desc = "Oil: Open cwd" })
map("n", "<leader>of", "<cmd>Oil --float<cr>",                { desc = "Oil: Float (cwd)" })
map("n", "<leader>oq", "<cmd>bd<cr>",                         { desc = "Oil: Close" })
map("n", "<leader>ow", "<cmd>w<cr>",                          { desc = "Oil: Write Changes" })

local function toggle_sidebar(dir)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "oil" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end
    vim.cmd("topleft vsplit")
    vim.cmd("vertical resize 32")
    vim.cmd("Oil " .. (dir or ""))
    vim.cmd("wincmd p")
end

map("n", "<leader>e", function() toggle_sidebar() end,              { desc = "Oil: Sidebar (cwd)" })
map("n", "<leader>E", function() toggle_sidebar(vim.fn.getcwd()) end, { desc = "Oil: Sidebar (root)" })


