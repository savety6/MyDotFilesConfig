require "nvchad.options"

local o = vim.o

-- Relative line numbers (shows offset for easy jumping with 5j, 10k, etc.)
o.relativenumber = true
o.number = true -- shows actual line number on current line

-- Cursor line
o.cursorlineopt = "both"
