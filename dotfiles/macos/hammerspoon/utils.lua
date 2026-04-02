local M = {}

M.changeWindowSize = function(step)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local ratio = f.w / f.h
  f.w = f.w + step
  f.h = f.w / ratio
  win:setFrame(f)
end

M.makeAppLauncher = function(appName)
  return function()
    local app = hs.application.find(appName)
    if app then
      if app:isFrontmost() then
        app:hide()
      else
        app:activate()
      end
    else
      hs.application.launchOrFocus(appName)
    end
  end
end

return M
