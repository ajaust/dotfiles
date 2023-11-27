-- General copilot integration
--
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
		enabled = false,
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
  end,
}
