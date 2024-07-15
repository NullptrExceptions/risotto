local Plug = vim.fn['plug#']

-- Plugins, with vim-plug
vim.call('plug#begin')
    -- Syntax Highlighting & Linting
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

    -- Theme & Aesthetics
    Plug('freddiehaddad/feline.nvim')
    Plug('romgrk/barbar.nvim')
    Plug('lukas-reineke/indent-blankline.nvim')
    Plug('sainnhe/gruvbox-material')
    Plug('nvim-tree/nvim-web-devicons')

    -- Functionality
    Plug('nvim-tree/nvim-tree.lua')
    Plug('akinsho/toggleterm.nvim')
vim.call('plug#end')

-- Aesthetics
vim.opt.termguicolors = true
vim.cmd([[ colorscheme gruvbox-material ]])

-- Treesitter
require('user.treesitter')

-- Feline
require('user.feline')

-- Barbar
require('user.barbar')

-- Nvim-Tree
require('user.nvim-tree')

-- Toggleterm
require('user.toggleterm')

-- Indent-Blankline
require('user.indent-blankline')

-- Keybinds
vim.keymap.set({'n', 'i', 'v'}, '<F1>', '<Nop>')
vim.keymap.set('n', '<F2>', ':BufferNext<CR>')
vim.keymap.set('n', '<F3>', ':BufferPrevious<CR>')
vim.keymap.set('n', '<F5>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<F8>', ':bd<CR>')

-- Tabs
vim.o.tabstop = 8      
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 8
vim.o.smarttab = true

-- Cursor
vim.cmd([[ highlight Cursor gui=NONE guifg=bg guibg=fg ]])
vim.o.guicursor = "i:ver100-Cursor"

-- Misc
vim.o.number = true
vim.o.mouse = 'a'
