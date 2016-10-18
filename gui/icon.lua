-- Icon.lua
Icon = {}
Icon.__index = Icon

setmetatable(Icon, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Icon:_init(image, x, y, scale, amountFull)
  self.image = image
  self.x = x
  self.y = y
  self.amountFull = amountFull or 0
  self.currAmount = self.amountFull
  self.scale = scale
  self.borderOffset = 10 * scale / 2
  self.width = self.image:getWidth()*self.scale+self.borderOffset
end

function Icon:draw ()
  offsetX, offsetY = cam:getVisibleCorners()
  -- Draw Image
  if self.currAmount <= 0 then
    love.graphics.setColor(255, 255, 255, 154)
  else
    love.graphics.setColor(255, 255, 255, 255)
  end
  love.graphics.draw(self.image,self.x+offsetX, self.y+offsetY,math.rad(0),self.scale, self.scale, self.image:getWidth()/2, self.image:getHeight()/2)

  if self.currAmount > 0 then
    -- Draw Rectangle overlay - fill
    love.graphics.setColor(0, 255, 100, 100)
    love.graphics.rectangle("fill", -- mode
                            -self.image:getWidth()/2*self.scale-self.borderOffset/2 + self.x + offsetX, -- move from center to top left and add some border
                            -self.image:getHeight()/2*self.scale-self.borderOffset/2 + self.y + offsetY, -- move from center to top left and add some border
                            self.width, -- width with border
                            self.image:getHeight()*self.scale+self.borderOffset, 10, 10) -- height with border
  end
end

function Icon:update (currAmount)
  self.currAmount = currAmount
  self.width = ((self.image:getWidth()*self.scale+self.borderOffset) / (self.amountFull)) * currAmount
end
