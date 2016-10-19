-- cloud.lua ---------------------------------------------------------------------------------------
local anim8 = require "liberies/anim8"

Cloud = {}
Cloud.__index = Cloud

setmetatable(Cloud, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

----------------------------------------------------------------------------------------------------

function Cloud:_init(cloudimage,x,y,scale,color,maxWidth)
  self.cloudimage = cloudimage
  self.x = x
  self.y = y
  self.scale = scale or 1
  self.color = color or {255,255,255,255}
  local grid = anim8.newGrid(52, 28, self.cloudimage:getWidth(), self.cloudimage:getHeight())
  local max = self.cloudimage:getWidth()/52
  self.frames = grid(math.random(1,max),1)
  self.width = math.random(1,maxWidth or 10)
  self.width = self.width/10 + 1
end

function Cloud:update(dt)
  --body...
end

function Cloud:touchpressed(id, x)
  --body...
end

function Cloud:touchreleased(id)
  --body...
end

function Cloud:draw()
  love.graphics.setColor(self.color)
  local frame = self.frames[1]
  love.graphics.draw(self.cloudimage, frame, self.x,self.y,0,self.scale*self.width,self.scale)
end
