
---@type vim.lsp.Config
local config =  {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },

      suggest = {
        completeFunctionCalls = true,
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
      },

      preferences = {
        includePackageJsonAutoImports = "auto",
        importModuleSpecifier = "relative",
        jsxAttributeCompletionStyle = "auto",
        allowTextChangesInNewFiles = true,
      },
    },

    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },

      suggest = {
        completeFunctionCalls = true,
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
      },

      preferences = {
        includePackageJsonAutoImports = "auto",
        importModuleSpecifier = "relative",
        allowTextChangesInNewFiles = true,
      },

      format = {
        enable = false,
      },
    },

    implicitProjectConfiguration = {
      checkJs = true,
      experimentalDecorators = true,
      jsx = "react-jsx",
      target = "ES2022",
      lib = { "ES2022", "DOM", "DOM.Iterable" },
      moduleResolution = "node",
      allowSyntheticDefaultImports = true,
      esModuleInterop = true,
      strict = false,
      skipLibCheck = true,
      resolveJsonModule = true,
      allowJs = true,
      declaration = false,
      isolatedModules = true,
    },

    workspaceSymbols = {
      scope = "allOpenProjects",
    },
  },
}



vim.api.nvim_create_autocmd("LspAttach", {
    pattern = {'*.js', '*.ts', '*.jsx', '*.tsx'},
    group = vim.api.nvim_create_augroup("TypescriptAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "ts_ls" then return end

        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        map("<leader>cA", function ()
            vim.cmd('LspTypescriptSourceAction')
        end, "Extended Code Action")

    end
})

return config
