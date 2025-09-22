local M = {}

-- safely require Harpoon v2
local ok, harpoon = pcall(require, "harpoon")
if not ok then
  vim.notify("harpbar: harpoon not found", vim.log.levels.ERROR)
  return M
end

local harpoon_list = harpoon:list()

-- Get all marks
local function get_marks()
  local marks = {}
  for i, item in ipairs(harpoon_list.items) do
    table.insert(marks, { idx = i, value = vim.fn.fnamemodify(item.value, ":t") })
  end
  return marks
end

-- Build the tabline
local function harpbar_tabline()
  local marks = get_marks()
  if #marks == 0 then
    return " Harpbar: [no marks] "
  end

  local parts = {}
  for _, mark in ipairs(marks) do
    table.insert(parts, string.format(" %d:%s ", mark.idx, mark.value))
  end
  return table.concat(parts, "|")
end

-- Setup
function M.setup()
  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.require'harpbar'.tabline()"
end

function M.tabline()
  return harpbar_tabline()
end

return M
