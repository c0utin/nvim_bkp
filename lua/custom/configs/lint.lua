require('lint').linters_by_fit = {
  javascript = {'eslint'},
  typescript = {'eslint'}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
