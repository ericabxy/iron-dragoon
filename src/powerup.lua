local sprite = require('src.sprite')

local powerup = sprite:new{
  texture = love.graphics.newImage('share/remastered_tyrian_powerups.png'),
  quad = love.graphics.newQuad(0, 0, 25, 25, 128, 32),
  iron_dragoon_type = 'powerup',
  iron_dragoon_powerup_type = 'bullet',
  ox = 13,
  oy = 13,
}

function powerup:paint(x, y)
  if math.floor(love.timer.getTime() * 15) % 2 == 0 then sprite.paint(self, x, y) end
end

function powerup:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return powerup
