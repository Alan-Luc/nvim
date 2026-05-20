return {
  -- kanagawa-paper
  {
    "thesimonho/kanagawa-paper.nvim",
    -- "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.cmd.colorscheme("kanagawa-paper-ink")
      -- vim.cmd.colorscheme('kanagawa-dragon')
      vim.cmd("highlight Normal guibg=#0a0c0d")
      vim.cmd("highlight NormalFloat guibg=#0a0c0d")
      vim.cmd("highlight FloatBorder guifg=#dcd7ba guibg=#0a0c0d")
    end
  },
  -- undotree
  { "mbbill/undotree" },
  -- t-pope
  -- "tpope/vim-surround",
  -- "tpope/vim-repeat",
  { "kylechui/nvim-surround", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-ts-autotag", opts = {} },
  "haya14busa/is.vim",
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        css = true,
        rgb_fn = true,
        hsl_fn = true,
        css_fn = true
      }
    }
  },
  "mg979/vim-visual-multi",
  "fladson/vim-kitty",
  { "nvim-treesitter/nvim-treesitter-context", opts = {} },
  "RRethy/nvim-treesitter-endwise",
  { "nvim-lua/plenary.nvim", lazy = false },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      },
      keymaps = {
        ["<leader>x"] = {
          callback = function ()
            local entry = require("oil").get_cursor_entry()
            if entry then
              local dir = require("oil").get_current_dir()
              local path = dir .. entry.name
              vim.fn.system({ "chmod", "+x", path })
              vim.notify("chmod +x " .. entry.name)
            end
          end,
          desc = "Make file executable"
        }
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false
  },
  { "qvalentin/helm-ls.nvim", ft = "helm", opts = {} },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>m", "<cmd>MaximizerToggle!<CR>", desc = "toggle maximize current split" }
    }
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 900,
    opts = {
      stages = "fade",
      timeout = 5000,
      render = "compact",
      top_down = true
    },
    -- `vim.notify = notify` runs in `config`, after lazy spec load. Callers
    -- that fire early (e.g. opencode_notify pings at startup) must wrap their
    -- vim.notify call in vim.schedule so the assignment has landed first.
    config = function (_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {}
  }
}
