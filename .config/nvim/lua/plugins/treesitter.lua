
local ensure_installed = {
    "c", "cpp", "lua",
    "python", "bash", "typescript", "tsx",
    "html", "css", "javascript", "json",
    "yaml", "toml", "markdown", "regex",
}

-- install only missing parsers
local already_installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

require("nvim-treesitter").install(to_install)

-- enable highlighting, indentation per filetype
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})



