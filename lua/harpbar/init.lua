local M = {}

function M.setup(opts)
  opts = opts or {}
  M.opts = vim.tbl_extend("force", {
    height = 1,
    hl_group = "StatusLine",
  }, opts)

  -- Create augroup so the bar updates when needed
  local augroup = vim.api.nvim_create_augroup("Harpbar", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = augroup,
    callback = function() M.render() end,
  })

  -- Initial render
  M.render()
end

function M.render()
  local harpoon = require("harpoon")
  local list = harpoon:list()

  if not list or #list.items == 0 then
    M.close()
    return
  end

  local lines = {}
  for i, item in ipairs(list.items) do
    local name = vim.fn.fnamemodify(item.value, ":t") -- filename only
    table.insert(lines, string.format("[%d] %s", i, name))
  end
  local text = table.concat(lines, "  ")

  -- If win already exists, update
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, { text })
    return
  end

  -- Create new buffer + window
  M.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, { text })
  vim.api.nvim_buf_set_option(M.buf, "modifiable", false)

  M.win = vim.api.nvim_open_win(M.buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = M.opts.height,
    row = 0,
    col = 0,
    focusable = false,
    style = "minimal",
    border = "none",
  })

  vim.api.nvim_win_set_option(M.win, "winhl", "Normal:" .. M.opts.hl_group)
end

function M.close()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, true)
    M.win = nil
    M.buf = nil
  end
end

return M
