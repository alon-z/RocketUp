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

function Text:_init(text, x, y, font, scale, color, limit, aligen)
  self.text = text
  self.x = x
  self.y = y
  --self.font = font
  self.color = color or {255, 255, 255, 255}
  self.scale = scale or 5
  self.limit = limit or 999
  self.aligen = aligen or "left"
end

function Text:draw ()
  offsetX, offsetY = cam:getVisibleCorners()
  love.graphics.setColor(self.color)
  if self.font then
    --love.graphics.draw(self.image,self.x+offsetX, self.y+offsetY,math.rad(0),self.scale, self.scale, self.image:getWidth()/2, self.image:getHeight()/2)
  else
    love.graphics.printf( self.text, self.x+offsetX, self.y+offsetY, self.limit, self.align, 0, self.scale, self.scale )
  end
end

function Text:update (text)
  self.text = text
end
