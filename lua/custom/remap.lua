-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Move visual selection up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv ")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv ")

-- Join line without moving cursor to the end
vim.keymap.set('n', 'J', 'mzJ`z')

-- Scroll half page up/down while keeping cursor centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Go to next/previous search match while keepiing cursor centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Delete selection into void register and paste, preserving the paste content
vim.keymap.set('x', '<leader>p', '"_dP')

-- Y yanks to the end of current line, similar to C and D
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Yank into system clipboard register
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y"')
vim.keymap.set({ 'n', 'v' }, '<leader>yy', '"+yy"')
vim.keymap.set({ 'n' }, '<leader>Y', '"+Y"')

-- Delete into void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d"')
vim.keymap.set({ 'n', 'v' }, '<leader>dd', '"_dd"')

-- Move to next/previous in the quickfix list while keeping cursor centered
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')

-- Move to next/previous in the location list while keeping cursor centered
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Find and replace the current word under the cursor globally
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
