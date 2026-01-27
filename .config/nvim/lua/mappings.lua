require "nvchad.mappings"

local map = vim.keymap.set

-- ═══════════════════════════════════════════════════════════════════
-- General
-- ═══════════════════════════════════════════════════════════════════
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- ═══════════════════════════════════════════════════════════════════
-- LSP
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- ═══════════════════════════════════════════════════════════════════
-- Trouble (Diagnostics)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble buffer diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Trouble quickfix" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Trouble symbols" })

-- ═══════════════════════════════════════════════════════════════════
-- Todo Comments
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Trouble TODOs" })
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next TODO" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous TODO" })

-- ═══════════════════════════════════════════════════════════════════
-- Git
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle git blame" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
map("n", "<leader>gl", "<cmd>Telescope git_commits<cr>", { desc = "Git log" })
map("n", "<leader>gB", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })

-- ═══════════════════════════════════════════════════════════════════
-- Supermaven AI
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>at", function()
  require("supermaven-nvim.api").toggle()
  local status = require("supermaven-nvim.api").is_running() and "enabled" or "disabled"
  vim.notify("Supermaven " .. status, vim.log.levels.INFO)
end, { desc = "Toggle Supermaven AI" })

-- ═══════════════════════════════════════════════════════════════════
-- Quick actions
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
