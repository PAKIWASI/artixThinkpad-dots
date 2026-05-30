
---@type vim.lsp.Config
return {
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
