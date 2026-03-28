hs.loadSpoon("EmmyLua")

hs.window.animationDuration = 0

hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
  hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
  hs.window.focusedWindow():maximize()
end)

local function changeWindowSize(step)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local ratio = f.w / f.h
  f.w = f.w + step
  f.h = f.w / ratio
  win:setFrame(f)
end

local changeWindowStep = 100

hs.hotkey.bind({ "cmd", "ctrl" }, "[", function()
  changeWindowSize(-changeWindowStep)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "]", function()
  changeWindowSize(changeWindowStep)
end)
