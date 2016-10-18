-- text.lua
Text = {}
Text.__index = Text

setmetatable(Text, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Text:_init(text, x, y, font, scale, color, cam)
  self.text = love.graphics.newText( font or settings.font, text )
  self.x = x
  self.y = y
  self.color = color or {255, 255, 255, 255}
  self.scale = scale or 5
  self.cam = cam
end

function Text:draw ()
  offsetX, offsetY = 0,0
  if self.cam then
    offsetX, offsetY = cam:getVisibleCorners()
  end

  love.graphics.setColor(self.color)
  love.graphics.draw( self.text, self.x+offsetX, self.y+offsetY, 0, self.scale, self.scale)
end

function Text:update (text)
  self.text:set(text)
end
