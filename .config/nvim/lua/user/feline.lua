local feline = require('feline')
local vi_mode = require('feline.providers.vi_mode')

local fn = vim.fn
local bo = vim.bo
local api = vim.api

local LEFT = 1
local RIGHT = 2

local gruvbox = {
    fg = '#ebdbb2',
    bg = '#3c3836',
    black = '#3c3836',
    skyblue = '#83a598',
    cyan = '#8e07c',
    green = '#b8bb26',
    oceanblue = '#076678',
    blue = '#458588',
    magenta = '#d3869b',
    orange = '#d65d0e',
    red = '#fb4934',
    violet = '#b16286',
    white = '#ebdbb2',
    yellow = '#fabd2f',
}

local MODE_COLORS = {
  ['NORMAL'] = 'green',
  ['COMMAND'] = 'skyblue',
  ['INSERT'] = 'orange',
  ['REPLACE'] = 'red',
  ['LINES'] = 'violet',
  ['VISUAL'] = 'violet',
  ['OP'] = 'yellow',
  ['BLOCK'] = 'yellow',
  ['V-REPLACE'] = 'yellow',
  ['ENTER'] = 'yellow',
  ['MORE'] = 'yellow',
  ['SELECT'] = 'yellow',
  ['SHELL'] = 'yellow',
  ['TERM'] = 'yellow',
  ['NONE'] = 'yellow',
}

local statusline = {
    active = {
        {},
        {}
    },
    inactive = {
        {},
        {}
    }
} 

function ternary ( cond , T , F )
    if cond then return T else return F end
end

function get_filename()
    local filename = api.nvim_buf_get_name(0)
    if filename == '' then
        filename = '[no name]'
    end
    return fn.fnamemodify(filename, ':~:.')
end

function get_filetype()
    local filetype = bo.filetype
    if filetype == '' then
        filetype = '[no type]'
    end
    return filetype:lower()
end

function get_unsaved()
    local modified = bo.modified
    if modified then
        return '[U]'
    end
        return '[S]'
end

function get_line_cursor()
  local cursor_line, _ = unpack(api.nvim_win_get_cursor(0))
  return cursor_line
end

function get_line_total()
  return api.nvim_buf_line_count(0)
end

function get_char_cursor()
    local _, cursor_char = unpack(api.nvim_win_get_cursor(0))
    return cursor_char + 1 
end

function wrap(string)
    return ' ' .. string .. ' '
end

function wrap_left(string)
    return ' ' .. string .. ' '
end

function wrap_right(string)
    return ' ' .. string .. ' '
end

function wrapped_provider(provider, wrapper)
    return function(component, opts)
        return wrapper(provider(component, opts))
    end
end

function provide_mode(component, opts)
    return vi_mode.get_vim_mode()
end

function provide_filename(component, opts)
    return get_filename()
end

function provide_unsaved(component, opts)
    return get_unsaved()
end

function provide_linecharnumber(component, opts)
  return get_line_cursor() .. ':' .. get_char_cursor() .. '/' .. get_line_total()
end

function provide_filetype(component, opts)
  return get_filetype()
end

table.insert(statusline.active[LEFT], {
  name = 'mode',
  provider = wrapped_provider(provide_mode, wrap),
  right_sep = 'slant_right',
  hl = function()
    return {
      fg = 'black',
      bg = vi_mode.get_mode_color(),
    }
  end,
})

table.insert(statusline.active[LEFT], {
  name = 'filename',
  provider = wrapped_provider(provide_filename, wrap_left),
  right_sep = 'slant_right',
  hl = {
    bg = 'white',
    fg = 'black',
  },
})

table.insert(statusline.active[LEFT], {
    name = 'unsaved',
    provider = wrapped_provider(provide_unsaved, wrap_left),
    right_sep = 'slant_right',
    hl = function() 
        return {
            fg = 'black',
            bg = ternary(bo.modified == true, "red", "green")
        }
    end
})

table.insert(statusline.active[RIGHT], {
    name = 'filetype',
    provider = wrapped_provider(provide_filetype, wrap_right),
    left_sep = 'slant_left',
    hl = {
        bg = 'white',
        fg = 'black',
  },
})

table.insert(statusline.active[RIGHT], {
    name = 'linecharnumber',
    provider = wrapped_provider(provide_linecharnumber, wrap),
    left_sep = 'slant_left',
    hl = {
        bg = 'skyblue',
        fg = 'black',
  },
})

table.insert(statusline.inactive[LEFT], {
  name = 'filename_inactive',
  provider = wrapped_provider(provide_filename, wrap),
  right_sep = 'slant_right',
  hl = {
    fg = 'white',
    bg = 'bg',
  },
})

feline.setup {
    theme = gruvbox,
    components = statusline,
    vi_mode_colors = mode_colors,
}
