-- Game.lua
require "settings"
require "rocket/rocket"
require "gui/text"
local gamera =require "liberies/gamera"

Game = {}
Game.__index = Game

setmetatable(Game, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Game:_init()
  -- Physics
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  objects = {}
  objects.rc = Rocket(love.graphics.newImage("simpleRocket.png"), 950, 900, world, love.graphics.newImage("rocket/fireAnime.png"))
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 0, 1050)
  objects.ground.shape = love.physics.newRectangleShape(10000, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20)
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
  objects.ball.fixture:setRestitution(0.9)

  -- Camera
  cam = gamera.new(0,0,10000,9000)

  -- GUI
  hight = Text("Hight: ", 1300, 100, settings.font, 2, {255,255,255,255}, cam)
end

function Game:draw()
  cam:draw(function(l,t,w,h)
    objects.rc:draw()
    hight:draw()
    love.graphics.setColor(72, 160, 14)
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
    love.graphics.setColor(193, 47, 14)
    love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
    love.graphics.setBackgroundColor(settings.backroundColor)
  end)
end

function Game:update(dt)
  world:update(dt)
  objects.rc:update(dt)
  holder, hightN = objects.rc.body:getWorldCenter()
  hight:update("Hight: "..hightN)
  cam:setPosition(objects.rc.body:getPosition())
end

function Game:touchpressed(id, x)
  objects.rc:touchpressed(id, x)
end

function Game:touchmoved()
  -- body...
end

function Game:touchreleased(id)
  objects.rc:touchreleased(id)
end
