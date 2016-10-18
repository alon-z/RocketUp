require "settings"
require "game"
require "gui/text"

function love.load()
  settings = Settings()
  mygame = Game()
end

function love.update(dt)
  if mygame then mygame:update(dt) end
end

function love.draw()
  if mygame then mygame:draw() end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchpressed(id, x, y, dx, dy, pressure) end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchmoved(id, x, y, dx, dy, pressure) end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  if mygame then mygame:touchreleased(id, x, y, dx, dy, pressure) end
end
