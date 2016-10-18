-- tank.lua
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
  self.amount = 400
end

function Tank:use(amount)
  if (self.amount - amount) < 0 then
    return false
  else
    self.amount = self.amount - amount
  end
  return true
end
