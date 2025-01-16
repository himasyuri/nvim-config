local M = {}

M.nvimTree = {
  filters = { dotfiles = true },
  sort = {
    sorter = "case_sensitive",
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = { enable = true, update_root = false },
  view = {
    signcolumn = "no",
    side = "left",
    adaptive_size = true,
    width = 35,
    preserve_window_proportions = true,
  },
  git = { enable = true, ignore = true },
  filesystem_watchers = { enable = true },
  actions = {
    open_file = { resize_window = true },
  },
  renderer = {
    root_folder_label = false,
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "icon",
    indent_markers = { enable = false },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

function M.nvimTreeKeys()
  local api = require "nvim-tree.api"

  return {
    {
      "<C-t>",
      function()
        api.tree.toggle()
      end,
      desc = "Toggle NvimTree",
    },
  }
end

return M
