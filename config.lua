-- PowerShell as default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
}

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.endofline = false

vim.o.relativenumber = true

lvim.colorscheme = "tokyonight-night"
lvim.transparent_window = true

-- Plugins
lvim.plugins = {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ggandor/leap.nvim",
        name = "leap",
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup {
                show_numbers = true,    -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            }
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        event = { "BufRead", "BufNew" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 120,              -- Width of the floating window
                height = 25,              -- Height of the floating window
                default_mappings = false, -- Bind default mappings
                debug = false,            -- Print debug information
                opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
                -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
                -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
            }
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require "lsp_signature".on_attach() end,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {}
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        lazy = "true",
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
            }
        end,
    },
    {
        'MeanderingProgrammer/harpoon-core.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('harpoon-core').setup({
                -- Make existing window active rather than creating a new window
                use_existing = true,
                -- Default action when opening a mark, defaults to current window
                -- Example: 'vs' will open in new vertical split, 'tabnew' will open in new tab
                default_action = nil,
                -- Set marks specific to each git branch inside git repository
                mark_branch = false,
                -- Use the previous cursor position of marked files when opened
                use_cursor = true,
                -- Settings for popup window
                menu = {
                    width = 60,
                    height = 10,
                },
                -- Highlight groups to use for various components
                highlight_groups = {
                    window = 'HarpoonWindow',
                    border = 'HarpoonBorder',
                },
            })
        end,
    },
    {
        "tpope/vim-repeat",
        event = "BufReadPre"
    },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "simrat39/symbols-outline.nvim",
        event = "BufReadPre",
        config = function()
            require('symbols-outline').setup()
        end
    },
    {
        "kshenoy/vim-signature",
        event = "BufReadPre"
    },
    {
        "lukoshkin/highlight-whitespace",
        event = "BufEnter",
        opts = {
            tws = "\\s\\+$",
            clear_on_winleave = false,
            palette = {
                markdown = {
                    tws = "RosyBrown",
                    ["\\(\\S\\)\\@<=\\s\\(\\.\\|,\\)\\@="] = "CadetBlue3",
                    ["\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@="] = "SkyBlue1",
                    ["\\t\\+"] = "plum4",
                },
                other = {
                    tws = "PaleVioletRed",
                    ["\\(\\S\\)\\@<=\\s\\(,\\)\\@="] = "coral1",
                    ["\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@="] = "LightGoldenrod3",
                    ["\\t\\+"] = "plum4",
                }
            }
        }
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "BufRead",
        keys = {
            { "zR", function() require("ufo").openAllFolds() end },
            { "zM", function() require("ufo").closeAllFolds() end },
            { "K", function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end }
        },
        config = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require("ufo").setup({
                close_fold_kinds = { "imports" },
            })
        end,
    }
}

-- Restore the last session
lvim.builtin.which_key.mappings["q"] = {
    name = "Sessions",
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Last session" }
}

-- Trouble
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", "Trouble" },
    d = { "<cmd>Trouble diagnostics toggle focus=true<cr>", "Workspace" },
    q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix" },
    l = { "<cmd>Trouble loclist toggle<cr>", "Loclist" },
    r = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "References" },
    s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols" }
}

table.insert(lvim.builtin.which_key.mappings["s"], {
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "current word" },
    s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" }
})

-- Splits and Diffs
lvim.builtin.which_key.mappings["b"]["v"] = {"<cmd>vsplit<cr>", "Vertical Split"}
lvim.builtin.which_key.mappings["b"]["V"] = {"<cmd>only<cr>", "Turn off vertical Split"}
lvim.builtin.which_key.mappings["b"]["d"] = {"<cmd>windo diffthis<cr>", "Diff"}
lvim.builtin.which_key.mappings["b"]["D"] = {"<cmd>windo diffoff<cr>", "Diff off"}


lvim.builtin.which_key.mappings["m"] = {
    name = "Marks",
    a = { "<cmd>lua require('harpoon-core.mark').add_file()<cr>", "Add File" },
    m = { "<cmd>lua require('harpoon-core.ui').toggle_quick_menu()<cr>", "View marks" },
    n = { "<cmd>lua require('harpoon-core.ui').nav_next()<cr>", "Goto next mark" },
    p = { "<cmd>lua require('harpoon-core.ui').nav_prev()<cr>", "Goto prev mark" }
}

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { "*" },
    command = "normal zR"
})
