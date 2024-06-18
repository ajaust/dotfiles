-- Color scheme
return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require('kanagawa').setup {
    }
    require('kanagawa').load()
  end,
}
