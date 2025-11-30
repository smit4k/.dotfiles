return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,

  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons
    vim.o.laststatus = vim.g.lualine_laststatus

    ---------------------------------------------------------------------
    -- ✨ Use your colorscheme's lualine theme
    ---------------------------------------------------------------------
    local opts = {
      options = {
        theme = "auto", -- FOLLOW CURRENT COLORSCHEME 🎨
        globalstatus = vim.o.laststatus == 3,
        component_separators = "",
        section_separators = { left = "", right = "" }, -- bubble edges
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
        },
      },

      sections = {
        -----------------------------------------------------------------
        -- Left bubble
        -----------------------------------------------------------------
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },

        lualine_b = { "branch" },

        -----------------------------------------------------------------
        -- Center (breadcrumbs removed)
        -----------------------------------------------------------------
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        },

        -----------------------------------------------------------------
        -- Right side
        -----------------------------------------------------------------
        lualine_x = {
          Snacks.profiler.status(),

          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Statement") }
            end,
          },

          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Constant") }
            end,
          },

          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return { fg = Snacks.util.color("Debug") }
            end,
          },

          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },

          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },

        -----------------------------------------------------------------
        -- Progress + Cursor
        -----------------------------------------------------------------
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },

        -----------------------------------------------------------------
        -- Right bubble end
        -----------------------------------------------------------------
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { right = "" },
            left_padding = 2,
          },
        },
      },

      extensions = { "neo-tree", "lazy", "fzf" },
    }

    ---------------------------------------------------------------------
    -- Trouble integration stays
    ---------------------------------------------------------------------
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })

      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
