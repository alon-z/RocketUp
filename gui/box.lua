-- Box.lua
Box = {}
Box.__index = Box

setmetatable(Box, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Box:_init(x, y, width, height, scale, color, cam)
  self.scale = scale or 5
  self.x = x - self.scale
  self.y = y
  self.width = width*self.scale+2*self.scale
  self.height = height*self.scale
  self.color = color or {255, 255, 255, 255}
  self.cam = cam
end

function Box:draw ()
  offsetX, offsetY = 0,0
  if self.cam then
    offsetX, offsetY = cam:getVisibleCorners()
  end
  love.graphics.setColor(self.color)
  self.x = self.x + offsetX
  self.y = self.y + offsetY
  love.graphics.rectangle("fill", -- mode
                          self.x,
                          self.y,
                          self.width,
                          self.height, 10, 10)
end

function Box:update ()
  --body...
end
