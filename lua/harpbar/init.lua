local M = {}

M.setup = function()
  -- highlight groups
  vim.api.nvim_set_hl(0, "HarpbarNumber", { fg = "#FF8700", bold = true })
  vim.api.nvim_set_hl(0, "HarpbarFile", { fg = "#A0A0A0" })
  vim.api.nvim_set_hl(0, "HarpbarCurrent", { fg = "#FFD700", bold = true })

  local harpoon_ok, harpoon = pcall(require, "harpoon.mark")
  if not harpoon_ok then return end

  function _G.harpbar_tabline()
    local buf_list = harpoon.get_marked_files()
    if #buf_list == 0 then return "" end

    local s = ""
    local current_buf = vim.api.nvim_get_current_buf()

    for i, file in ipairs(buf_list) do
      local fname = vim.fn.fnamemodify(file.filename, ":t")
      local bufnum = vim.fn.bufnr(file.filename)
      local hl_number = "HarpbarNumber"
      local hl_file = "HarpbarFile"

      if bufnum == current_buf then
        hl_number = "HarpbarCurrent"
        hl_file = "HarpbarCurrent"
      end

      s = s .. string.format(
        "%%#%s#%%@v:lua.HarpbarJump@%d@ %d %%#%s#%s %%X",
        hl_number, i, i, hl_file, fname
      )
    end
    return s
  end

  function _G.HarpbarJump(num)
    require("harpoon.ui").nav_file(tonumber(num))
  end

  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.harpbar_tabline()"

  for i = 1, 9 do
    vim.api.nvim_set_keymap(
      "n",
      "<leader>" .. i,
      string.format(":lua require('harpoon.ui').nav_file(%d)<CR>", i),
      { noremap = true, silent = true }
    )
  end
end

return M
