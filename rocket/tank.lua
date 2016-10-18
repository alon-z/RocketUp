-- tank.lua
require "gui/icon"

Tank = {}
Tank.__index = Tank

setmetatable(Tank, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Tank:_init()
  self.amount = 90000
  self.amountFull = self.amount
  self.icon = Icon(love.graphics.newImage("fuel.png"), 100, 100, 3 , self.amountFull)
end

function Tank:use(amount)
  if (self.amount - amount) < 0 then
    return false
  else
    self.amount = self.amount - amount
  end
  return true
end

function Tank:draw()
  self.icon:draw()
end

function Tank:update()
  self.icon:update(self.amount)
end
