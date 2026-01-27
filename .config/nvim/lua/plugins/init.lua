return {
  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  -- Mason - ensure LSP servers are installed
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Web LSP servers
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        "eslint-lsp",
        "json-lsp",
        "marksman",
        -- Backend LSP servers
        "gopls",
        "pyright",
        "ruff",
        "jdtls",
        "kotlin-language-server",
        "rust-analyzer",
        -- C/C++ LSP servers
        "clangd",
        "neocmakelsp",
        -- Web Formatters
        "prettierd",
        "stylua",
        -- Backend Formatters & Linters
        "gofumpt",
        "goimports",
        "golines",
        "black",
        "isort",
        "google-java-format",
        "ktlint",
        -- C/C++ Formatters
        "clang-format",
        "cmake-format",
        -- DAP (Debuggers)
        "delve",
        "debugpy",
        "codelldb",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Treesitter for syntax highlighting & more
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Web development
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "scss",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "graphql",
        "prisma",
        "yaml",
        "toml",
        -- Backend languages
        "go",
        "gomod",
        "gosum",
        "gowork",
        "python",
        "java",
        "kotlin",
        "rust",
        "sql",
        "proto",
        -- C/C++/CMake
        "c",
        "cpp",
        "cmake",
        "make",
        -- General
        "vim",
        "lua",
        "vimdoc",
        "bash",
        "regex",
        "gitignore",
        "dockerfile",
      },
    },
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- Web Development Plugins
  -- ═══════════════════════════════════════════════════════════════════

  -- Auto close/rename HTML & JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "xml",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Color preview for CSS colors (#fff, rgb(), hsl(), etc.)
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        css = true,
        css_fn = true,
        mode = "virtualtext",
      },
      filetypes = {
        "css",
        "scss",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    },
  },

  -- Tailwind CSS Tools - class sorting, concealing, color hints
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    ft = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("tailwind-tools").setup {
        server = {
          override = false, -- don't touch LSP, we handle it in lspconfig.lua
        },
        document_color = {
          enabled = true,
          kind = "inline",
          inline_symbol = "󰝤 ",
          debounce = 200,
        },
        conceal = {
          enabled = false,
          min_length = 50,
          symbol = "󱏿",
        },
        cmp = {
          highlight = "foreground",
        },
      }
    end,
    keys = {
      { "<leader>tw", "<cmd>TailwindConcealToggle<cr>", desc = "Toggle Tailwind conceal" },
      { "<leader>tc", "<cmd>TailwindColorToggle<cr>", desc = "Toggle Tailwind colors" },
      { "<leader>ts", "<cmd>TailwindSort<cr>", desc = "Sort Tailwind classes" },
    },
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- React / React Native
  -- ═══════════════════════════════════════════════════════════════════

  -- Extract JSX into new components
  {
    "napmn/react-extract.nvim",
    ft = { "javascriptreact", "typescriptreact" },
    config = function()
      require("react-extract").setup()
    end,
    keys = {
      {
        "<leader>Re",
        function()
          require("react-extract").extract_to_new_file()
        end,
        mode = "v",
        desc = "Extract to new component file",
      },
      {
        "<leader>Rc",
        function()
          require("react-extract").extract_to_current_file()
        end,
        mode = "v",
        desc = "Extract to current file",
      },
    },
  },

  -- Smart useState renaming
  {
    "olrtg/nvim-rename-state",
    ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
    keys = {
      {
        "<leader>Rs",
        function()
          require("nvim-rename-state").rename()
        end,
        desc = "Rename useState pair",
      },
    },
  },

  -- React/React Native snippets for LuaSnip
  {
    "mlaursen/vim-react-snippets",
    ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
    config = function()
      require("vim-react-snippets").lazy_load()
    end,
  },

  -- Package.json version management
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup {
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm", -- or "yarn", "pnpm", "bun"
      }
    end,
    keys = {
      { "<leader>Ps", "<cmd>lua require('package-info').show()<cr>", desc = "Show package versions" },
      { "<leader>Ph", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package versions" },
      { "<leader>Pt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle package versions" },
      { "<leader>Pu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>Pd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>Pi", "<cmd>lua require('package-info').install()<cr>", desc = "Install new package" },
      { "<leader>Pc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
    },
  },

  -- Highlight TODO, FIXME, HACK, NOTE comments
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Surround text with brackets, quotes, tags
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- UI Enhancements
  -- ═══════════════════════════════════════════════════════════════════

  -- Noice - beautiful command line, messages, and popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = true },
      },
      -- Disable popup notifications - use mini view at bottom instead
      notify = {
        enabled = false, -- disable nvim-notify integration
      },
      messages = {
        enabled = true,
        view = "mini", -- use mini view at bottom for messages
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- centered popup
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "40%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "NormalFloat",
              FloatBorder = "FloatBorder",
            },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        -- Mini view stays longer and is at the bottom
        mini = {
          timeout = 5000, -- 5 seconds instead of default
          position = {
            row = -2,
            col = "100%",
          },
        },
      },
      routes = {
        -- Hide "written" messages
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- Hide search count messages
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- Send long messages to split
        {
          filter = {
            event = "msg_show",
            min_height = 10,
          },
          view = "split",
        },
      },
    },
    keys = {
      {
        "<leader>nl",
        function()
          require("noice").cmd "last"
        end,
        desc = "Noice last message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd "history"
        end,
        desc = "Noice history",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd "all"
        end,
        desc = "Noice all messages",
      },
      {
        "<leader>nd",
        function()
          require("noice").cmd "dismiss"
        end,
        desc = "Dismiss all notifications",
      },
    },
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- Navigation & Productivity
  -- ═══════════════════════════════════════════════════════════════════

  -- Harpoon - quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon add file",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon menu",
      },
      {
        "<leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon file 4",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Harpoon prev",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Harpoon next",
      },
    },
  },

  -- Better commenting (enhances built-in NvChad Comment.nvim)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  -- Configure Comment.nvim to use ts-context-commentstring for JSX/TSX
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- AI Code Completion
  -- ═══════════════════════════════════════════════════════════════════

  -- Supermaven - blazing fast AI autocomplete
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "TelescopePrompt" },
        color = {
          suggestion_color = "#585b70",
          cterm = 244,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
      }
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- Git Tools
  -- ═══════════════════════════════════════════════════════════════════

  -- Lazygit integration (full git UI in terminal)
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Git blame inline
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      require("gitblame").setup {
        enabled = true,
        message_template = " <author> • <date> • <summary>",
        date_format = "%r",
        virtual_text_column = 80,
        delay = 500,
      }
    end,
  },

  -- Diffview - beautiful diff and merge tool
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },

  -- Neogit - magit-like git interface
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },

  -- Git conflict markers
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufRead",
    config = function()
      require("git-conflict").setup {
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- Backend Development Plugins
  -- ═══════════════════════════════════════════════════════════════════

  -- Rust - enhanced rust-analyzer integration
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            local map = vim.keymap.set
            local opts = { buffer = bufnr, silent = true }
            -- Rust-specific keybindings
            map("n", "<leader>ra", function()
              vim.cmd.RustLsp "codeAction"
            end, vim.tbl_extend("force", opts, { desc = "Rust code action" }))
            map("n", "<leader>rd", function()
              vim.cmd.RustLsp "debuggables"
            end, vim.tbl_extend("force", opts, { desc = "Rust debuggables" }))
            map("n", "<leader>rr", function()
              vim.cmd.RustLsp "runnables"
            end, vim.tbl_extend("force", opts, { desc = "Rust runnables" }))
            map("n", "<leader>rt", function()
              vim.cmd.RustLsp "testables"
            end, vim.tbl_extend("force", opts, { desc = "Rust testables" }))
            map("n", "<leader>rm", function()
              vim.cmd.RustLsp "expandMacro"
            end, vim.tbl_extend("force", opts, { desc = "Rust expand macro" }))
            map("n", "<leader>rc", function()
              vim.cmd.RustLsp "openCargo"
            end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))
            map("n", "<leader>rp", function()
              vim.cmd.RustLsp "parentModule"
            end, vim.tbl_extend("force", opts, { desc = "Rust parent module" }))
            map("n", "K", function()
              vim.cmd.RustLsp { "hover", "actions" }
            end, vim.tbl_extend("force", opts, { desc = "Rust hover" }))
          end,
        },
      }
    end,
  },

  -- Go - enhanced Go development
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup {
        lsp_cfg = false, -- we configure gopls in lspconfig
        lsp_gofumpt = true,
        lsp_keymaps = false, -- we set our own
        lsp_inlay_hints = { enable = true },
        dap_debug = true,
        dap_debug_gui = true,
        test_runner = "go",
        run_in_floaterm = true,
        floaterm = {
          position = "bottom",
          width = 0.99,
          height = 0.4,
        },
        trouble = true,
        luasnip = true,
      }
      -- Go keybindings
      local map = vim.keymap.set
      map("n", "<leader>Gr", "<cmd>GoRun<cr>", { desc = "Go run" })
      map("n", "<leader>Gt", "<cmd>GoTest<cr>", { desc = "Go test" })
      map("n", "<leader>Gf", "<cmd>GoTestFunc<cr>", { desc = "Go test function" })
      map("n", "<leader>Gc", "<cmd>GoCoverage<cr>", { desc = "Go coverage" })
      map("n", "<leader>Gi", "<cmd>GoImpl<cr>", { desc = "Go implement interface" })
      map("n", "<leader>Ge", "<cmd>GoIfErr<cr>", { desc = "Go if err snippet" })
      map("n", "<leader>Gd", "<cmd>GoDoc<cr>", { desc = "Go doc" })
      map("n", "<leader>Ga", "<cmd>GoAddTag<cr>", { desc = "Go add struct tags" })
      map("n", "<leader>GR", "<cmd>GoRemoveTag<cr>", { desc = "Go remove struct tags" })
      map("n", "<leader>Gm", "<cmd>GoModTidy<cr>", { desc = "Go mod tidy" })
    end,
  },

  -- Python - virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    ft = "python",
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>pc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
    },
    opts = {},
  },

  -- Crates.nvim - Cargo.toml helper
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        popup = {
          autofocus = true,
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
    keys = {
      {
        "<leader>Ct",
        function()
          require("crates").toggle()
        end,
        desc = "Toggle crates info",
      },
      {
        "<leader>Cu",
        function()
          require("crates").upgrade_crate()
        end,
        desc = "Upgrade crate",
      },
      {
        "<leader>CU",
        function()
          require("crates").upgrade_all_crates()
        end,
        desc = "Upgrade all crates",
      },
      {
        "<leader>Cd",
        function()
          require("crates").open_documentation()
        end,
        desc = "Open crate docs",
      },
      {
        "<leader>Cc",
        function()
          require("crates").open_crates_io()
        end,
        desc = "Open crates.io",
      },
    },
  },
}
