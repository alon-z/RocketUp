-- rocket.lua
require "rocket/tank"
require "rocket/engine"

-- Properties
-- Static
-- image => the rocket image
-- dynamic
-- x,y => cords
-- xyvel = 0

Rocket = {}
Rocket.__index = Rocket
local ANGACCEL      = 4

setmetatable(Rocket, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

--
-- image = love.image type == default is nil
-- x,y of top left == default is 0
--
function Rocket:_init(image, x, y)
  self.image = image or nil
  self.x = x or 0
  self.y = y or 0
  self.xvel = 0
  self.yvel = 0
  self.rotation = 0
  self.tank = Tank()
  self.engine = Engine()
  self.grav = 0.5
end

function Rocket:update(dt)
  accs = self.engine:use(self.tank)
  self.xvel = self.xvel + accs*dt * math.sin(self.rotation)
  self.yvel = self.yvel + accs*dt * math.cos(self.rotation)
  self.x = self.x - self.xvel*dt
  self.y = self.y - self.yvel*dt
  self.yvel = self.yvel - self.grav

  if self.tank then
    self.tank:update()
  end
end

function Rocket:right(dt)
  -- rotate clockwise
  --self.rotation = self.rotation + ANGACCEL*dt
end

function Rocket:draw()
  love.graphics.reset()
  love.graphics.translate(self.x, self.y)
  love.graphics.rotate(self.rotation)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(self.image,0,0)
  love.graphics.reset()

  if self.tank then
    self.tank:draw()
  end
end
