local sprite = require('src.sprite')

local sunsprite = sprite:new{
  animation_timer = 0,
  animation_frame = 0,
  texture = love.graphics.newImage('share/iron_plague_sun1.png'),
  quad = love.graphics.newQuad(0, 0, 73, 73, 256, 128),
  quads = {},
  ox = 36,
  oy = 36,
}

sunsprite.quads[0] = sunsprite.quad
sunsprite.quads[1] = love.graphics.newQuad(72, 0, 73, 73, 256, 128)

function sunsprite:animate(dt)
  local fps = 1
  self.animation_timer = self.animation_timer + dt * fps
  if self.animation_timer > 1 then
    self.animation_timer = 0
    self.animation_frame = (self.animation_frame + 1) % 2
    self.quad = self.quads[self.animation_frame]
  end
end

function sunsprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return sunsprite
