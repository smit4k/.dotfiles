-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Colorshemes
require("kanagawa").setup({
    compile = false, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon", -- Load "wave" theme when 'background' option is not set
    background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
    },
})

require("onedark").setup({
    style = "warmer",
})
require("kanagawa")
local c = require("vscode.colors").get_colors()
require("vscode").setup({
    italic_comments = true,
    underline_links = true,
})
require("ayu").setup({
    mirage = true,
    terminal = true,
    overrides = {},
})
-- Lua
require("decay")
-- Plugins
require("colorizer").setup()
require("barbecue")
require("presence").setup({
    neovim_imagetext = "Neovim",
    main_image = "file",
    enable_line_number = false,
    -- Rich presence text options
    editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text = "Line %s out of %s",
})
require("mason")
require("code_runner").setup({
    filetype = {
        java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
            "cd $dir &&",
            "rustc $fileName &&",
            "$dir/$fileNameWithoutExt",
        },
        c = function(...)
            c_base = {
                "cd $dir &&",
                "gcc $fileName -o",
                "/tmp/$fileNameWithoutExt",
            }
            local c_exec = {
                "&& /tmp/$fileNameWithoutExt &&",
                "rm /tmp/$fileNameWithoutExt",
            }
            vim.ui.input({ prompt = "Add more args:" }, function(input)
                c_base[4] = input
                vim.print(vim.tbl_extend("force", c_base, c_exec))
                require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
            end)
        end,
    },
})
