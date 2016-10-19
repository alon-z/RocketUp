-- ground.lua

Ground = {}
Ground.__index = Ground

setmetatable(Ground, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Ground:_init(x,y,width,height,color,world)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.color = color
  self.world = world
  self.body = love.physics.newBody( world, x+width/2, y, "static" )
  self.shape = love.physics.newRectangleShape( width, height )
  self.fixture = love.physics.newFixture( self.body, self.shape)
end

function Ground:update(dt)
  --body...
end

function Ground:touchpressed(id, x)
  --body...
end

function Ground:touchreleased(id)
  --body...
end

function Ground:draw()
  love.graphics.setColor(self.color)
  add1,add2 = self.body:getWorldCenter()
  love.graphics.polygon("fill",objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end
