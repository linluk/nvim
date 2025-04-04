
vim.api.nvim_create_autocmd({"TermOpen"}, {
    callback = function() -- ev)
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.cursorline = false
    end
})

-- https://neovim.io/doc/user/terminal.html#terminal
-- Added: 2024-12-03
vim.api.nvim_create_autocmd({ 'TermRequest' }, {
  desc = 'Handles OSC 7 dir change requests',
  callback = function(ev)
    if string.sub(vim.v.termrequest, 1, 4) == '\x1b]7;' then
      local dir = string.gsub(vim.v.termrequest, '\x1b]7;file://[^/]*', '')
      if vim.fn.isdirectory(dir) == 0 then
        vim.notify('invalid dir: '..dir)
        return
      end
      vim.api.nvim_buf_set_var(ev.buf, 'osc7_dir', dir)
      if vim.o.autochdir and vim.api.nvim_get_current_buf() == ev.buf then
        vim.cmd.cd(dir)
      end
    end
  end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'DirChanged' }, {
  callback = function(ev)
    if vim.b.osc7_dir and vim.fn.isdirectory(vim.b.osc7_dir) == 1 then
      vim.cmd.cd(vim.b.osc7_dir)
    end
  end
})
