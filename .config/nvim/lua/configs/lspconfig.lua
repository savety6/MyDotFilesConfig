require("nvchad.configs.lspconfig").defaults()

-- ═══════════════════════════════════════════════════════════════════
-- LSP Server Configurations for Fullstack Web Development
-- ═══════════════════════════════════════════════════════════════════

-- Servers with default configuration (no special settings needed)
local default_servers = {
  "html",
  "cssls",
  "marksman",
}

-- Enable default servers
vim.lsp.enable(default_servers)

-- ───────────────────────────────────────────────────────────────────
-- TypeScript / JavaScript (ts_ls)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("ts_ls", {
  init_options = {
    preferences = {
      disableSuggestions = false,
      importModuleSpecifierPreference = "relative",
      includeCompletionsForModuleExports = true,
      includeCompletionsWithSnippetText = true,
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})
vim.lsp.enable("ts_ls")

-- ───────────────────────────────────────────────────────────────────
-- Tailwind CSS
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
    },
  },
})
vim.lsp.enable("tailwindcss")

-- ───────────────────────────────────────────────────────────────────
-- Emmet (HTML/CSS abbreviations)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("emmet_ls", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})
vim.lsp.enable("emmet_ls")

-- ───────────────────────────────────────────────────────────────────
-- ESLint
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("eslint", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    workingDirectories = { mode = "auto" },
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
  },
  on_attach = function(client, bufnr)
    -- Auto-fix ESLint issues on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "silent! EslintFixAll",
    })
  end,
})
vim.lsp.enable("eslint")

-- ───────────────────────────────────────────────────────────────────
-- JSON (with schema support for package.json, tsconfig, etc.)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { "nest-cli.json" },
          url = "https://json.schemastore.org/nest-cli.json",
        },
      },
      validate = { enable = true },
    },
  },
})
vim.lsp.enable("jsonls")

-- ═══════════════════════════════════════════════════════════════════
-- Backend Language Servers
-- ═══════════════════════════════════════════════════════════════════

-- ───────────────────────────────────────────────────────────────────
-- Go (gopls)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

-- ───────────────────────────────────────────────────────────────────
-- Python (pyright + ruff)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- using ruff for this
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "standard",
      },
    },
  },
})
vim.lsp.enable("pyright")

-- Ruff (fast Python linter + formatter)
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      lineLength = 88,
      lint = {
        select = { "E", "F", "W", "I", "UP", "B", "C4", "SIM" },
      },
    },
  },
})
vim.lsp.enable("ruff")

-- ───────────────────────────────────────────────────────────────────
-- Java (jdtls) - basic config, for full features use nvim-jdtls plugin
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("jdtls", {
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
})
vim.lsp.enable("jdtls")

-- ───────────────────────────────────────────────────────────────────
-- Kotlin
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("kotlin_language_server", {
  settings = {
    kotlin = {
      compiler = {
        jvm = {
          target = "17",
        },
      },
      hints = {
        typeHints = true,
        parameterHints = true,
        chainedhints = true,
      },
    },
  },
})
vim.lsp.enable("kotlin_language_server")

-- ───────────────────────────────────────────────────────────────────
-- Rust (rust-analyzer)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always" },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")

-- ═══════════════════════════════════════════════════════════════════
-- C/C++ and Systems Programming
-- ═══════════════════════════════════════════════════════════════════

-- ───────────────────────────────────────────────────────────────────
-- C/C++ (clangd)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--all-scopes-completion",
    "--pch-storage=memory",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  on_attach = function(client, bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr, silent = true }
    -- Clangd-specific keybindings
    map("n", "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>",
      vim.tbl_extend("force", opts, { desc = "Switch source/header" }))
    map("n", "<leader>ci", "<cmd>ClangdSymbolInfo<cr>",
      vim.tbl_extend("force", opts, { desc = "Symbol info" }))
    map("n", "<leader>ch", "<cmd>ClangdTypeHierarchy<cr>",
      vim.tbl_extend("force", opts, { desc = "Type hierarchy" }))
  end,
})
vim.lsp.enable("clangd")

-- ───────────────────────────────────────────────────────────────────
-- CMake (neocmakelsp)
-- ───────────────────────────────────────────────────────────────────
vim.lsp.config("neocmake", {
  filetypes = { "cmake" },
  cmd = { "neocmakelsp", "--stdio" },
  root_markers = { "CMakeLists.txt", "cmake" },
  init_options = {
    format = { enable = true },
    lint = { enable = true },
    scan_cmake_in_package = true,
  },
})
vim.lsp.enable("neocmake")

-- ═══════════════════════════════════════════════════════════════════
-- Read :h vim.lsp.config for changing options of lsp servers
-- ═══════════════════════════════════════════════════════════════════
