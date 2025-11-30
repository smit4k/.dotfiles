return {
  "vyfor/cord.nvim",
  opts = {
    enabled = true,
    build = ":Cord update",
    editor = {
      tooltip = "Neovim",
    },
    text = {
      workspace = function(opts)
        return "Workspace: " .. opts.workspace
      end,
    },
  },
}
