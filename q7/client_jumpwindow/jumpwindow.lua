jumpWindow = nil
jumpWindowButton = nil
jumpButton = nil

windowPos = nil
windowSize = nil
buttonSize = nil

function init()
  jumpWindow = g_ui.displayUI('jumpwindow.otui')
  jumpWindow:hide()

  jumpWindowButton = modules.client_topmenu.addLeftButton('jumpWindowButton',
    tr('Jump Window'), '/client_jumpwindow/jumpwindow', toggle)
  jumpButton = jumpWindow:getChildById('jumpButton')

  windowSize = jumpWindow:getSize()
  buttonSize = jumpButton:getSize()

  cycleEvent(updatePos, 50)
end

function terminate()
  jumpWindowButton:destroy()
  jumpWindow = nil
end

function toggle()
  if jumpWindow:isVisible() then
    hide()
  else
    show()
  end
end

function hide()
  jumpWindow:hide()
end

function show()
  jumpWindow:show()
  jumpWindow:raise()
  jumpWindow:focus()
end

function updatePos()
  windowPos = jumpWindow:getPosition()

  pos = jumpButton:getPosition()
  pos.x = pos.x - 10

  if pos.x < windowPos.x then
    pos.x = windowPos.x + windowSize.width - buttonSize.width
    pos.y = pos.y - 50
  end

  pos.y = clampButtonYPos(pos.y, windowPos.y)

  jumpButton:setPosition(pos)
end

function onClickButton()
  windowPos = jumpWindow:getPosition()

  pos = jumpButton:getPosition()
  pos.y = pos.y - 100
  pos.y = clampButtonYPos(pos.y, windowPos.y)

  jumpButton:setPosition(pos)
end

function clampButtonYPos(yPos, windowYPos)
  if yPos - 100 < windowYPos then
    yPos = windowYPos + windowSize.height - 50
  end

  return yPos
end
