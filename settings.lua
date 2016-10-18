
-- settings.lua
Settings = {}
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Settings:_init(text, x, y, font, scale, color, limit, aligen)
  -- Settings
  love.graphics.setDefaultFilter( 'nearest', 'nearest' )
  self.backroundColor = {50, 150, 200, 255}
  self.font = love.graphics.newImageFont("coolFont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(self.font, 27)
end
