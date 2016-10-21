-- Sky.lua ---------------------------------------------------------------------------------------
require "sky/cloud"

Sky = {}
Sky.__index = Sky

setmetatable(Sky, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

----------------------------------------------------------------------------------------------------

function Sky:_init(x,y,width,height,cloudimage,maxCloudes)
  self.clouds = {}
  for i=0, maxCloudes or 20 do
    local newX = math.random(0, width-x) + x
    local newY = math.random(0, height-y) + y
    self.clouds[i] = Cloud(cloudimage,newX, newY,2)
  end
end

function Sky:update(dt)
  for num, object in pairs(self.clouds) do
    if object.update then
        object:update(dt)
      end
  end
end

function Sky:draw()
  for num, object in pairs(self.clouds) do
    if object.draw then
        object:draw()
      end
  end
end
