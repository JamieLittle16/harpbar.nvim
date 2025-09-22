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
    local abs_path = vim.fn.fnamemodify(item.value, ":p") -- ensure absolute path
    table.insert(marks, { idx = i, value = vim.fn.fnamemodify(item.value, ":t"), path = abs_path })
  end
  return marks
end

-- Build the tabline with highlighting
local function harpbar_tabline()
  local marks = get_marks()
  if #marks == 0 then
    return " Harpbar: [no marks] "
  end

  local current = vim.fn.expand("%:p") -- full path of current buffer
  local parts = {}
  for _, mark in ipairs(marks) do
    local hl = (vim.loop.fs_realpath(mark.path) == vim.loop.fs_realpath(current)) and "%#HarpbarActive#" or
        "%#HarpbarInactive#"
    table.insert(parts, hl .. string.format(" %d:%s ", mark.idx, mark.value))
  end

  return table.concat(parts, "|")
end

-- Setup
function M.setup()
  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.require'harpbar'.tabline()"

  -- Define highlight groups
  vim.cmd("highlight HarpbarInactive guifg=#888888")        -- grey
  vim.cmd("highlight HarpbarActive guifg=#ffffff gui=bold") -- white & bold
end

function M.tabline()
  return harpbar_tabline()
end

return M
