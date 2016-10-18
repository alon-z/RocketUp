-- Engine.lua
Engine = {}
Engine.__index = Engine

setmetatable(Engine, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Engine:_init()
  self.power = 400
end

function Engine:use(tank)
  if tank:use(10) then
    return self.power
  elseif tank:use(5) then
    return (self.power / 3)
  elseif tank:use(1) then
    return (self.power / 5)
  else
    return 0
  end
end
