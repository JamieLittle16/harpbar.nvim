-- ~/.config/nvim/lua/harpbar/init.lua
local M = {}

M.setup = function(opts)
  opts = opts or {}

  -- highlights (tweak as you like)
  vim.api.nvim_set_hl(0, "HarpbarNumber",  { fg = "#FF8700", bold = true })
  vim.api.nvim_set_hl(0, "HarpbarFile",    { fg = "#A0A0A0" })
  vim.api.nvim_set_hl(0, "HarpbarCurrent", { fg = "#FFD700", bold = true })

  local function get_marks()
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then return {} end
    local list = harpoon.list()
    if not list or not list.items then return {} end
    local out = {}
    for i, item in ipairs(list.items) do
      table.insert(out, { index = i, path = item.value })
    end
    return out
  end

  _G.harpbar_tabline = function()
    local marks = get_marks()
    if #marks == 0 then return "" end
    local s = ""
    local curbuf = vim.api.nvim_get_current_buf()

    for _, m in ipairs(marks) do
      local fname = vim.fn.fnamemodify(m.path, ":t")
      local bufnum = vim.fn.bufnr(m.path, false)
      local hl_num = "HarpbarNumber"
      local hl_file = "HarpbarFile"

      if bufnum == curbuf then
        hl_num = "HarpbarCurrent"
        hl_file = "HarpbarCurrent"
      end

      s = s .. string.format(
        "%%#%s#%%@v:lua.HarpbarJump@%d@ %d %%#%s#%s %%X",
        hl_num, m.index, m.index, hl_file, fname
      )
    end

    return s
  end

  _G.HarpbarJump = function(num)
    local ok, ui = pcall(require, "harpoon.ui")
    if ok then ui.nav_file(tonumber(num)) end
  end

  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.harpbar_tabline()"

  for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
      local ok, ui = pcall(require, "harpoon.ui")
      if ok then ui.nav_file(i) end
    end, { noremap = true, silent = true })
  end
end

return M
