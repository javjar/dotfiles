local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"
local grid = require "mjolnir.bg.grid"
-- Music controls
local spotify = require "mjolnir.lb.spotify"

-- Set up hotkey combinations
local mash = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}

-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 4
grid.MARGINX = 0
grid.MARGINY = 0

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

hotkey.bind(mash, "m", function()
  local win = window.focusedwindow()
  win:maximize()
end)

hotkey.bind(mash, ';', function() grid.snap(window.focusedwindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end)

hotkey.bind(mash, '=', function() grid.adjustwidth( 1) end)
hotkey.bind(mash, '-', function() grid.adjustwidth(-1) end)

hotkey.bind(mash, "1", function() shiftfourth(0, 0) end)
hotkey.bind(mash, "2", function() shiftfourth(1, 0) end)
hotkey.bind(mash, "3", function() shiftfourth(0, 1) end)
hotkey.bind(mash, "4", function() shiftfourth(1, 1) end)

hotkey.bind(mash, "left", function() shifthalf(0, 0, 2, 1) end)
hotkey.bind(mash, "right", function() shifthalf(1, 0, 2, 1) end)
hotkey.bind(mash, "up", function() shifthalf(0, 0, 1, 2) end)
hotkey.bind(mash, "down", function() shifthalf(0, 1, 1, 2) end)

hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', grid.pushwindow_down)
hotkey.bind(mash, 'K', grid.pushwindow_up)
hotkey.bind(mash, 'H', grid.pushwindow_left)
hotkey.bind(mash, 'L', grid.pushwindow_right)

hotkey.bind(mash, 'U', grid.resizewindow_taller)
hotkey.bind(mash, 'O', grid.resizewindow_wider)
hotkey.bind(mash, 'I', grid.resizewindow_thinner)
hotkey.bind(mash, 'Y', grid.resizewindow_shorter)

hotkey.bind(mashshift, 'space', spotify.displayCurrentTrack)
hotkey.bind(mashshift, 'p', spotify.play)
hotkey.bind(mashshift, 'o', spotify.pause)
hotkey.bind(mashshift, 'l', spotify.next)
hotkey.bind(mashshift, 'k', spotify.previous)

alert.show('ShiftIt\'ed')

-- TODO:
-- center current window at current size or ~80%
-- increase/decrease size by ~10% with -/+
-- fix the window's titlebar not being taken into consideration
