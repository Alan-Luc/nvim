return {
  "alan-luc/mini-ssr",
  opts = {},
  keys = {
    {
      "<leader>h",
      function()
        require("mini-ssr").open()
      end,
      desc = "Search and replace",
    },
  },
}
