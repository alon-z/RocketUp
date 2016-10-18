require "settings"
require "game"
require "gui/button"

function love.load()
  settings = Settings()
  --mygame = Game()
  startButton = Button("Start", love.graphics:getWidth()/2,600, settings.font, 10)
end

function love.update(dt)
  if mygame then mygame:update(dt) end
end

function love.draw()
  if mygame then mygame:draw() end
  if startButton then startButton:draw() end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchpressed(id, x, y, dx, dy, pressure) end
  if startButton then
    if startButton:touchpressed(id, x, y, dx, dy, pressure) then
      mygame = Game()
      startButton = nil
    end
  end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchmoved(id, x, y, dx, dy, pressure) end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchreleased(id, x, y, dx, dy, pressure) end
end
