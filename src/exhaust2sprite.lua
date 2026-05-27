local sprite = require('src.sprite')

local exhaust2sprite = sprite:new{
  texture = love.graphics.newImage('share/exhaust2_small.png'),
  quad = love.graphics.newQuad(90, 52, 17, 17, 128, 128),
  textures = {},
  quads = {},
  ox = -9,
  oy = -9,
  x = 0,
  y = 0,
}

exhaust2sprite.textures[0] = exhaust2sprite.texture
exhaust2sprite.textures[1] = love.graphics.newImage('share/exhaust2_medium.png')
exhaust2sprite.textures[2] = love.graphics.newImage('share/exhaust2_large.png')
exhaust2sprite.quads[0] = exhaust2sprite.quad
exhaust2sprite.quads[1] = love.graphics.newQuad(90, 72, 17, 17, 128, 128)
exhaust2sprite.quads[2] = love.graphics.newQuad(92, 92, 17, 17, 128, 128)
exhaust2sprite.quads[3] = love.graphics.newQuad(72, 90, 17, 17, 128, 128)
exhaust2sprite.quads[4] = love.graphics.newQuad(52, 90, 17, 17, 128, 128)
exhaust2sprite.quads[5] = love.graphics.newQuad(31, 90, 17, 17, 128, 128)
exhaust2sprite.quads[6] = love.graphics.newQuad(11, 92, 17, 17, 128, 128)
exhaust2sprite.quads[7] = love.graphics.newQuad(14, 72, 17, 17, 128, 128)
exhaust2sprite.quads[8] = love.graphics.newQuad(14, 52, 17, 17, 128, 128)
exhaust2sprite.quads[9] = love.graphics.newQuad(14, 32, 17, 17, 128, 128)
exhaust2sprite.quads[10] = love.graphics.newQuad(11, 11, 17, 17, 128, 128)
exhaust2sprite.quads[11] = love.graphics.newQuad(31, 14, 17, 17, 128, 128)
exhaust2sprite.quads[12] = love.graphics.newQuad(52, 14, 17, 17, 128, 128)
exhaust2sprite.quads[13] = love.graphics.newQuad(72, 14, 17, 17, 128, 128)
exhaust2sprite.quads[14] = love.graphics.newQuad(92, 11, 17, 17, 128, 128)
exhaust2sprite.quads[15] = love.graphics.newQuad(90, 31, 17, 17, 128, 128)

function exhaust2sprite:animate()
  self.texture = self.textures[math.floor(love.timer.getTime() * 15) % 3]
end

function exhaust2sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return exhaust2sprite
