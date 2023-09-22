-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

vim.opt.clipboard = ""

-- highligh on yank
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- habilitar o editorconfig
vim.g.editorconfig = true

-- habilitar linhas relativas
vim.opt.relativenumber = true
