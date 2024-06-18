-- Realive/absolute numbers are handled by nvim-numbertoggle
--vim.opt.relativenumber = true
-- Show vertical line for 80 and 90 characters
vim.opt.colorcolumn = "80,90"
-- Use spaces for indent
--vim.o.autoindent = true
--vim.o.expandtab = true
--vim.o.tabstop = 4
--vim.o.softtabstop = 4
--vim.o.shiftwidth = 4

-- Highlight current line
vim.opt.cursorline = true
-- Highlight all occurences of current search pattern
vim.opt.hlsearch = true
-- Enable mouse integration
vim.o.mouse = "a"

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Extra telescop commands
--vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>ps', function()
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Command to clear previous search
-- :let @/ = ""
vim.api.nvim_create_user_command('ClearSearch', 'let @/ = ""', {nargs=0})
vim.keymap.set('n', '<leader>cs', ':ClearSearch<CR>', { desc = '[C]lear [S]earch'} )

-- Some netrw settings based on ThePrimeagen
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

---- ThePrimeagen yank group stuff
--local augroup = vim.api.nvim_create_augroup
--local ThePrimeagenGroup = augroup('ThePrimeagen', {})
--
--local autocmd = vim.api.nvim_create_autocmd
--local yank_group = augroup('HighlightYank', {})
--
--function R(name)
--    require("plenary.reload").reload_module(name)
--end
--
--autocmd('TextYankPost', {
--    group = yank_group,
--    pattern = '*',
--    callback = function()
--        vim.highlight.on_yank({
--            higroup = 'IncSearch',
--            timeout = 40,
--        })
--    end,
--})
--
--autocmd({"BufWritePre"}, {
--    group = ThePrimeagenGroup,
--    pattern = "*",
--    command = "%s/\\s\\+$//e",
--})

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Remaps to copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Not sure what this does
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- What does this?
vim.opt.nu = true
-- Use undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Don't scroll too much
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")


-- Set up color scheme
-- vim.cmd [[colorscheme kanagawa]]

-- Python indentation
-- https://neovim.io/doc/user/indent.html#ft-python-indent
vim.g.python_indent = {}
vim.g.python_indent.disable_parentheses_indenting = false
vim.g.python_indent.closed_paren_align_last_line = false
vim.g.python_indent.searchpair_timeout = 150
vim.g.python_indent.continue = 'shiftwidth()'
vim.g.python_indent.open_paren = 'shiftwidth()'
vim.g.python_indent.nested_paren = 'shiftwidth()'

-- Ntree shortcuts
--vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle Ntree'} )
--vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus Ntree'} )

-- Function to play around with colors.
-- This basically makes the background of the currenct color
-- scheme transparent
-- function ColorMyPencils(color)
--   color = color or "onedark"
--   vim.cmd.colorscheme(color)
--
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
--
-- ColorMyPencils()

-- Harpoon keymaps
--local mark = require("harpoon.mark")
--local ui = require("harpoon.ui")

--vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, {})
--vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, {})
--
--vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-n>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-s>", function() ui.nav_file(1) end)

-- GitHub copilot stuff
--vim.g.copilot_assume_mapped = true
--vim.g.copilot_enabled = false
--vim.cmd(":Copilot disable")
