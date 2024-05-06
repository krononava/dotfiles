-- Personal defaults
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

vim.keymap.set('v', 'jk', '<Esc>')
vim.keymap.set('v', 'kj', '<Esc>')

vim.keymap.set('c', 'jk', '<Esc>')
vim.keymap.set('c', 'kj', '<Esc>')

vim.opt.number = true
vim.opt.clipboard = 'unnamed'
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 10

-- Start of Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {'folke/tokyonight.nvim'},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight-moon')
