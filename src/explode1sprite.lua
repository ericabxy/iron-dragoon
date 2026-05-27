local sprite = require('src.sprite')

local explode1sprite = sprite:new{
  animation_timer = 0,
  animation_frame = 0,
  texture = love.graphics.newImage('share/iron_plague_explode1.png'),
  textures = {},
  quad = love.graphics.newQuad(0, 0, 25, 25, 256, 32),
  quads = {},
  ox = -6,
  oy = -6,
  x = 0,
  y = 0,
}

explode1sprite.quads[0] = explode1sprite.quad
explode1sprite.quads[1] = love.graphics.newQuad(24, 0, 25, 25, 256, 32)
explode1sprite.quads[2] = love.graphics.newQuad(48, 0, 25, 25, 256, 32)
explode1sprite.quads[3] = love.graphics.newQuad(72, 0, 25, 25, 256, 32)
explode1sprite.quads[4] = love.graphics.newQuad(96, 0, 25, 25, 256, 32)
explode1sprite.quads[5] = love.graphics.newQuad(120, 0, 25, 25, 256, 32)
explode1sprite.quads[6] = love.graphics.newQuad(144, 0, 25, 25, 256, 32)
explode1sprite.quads[7] = love.graphics.newQuad(168, 0, 25, 25, 256, 32)

function explode1sprite:animate(dt)
  local fps = 30
  self.animation_timer = self.animation_timer + dt * fps
  if self.animation_timer > 1 then
    self.animation_timer = 0
    self.animation_frame = self.animation_frame + 1
    if self.animation_frame < 8 then
      self.quad = self.quads[self.animation_frame]
    else
      self.remove_me_from_all_lists = true
    end
  end
end

function explode1sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return explode1sprite
