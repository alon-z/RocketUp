-- Button.lua
require "gui/box"
require "gui/text"
Button = {}
Button.__index = Button

setmetatable(Button, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Button:_init(text, x, y, font, scale, textColor, cam)
  self.x = x
  self.y = y
  self.color = color or {255, 255, 255, 255}
  self.scale = scale or 5
  self.cam = cam
  self.text = Text(text, x, y, font, self.scale)
  self.box = Box(x,y,self.text.text:getWidth(), self.text.text:getHeight(), self.scale)
end

function Button:draw ()
  offsetX, offsetY = 0,0
  if self.cam then
    offsetX, offsetY = cam:getVisibleCorners()
  end

  self.box:draw()
  self.text:draw()
end

function Button:update (text)
  self.text:update(text)
end

function Button:touchpressed(id, x, y)
  if (x > self.box.x) and (x <= self.box.x + self.box.width) then
    if (y > self.box.y) and (y <= self.box.y + self.box.height) then
      return true
    end
  end
end
