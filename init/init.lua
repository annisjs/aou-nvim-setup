local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
vim.o.termguicolors = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.mouse = "a"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 5
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.api.nvim_err_writeln(
    "lazy.nvim is missing. Expected location: " .. lazypath
  )
  return
end

vim.opt.rtp:prepend(lazypath)
vim.opt.guicursor = {
    "n-v-c:block-Cursor",
    "i-ci-ve:ver25-Cursor",
    "r-cr:hor20-Cursor",
    "o:hor50-Cursor",
}

vim.defer_fn(function()
    vim.o.background = "dark"
    vim.cmd.colorscheme("tokyonight-night")

    vim.api.nvim_set_hl(0, "Cursor", {
        fg = "#1a1b26",
        bg = "#ff9e64",
    })

    vim.api.nvim_set_hl(0, "TermCursor", {
        fg = "#1a1b26",
        bg = "#ff9e64",
    })

    vim.api.nvim_set_hl(0, "CursorLineNr", {
        fg = "#ff9e64",
        bold = true,
    })
end, 200)
require("lazy").setup({
    {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({})

        treesitter.install({
            "r",
            "markdown",
            "markdown_inline",
            "yaml",
            "lua",
        }):wait(300000)
    end,
},
    {
        "R-nvim/R.nvim",
        lazy = false,
        config = function()
        require("r").setup({
            R_args = { "--quiet", "--no-save" },
            min_editor_width = 999,
            rconsole_width = 80,
    })
        end,

    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "pylint" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"

            require("tokyonight").setup({
                style = "night",
            })

            vim.cmd.colorscheme("tokyonight-night")

            vim.api.nvim_set_hl(0, "LineNr", {
                fg = "#7aa2f7",
            })

            vim.api.nvim_set_hl(0, "LineNrAbove", {
                fg = "#7aa2f7",
            })

            vim.api.nvim_set_hl(0, "LineNrBelow", {
                fg = "#7aa2f7",
            })

            vim.api.nvim_set_hl(0, "CursorLineNr", {
                fg = "#ff966c",
                bold = true,
            })
        end,
     },
        {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    },
    {
    "saghen/blink.cmp",
    version = "1.*",

    dependencies = {
        "rafamadriz/friendly-snippets",
    },

    opts = {
        keymap = {
            preset = "default",
        },

        fuzzy = {
            implementation = "lua",
        },

        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },
    },

    opts_extend = {
        "sources.default",
    },
},
   {
        "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup()
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
                desc = "Explorer",
            })
        end,
     },
     {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "esensar/nvim-dev-container",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("devcontainer").setup({})
        end,
    },
    {
        "echasnovski/mini.pairs",
    version = false,
    config = function()
        require("mini.pairs").setup()
    end,
    },
    {
        "itchyny/calendar.vim",
    },
    {
      "quarto-dev/quarto-nvim",
      dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
        "benlubas/molten-nvim",
      },
      opts = {
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime",
          never_run = { "yaml" },
        },
      },
    },
    {
      "benlubas/molten-nvim",
      build = ":UpdateRemotePlugins",
      init = function()
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_win_max_height = 15
      end,
    }
})
vim.lsp.enable("pylsp")
vim.keymap.set("n", "<leader>tt", function()
    vim.cmd("belowright 12split")
    vim.cmd("terminal")
end, { desc = "Terminal below" })

vim.api.nvim_create_user_command("DbRun", function()
  local file = vim.fn.expand("%:p")

  vim.cmd(string.format(
    "!python -c 'from databricks import sql; import pathlib; q=pathlib.Path(\"%s\").read_text(); print(q)'",
    file
  ))
end, {})

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "filename",
        color = { fg = "#ffffff", gui = "bold" },
      },
    },
  },
})

vim.keymap.set("n", "<leader>ca", "<cmd>Calendar<cr>", {
    desc = "Calendar",
})

vim.keymap.set("n", "<leader>sa", "ggVG<leader>ss", {
  remap = true,
  desc = "Run entire script",
})

local runner = require("quarto.runner")

vim.keymap.set("n", "<leader>rc", runner.run_cell, {
  desc = "Run current Quarto cell",
  silent = true,
})

vim.keymap.set("n", "<leader>rl", runner.run_line, {
  desc = "Run current line",
  silent = true,
})

vim.keymap.set("v", "<leader>r", runner.run_range, {
  desc = "Run selected R code",
  silent = true,
})

vim.keymap.set("n", "<leader>ra", runner.run_all, {
  desc = "Run all R cells",
  silent = true,
})

vim.keymap.set("n", "<leader>qp", "<cmd>QuartoPreview<CR>", {
  desc = "Preview Quarto document",
  silent = true,
})

vim.keymap.set("n", "<leader>ir", function()
  local lines = {
    "```{r}",
    "",
    "```",
  }

  vim.api.nvim_put(lines, "l", true, true)

  -- move cursor to blank line
  vim.cmd("normal! k")
end, { desc = "Insert R chunk" })

vim.schedule(function()
    vim.o.background = "dark"
    vim.cmd.colorscheme("tokyonight-night")
end)
