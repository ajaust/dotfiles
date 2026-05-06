-- Show vertical line for 80 and 90 characters
vim.opt.colorcolumn = "80,90"

-- Disable swap/backup, use custom undodir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Allow filenames with @
vim.opt.isfname:append("@-@")

-- Some netrw settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Python indentation
-- https://neovim.io/doc/user/indent.html#ft-python-indent
vim.g.python_indent = {}
vim.g.python_indent.disable_parentheses_indenting = false
vim.g.python_indent.closed_paren_align_last_line = false
vim.g.python_indent.searchpair_timeout = 150
vim.g.python_indent.continue = 'shiftwidth()'
vim.g.python_indent.open_paren = 'shiftwidth()'
vim.g.python_indent.nested_paren = 'shiftwidth()'

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = '[U]ndoTree Toggle' })

-- Remaps to copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = '[Y]ank to clipboard' })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = '[Y]ank to clipboard' })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = '[Y]ank line to clipboard' })

-- Telescope grep with prompt
vim.keymap.set('n', '<leader>ps', function()
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = '[P]roject [S]earch (grep prompt)' })
