---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["J"] = { "mzJ`z" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<leader>y"] = { '"+y' },
    ["<leader>Y"] = { '"+Y' },
    ["y"] = { '"*y' },
    ["<leader>v"] = { "<C-v>" },
    ["<leader>gg"] = { ":LazyGit<CR>" },
    ["<C-a>"] = { "gg<S-v>G" },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
    ["<leader>y"] = { '"+y' },
    [">"] = { ">gv" },
    ["<"] = { "<gv" },
  },
}

-- more keybinds!

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "add breakpoint at line" },
    ["<leader>dr"] = { "<cmd> DapContinue <CR>", "run or continue the debugger" },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
    },
  },
}

return M
