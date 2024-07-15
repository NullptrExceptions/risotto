vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
    renderer = {
        icons = {
            web_devicons = {
                file = {
                    enable = false
                }
            }
        }
    } 
}
