local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"

local mash = {"ctrl", "alt", "cmd"}

hotkey.bind(mash, "m", function()
  local win = window.focusedwindow()
  win:maximize()
end)

local function shiftfourth(x, y)
  local win = window.focusedwindow()
  if not win then return end -- If no focused window, just return

  local winframe = win:frame()
  local screenframe = win:screen():frame()
  local newframe = {
    x = screenframe.w / 2 * x,
    y = screenframe.h / 2 * y,
    w = screenframe.w / 2,
    h = screenframe.h / 2
  }

  win:setframe(newframe)
end

local function shifthalf(x, y, w, h)
  local win = window.focusedwindow()
  if not win then return end -- If no focused window, just return

  local winframe = win:frame()
  local screenframe = win:screen():frame()
  local newframe = {
    x = screenframe.w / 2 * x,
    y = screenframe.h / 2 * y,
    w = screenframe.w / w,
    h = screenframe.h / h
  }

  win:setframe(newframe)
end

hotkey.bind(mash, "1", function() shiftfourth(0, 0) end)
hotkey.bind(mash, "2", function() shiftfourth(1, 0) end)
hotkey.bind(mash, "3", function() shiftfourth(0, 1) end)
hotkey.bind(mash, "4", function() shiftfourth(1, 1) end)

hotkey.bind(mash, "left", function() shifthalf(0, 0, 2, 1) end)
hotkey.bind(mash, "right", function() shifthalf(1, 0, 2, 1) end)
hotkey.bind(mash, "up", function() shifthalf(0, 0, 1, 2) end)
hotkey.bind(mash, "down", function() shifthalf(0, 1, 1, 2) end)

alert.show('ShiftIt\'ed')

-- TODO:
-- center current window at current size or ~80%
-- increase/decrease size by ~10%
