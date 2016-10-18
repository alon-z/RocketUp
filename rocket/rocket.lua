-- rocket.lua
require "rocket/tank"
require "rocket/engine"
local anim8 = require "liberies/anim8"

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
function Rocket:_init(image, x, y, world, firePNG)
  self.image = image
  self.firePNG =firePNG
  self.body = love.physics.newBody( world, x, y, "dynamic" )
  self.shape = love.physics.newRectangleShape( self.image:getWidth(), self.image:getHeight() )
  self.fixture = love.physics.newFixture( self.body, self.shape, 1 )
  self.tank = Tank()
  self.engine = Engine()
  local g16 = anim8.newGrid(16, 16, firePNG:getWidth(), firePNG:getHeight())
  self.fireAnimation = anim8.newAnimation(g16('1-5',1), 0.1)
end

function Rocket:update(dt)
  velx, vely = self.body:getLinearVelocity( )
  if vely <= 25 then
    accs = self.engine:use(self.tank)
    local angle = self.body:getAngle()
    local xf = math.cos(angle) * accs
    local yf = math.sin(angle) * accs
    self.body:applyForce(yf, -xf)
  end

  if self.tank then
    self.tank:update()
  end

  if self.needToTurnLeft then self:left(dt) end
  if self.needToTurnRight then self:right(dt) end
  self.fireAnimation:update(dt)
end

function Rocket:right(dt)
  -- rotate clockwise
  self.body:applyTorque(10000)
end

function Rocket:left(dt)
  -- rotate unclockwise
  self.body:applyTorque(-10000)
end

function Rocket:touchpressed(id, x)
  width = love.graphics.getWidth()
  if x <= width/2 then self.needToTurnLeft = true else
    self.needToTurnRight = true end
end

function Rocket:touchreleased(id)
  self.needToTurnLeft = false
  self.needToTurnRight = false
end

function Rocket:draw()
  love.graphics.setColor(255, 255, 255, 255)
  add1,add2 = self.body:getWorldCenter()
  love.graphics.draw(self.image,add1,add2,self.body:getAngle(),1,1,self.image:getWidth()/2,self.image:getHeight()/2)
  self.fireAnimation:draw(self.firePNG,add1,add2,self.body:getAngle(),2,2,self.image:getWidth()/8-2,-(self.image:getHeight()/4-4))

  if self.tank then
    self.tank:draw()
  end
end
