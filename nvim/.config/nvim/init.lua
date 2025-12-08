local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }
  },
  "nvim-tree/nvim-web-devicons",
  {
    "ellisonleao/gruvbox.nvim", priority = 1000, config = true
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
  },
  "vim-test/vim-test",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "leafgarland/typescript-vim",
  "peitalin/vim-jsx-typescript",
  "vimwiki/vimwiki",
  "tpope/vim-obsession",
  "tpope/vim-rails",
  "feline-nvim/feline.nvim",
  "sindrets/diffview.nvim",
  "github/copilot.vim",
  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0
  --       and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --       or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     -- for example
  --     provider = "claude",
  --     providers = {
  --       claude = {
  --         endpoint = "https://api.anthropic.com",
  --         model = "claude-sonnet-4-20250514",
  --         timeout = 30000, -- Timeout in milliseconds
  --           extra_request_body = {
  --             temperature = 0.75,
  --             max_tokens = 20480,
  --           },
  --       },
  --       moonshot = {
  --         endpoint = "https://api.moonshot.ai/v1",
  --         model = "kimi-k2-0711-preview",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 32768,
  --         },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
})
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').fuzzy_with_index_bias,
    prompt_prefix = " ",
    selection_caret = " ",
    color_devicons = true,
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    search_history = {
      theme = "ivy",
    },
    registers = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
  },
  extensions = {
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.search_history, {})
vim.keymap.set('n', '<leader>r', builtin.registers, {})
vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

vim.keymap.set('n', '<leader>gb', '<Cmd>BlameToggle window<CR>', {})

require('feline-configured')

vim.keymap.set('n', '<leader>t', '<Cmd>TestNearest<CR>')
vim.keymap.set('n', '<leader>T', '<Cmd>TestFile<CR>')
vim.keymap.set('n', '<leader>L', '<Cmd>TestLast<CR>')

vim.keymap.set('n', '<leader>l', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<leader>h', '<Cmd>bprevious<CR>')
vim.keymap.set('n', '<leader>q', '<Cmd>bp <BAR> bd #<CR>')
vim.keymap.set('n', '<leader>do', '<Cmd>DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dx', '<Cmd>DiffviewClose<CR>')
vim.keymap.set('n', '<leader>db', '<Cmd>DiffviewOpen main...HEAD<CR>')
vim.keymap.set('n', '<leader>dc', '<Cmd>DiffviewOpen HEAD~1<CR>')

local harpoon = require('harpoon')
harpoon:setup({})

-- basic harpoon / telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>H", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>A", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>o", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>i", function() harpoon:list():next() end)
vim.keymap.set("n", "<leader>c", function() harpoon:list():clear() end)

