local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      overrides.mason,
      ensure_installed = {
        "eslint-lsp",
        "typescript-language-server",
        "prettier",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "js-debug-adapter",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn "mkdp#util#install"
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      -- Set header
      dashboard.section.header.val = {
        [[⠀⠀⠀⠀⠀⡾⠚⠁⢠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡆⢷⡀⠱⣄⠙⢦⡀⣾⠋⠀⠀⠀]],
        [[⢀⡀⠀⠀⠀⠀⠀⡴⠁⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣼⣿⣦⡈⠻⢶⣿⠃⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⢀⡞⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠀⠀⠀⠀⠀⠀⠀⠀⠙⡿⢯⣉⠁⠀⠘⢷⡄⠀⠀⠀]],
        [[⠀⠀⠀⠀⢀⠎⠀⠀⠀⠀⣸⡟⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⡄⡠⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢡⠀⢹⡍⢿⡇⠀⢹⡀⠀⠀]],
        [[⠀⠀⠀⢀⡎⠀⠀⠀⠀⠀⡟⠀⠀⠀⠀⠀⠀⠀⠀⢰⠃⠀⠀⠀⠀⠀⣼⡗⠀⠀⠀⡏⠀⠀⢀⠀⠀⠀⠀⢸⠀⠀⢣⠘⣇⠀⠀⢧⠀⠀]],
        [[⠀⠀⠀⡜⠀⠀⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⣼⠋⠀⠀⠀⠸⠀⠀⠀⢸⠀⠀⠀⠀⢸⠀⠀⠘⡆⢹⡆⢡⡈⢆⠀]],
        [[⠀⠀⢰⠁⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⣰⡿⠁⠀⠀⠀⠀⢀⠜⠁⠀⠀⠀⢠⠇⠀⠀⠀⡇⠀⠀⠀⠀⡾⡇⠀⠀⢣⠘⣿⣄⢱⠀⠳]],
        [[⡀⢀⠇⠀⠀⢀⠜⠁⢀⠔⠁⠀⠀⠀⢀⣾⡟⠀⠀⠀⠀⣠⠖⠁⢀⡴⠀⠀⢀⡾⠀⠀⢀⣾⠀⠀⠀⠀⢿⣧⡇⢻⣦⡉⠑⠉⠁⠀⢸⣿]],
        [[⠁⣾⠀⠀⣴⡯⠤⠴⢧⣤⡄⣀⣀⣰⣯⠎⠀⠀⢀⣤⠊⠀⠀⣠⠏⠀⠀⢀⣾⠃⠀⢀⣾⡏⠀⠀⠀⠀⣿⣿⣿⠀⠙⢿⣆⣀⠀⣠⣺⣿]],
        [[⢀⡏⠀⠀⠀⠀⠀⠀⢸⣯⠇⠀⠈⠀⠬⠤⠤⠤⣤⡃⢉⡽⠚⠥⠤⣀⣀⣾⣃⣀⣠⣞⣏⣀⠀⠀⠀⣸⣿⣿⣿⠀⠙⢿⣿⠦⣈⠻⢿⣿]],
        [[⡞⡇⠀⠀⢀⣠⠔⠂⠉⠀⣀⡀⠤⠤⠀⠠⠤⠤⡀⠉⠉⠁⠀⠀⠀⠀⠀⠀⣠⣽⣿⣿⡿⡟⠋⠑⠲⢿⣼⠃⡟⠀⠀⣼⠉⠛⣯⣴⡌⠇]],
        [[⢃⡇⣠⣶⢻⠇⠀⠀⠀⠈⠀⢀⣀⡀⣀⡀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⢛⣹⣼⣧⡷⠴⠶⠖⠛⠋⠀⡇⠀⢠⠃⠀⠀⣿⠁⢳⢠]],
        [[⡿⣿⢿⢯⢸⣆⣰⣶⣶⣶⣶⣿⣿⣶⣶⣦⣍⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠻⠋⠁⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⢸⠀⠀⢣⣸⠃⠀⠀]],
        [[⢇⡟⡾⢀⣸⣻⠉⢻⡄⠀⠀⠀⠀⠀⣻⣈⣧⣿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⣠⠃⠀⢰⠃⣸⣷⠀⠀⡸]],
        [[⣼⣧⠃⡸⣿⡟⢇⠈⠻⣦⣤⡶⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡷⠁⠀⢀⠏⢠⡟⢯⠀⢀⠀]],
        [[⣿⠹⠀⡿⣿⣷⣼⡄⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠟⠁⠀⢀⡎⢠⡟⠀⡠⠚⠁⠀]],
        [[⡏⠀⢰⢱⠛⡋⠉⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⢀⡴⠃⠀⠀⢠⠎⢠⣿⣧⠎⠀⠀⠀⠀]],
        [[⠀⠀⡈⡎⠀⢡⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⢖⣉⣤⣤⠖⠉⠀⠀⢸⠀⢸⠀⢀⣼⠿⣇⠀⠀]],
        [[⠀⠀⢱⠃⠀⠀⠳⡀⢳⡀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⢖⣉⣤⣤⠖⠉⠀⠀⣠⣴⣿⣻⣿⣴⣿⣿⣧⡇⢸⣿]],
        [[⢀⣾⣿⢿⢯⢸⣆⣰⣶⣶⣶⣶⣿⣿⣶⣶⣦⣍⣁⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠻⠋⠁⠀⠀⠀⠀⠀⠀⠸⡄⠈⢿⣿⠀⠸⣿⠀⠈⠻⢽⣋]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⡏⢿⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠈⡇⠀⠀⡇⠀⠈⡄⢧⠀⠀⠀]],
        [[⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⢱⠀⠀⢱⠀⠀⢣⣸⠃⠀⠀]],
        [[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠉⠑⠉⠛⢿⡟⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⢛⣹⣼⣧⡷⠴⠶⠖⠛⠋⠀⡇⠀⢸⠀⢀⣼⠿⣇⠀⠀]],
        [[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠡⠒⠒⠒⡼⣯⢯⡇⠀⡾⢿⣿⣶]],
      }

      -- set footer
      dashboard.section.footer.val = "all for one"

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("f", "󰱼  > find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("n", "  > new file", "<cmd>ene<CR>"),
        dashboard.button("p", "  > projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("r", "󰁯  > recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  > find text", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("q", "  > quit nvim", "<cmd>qa<CR>"),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
    event = "VimEnter",
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VimEnter",
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings "dap"
      require "custom.configs.dap"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_existed["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup {
        api_key_cmd = "echo $OPENAI_API_KEY",
      }
    end,
  },
  {
    "tpope/vim-surround",
    init = function()
      vim.o.timeoutlen = 500
    end,
    event = "VimEnter",
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "yarn global add live-server",
    config = true,
    event = "VeryLazy",
  },
  -- {
  -- "neovim/nvim-lspconfig",
  --
  --  dependencies = {
  --    "jose-elias-alvarez/null-ls.nvim",
  --    config = function()
  --      require "custom.configs.null-ls"
  --    end,
  --  },
  --  config = function()
  --     require "plugins.configs.lspconfig"
  --     require "custom.configs.lspconfig"
  --  end,
  -- },
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
