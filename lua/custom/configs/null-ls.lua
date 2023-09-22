-- config 1
--
-- local null_ls = require "null-ls"
--
-- local b = null_ls.builtins
--
-- local sources = {
--
--   -- webdev stuff
--   b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
--   b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
--
--   -- Lua
--   b.formatting.stylua,
--
--   -- cpp
--   b.formatting.clang_format,
-- }
--
-- null_ls.setup {
--   debug = true,
--   sources = sources,
--   on_attach = function(client)
--     if client.resolved_capabilites.document_formatting then
--       vim.cmd "autocmd BurfWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
--     end
--   end,
-- }
--
-- config 2
--
-- local augroup = vim.api.nvim_create_autocmd("LspFormatting", {})
-- local null_ls = require("null-ls")
--
-- local opts = {
--   sources = {
--     null_ls.builtins.diagnostics.eslint,
--     null_ls.builtins.formatting.prettier,
--   },
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({
--         group = augroup,
--         buffer = bufnr,
--       })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = bufnr })
--         end,
--       })
--     end
--   end
-- }
--
-- return opts
--
-- config 3

local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier.with {
    filetypes = {
      "html",--[[ , "markdown" ]]
      "css",
    },
  },
  formatting.stylua,
  formatting.eslint_d,
  formatting.black,

  lint.shellcheck,
  lint.eslint.with {
    condition = function(utils)
      return utils.root_has_file ".eslintrc.js"
    end,
  },
  lint.mypy,
  lint.ruff,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
