-- Game.lua ----------------------------------------------------------------------------------------
require "settings"
require "rocket/rocket"
require "ground/ground"
require "sky/sky"
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
----------------------------------------------------------------------------------------------------
function Game:_init()
  -- Camera
  cam = gamera.new(0,0,settings.worldWidth,settings.worldHeight)
  cam:setWindow(0,0,love.graphics.getWidth(),love.graphics.getHeight())

  -- Physics
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  objects = {}
  objects.rc = Rocket(love.graphics.newImage("simpleRocket.png"), settings.worldWidth/2, settings.worldHeight-50, world, love.graphics.newImage("rocket/fireAnime.png"))
  objects.ground = Ground(0,settings.worldHeight,settings.worldWidth,50,{90,190,90,255},world)

  -- Backrounud
  objects.sky = Sky(50,0,settings.worldWidth-100, settings.worldHeight-100,love.graphics.newImage("sky/clouds.png"),50)

  -- GUI
  hight = Text("Hight: ", 100, 100, settings.font, 2, {255,255,255,255}, cam)
end

function Game:draw()
  cam:draw(function(l,t,w,h)
    for num, object in pairs(objects) do
      if object.draw then
          object:draw()
        end
    end
    hight:draw()
    love.graphics.setBackgroundColor(settings.backroundColor)
  end)
end

function Game:update(dt)
  world:update(dt)
  for num, object in pairs(objects) do
    if object.update then
        object:update(dt)
      end
  end
  holder, hightN = objects.rc.body:getWorldCenter()
  hight:update("X: "..holder.."Y: "..hightN)
  cam:setPosition(objects.rc.body:getPosition())
end

function Game:touchpressed(id, x)
  for num, object in pairs(objects) do
    if object.touchpressed then
        object:touchpressed(id, x)
      end
  end
end

function Game:touchmoved()
  for num, object in pairs(objects) do
    if object.touchmoved then
        object:touchmoved()
      end
  end
end

function Game:touchreleased(id)
  for num, object in pairs(objects) do
    if object.touchreleased then
        object:touchreleased(id)
      end
  end
end
