

---@type vim.lsp.Config
return {
    filetypes = {
        "kotlin",
    },

    root_markers = {
        "settings.gradle.kts",
        "settings.gradle",
        "build.gradle.kts",
        "build.gradle",
        "gradle.properties",
        "pom.xml",
        ".git",
    },

    single_file_support = true,

    settings = {
        kotlin = {
            compiler = {
                jvm = {
                    target = "26",
                },
            },

            completion = {
                snippets = {
                    enabled = true,
                },
            },

            indexing = {
                enabled = true,
            },

            inlayHints = {
                typeHints = true,
                parameterHints = true,
                chainedHints = true,
            },

            -- debugAdapter = {
            --     enabled = true,
            -- },

            -- externalSources = {
            --     autoConvertToKotlin = true,
            --     useKlsScheme = true,
            -- },

            -- trace = {
            --     server = "off",
            -- },
        },
    },
}
