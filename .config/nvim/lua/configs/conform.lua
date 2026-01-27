local options = {
  formatters_by_ft = {
    -- ═══════════════════════════════════════════════════════════════════
    -- Web Development
    -- ═══════════════════════════════════════════════════════════════════

    -- Lua
    lua = { "stylua" },

    -- JavaScript / TypeScript ecosystem
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },

    -- Web markup & styles
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },

    -- Data formats
    json = { "prettierd" },
    jsonc = { "prettierd" },
    yaml = { "prettierd" },

    -- Documentation
    markdown = { "prettierd" },

    -- GraphQL
    graphql = { "prettierd" },

    -- ═══════════════════════════════════════════════════════════════════
    -- Backend Development
    -- ═══════════════════════════════════════════════════════════════════

    -- Go (goimports for imports, gofumpt for formatting, golines for long lines)
    go = { "goimports", "gofumpt", "golines" },

    -- Python (ruff for linting + isort-like imports, black for formatting)
    python = { "ruff_format", "ruff_fix" },

    -- Java
    java = { "google-java-format" },

    -- Kotlin
    kotlin = { "ktlint" },

    -- Rust (uses rustfmt via LSP, but can also use conform)
    rust = { "rustfmt" },

    -- SQL
    sql = { "sql_formatter" },

    -- Proto
    proto = { "buf" },

    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    -- TOML (for Cargo.toml, pyproject.toml, etc.)
    toml = { "taplo" },

    -- ═══════════════════════════════════════════════════════════════════
    -- C/C++ & Systems
    -- ═══════════════════════════════════════════════════════════════════

    -- C/C++
    c = { "clang-format" },
    cpp = { "clang-format" },

    -- CMake
    cmake = { "cmake_format" },
  },

  -- Format on save
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },

  -- Formatter-specific options
  formatters = {
    -- Go: limit line length
    golines = {
      prepend_args = { "--max-len=120", "--base-formatter=gofumpt" },
    },
    -- Shell formatting
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
    -- Rust (ensure edition is detected)
    rustfmt = {
      prepend_args = { "--edition", "2021" },
    },
    -- C/C++ formatting style
    ["clang-format"] = {
      prepend_args = {
        "--style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 100}",
      },
    },
  },
}

return options
