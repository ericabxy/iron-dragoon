local sprite = require('src.sprite')

local debris_sprite = sprite:new{
  texture = love.graphics.newImage('share/iron_plague_debris2.png'),
  textures = {},
  quad = love.graphics.newQuad(0, 0, 25, 25, 145, 25),
  quads = {},
  ox = -12,
  oy = -12,
  x = 0,
  y = 0,
}

debris_sprite.textures[0] = debris_sprite.texture
debris_sprite.textures[1] = love.graphics.newImage('share/iron_plague_debris3.png')
debris_sprite.textures[2] = love.graphics.newImage('share/iron_plague_debris1.png')
debris_sprite.quads[0] = debris_sprite.quad
debris_sprite.quads[1] = love.graphics.newQuad(24, 0, 25, 25, 145, 25)
debris_sprite.quads[2] = love.graphics.newQuad(48, 0, 25, 25, 145, 25)
debris_sprite.quads[3] = love.graphics.newQuad(72, 0, 25, 25, 145, 25)
debris_sprite.quads[4] = love.graphics.newQuad(96, 0, 25, 25, 145, 25)
debris_sprite.quads[5] = love.graphics.newQuad(120, 0, 25, 25, 145, 25)

function sprite:animate()
  local fps = 15
  self.quad = self.quads[math.floor(love.timer.getTime() * fps) % 6]
end

function debris_sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return debris_sprite
