local sprite = require('src.sprite')

local bulletsprite = sprite:new{
  texture = love.graphics.newImage('share/iron_plague_bullet_flame.png'),
  quad = love.graphics.newQuad(24, 12, 13, 13, 64, 64),
  textures = {},
  quads = {},
  ox = -7,
  oy = -7,
  x = 0,
  y = 0,
}

bulletsprite.textures[0] = bulletsprite.texture
bulletsprite.textures[1] = love.graphics.newImage('share/iron_plague_bullet_frost.png')
bulletsprite.textures[2] = love.graphics.newImage('share/iron_plague_bullet_fluid.png')
bulletsprite.textures[3] = love.graphics.newImage('share/iron_plague_bullet_flame2.png')
bulletsprite.textures[4] = love.graphics.newImage('share/iron_plague_bullet_frost2.png')
bulletsprite.quads[0] = bulletsprite.quad
bulletsprite.quads[1] = love.graphics.newQuad(24, 24, 13, 13, 64, 64)
bulletsprite.quads[2] = love.graphics.newQuad(12, 24, 13, 13, 64, 64)
bulletsprite.quads[3] = love.graphics.newQuad(0, 24, 13, 13, 64, 64)
bulletsprite.quads[4] = love.graphics.newQuad(0, 12, 13, 13, 64, 64)
bulletsprite.quads[5] = love.graphics.newQuad(0, 0, 13, 13, 64, 64)
bulletsprite.quads[6] = love.graphics.newQuad(12, 0, 13, 13, 64, 64)
bulletsprite.quads[7] = love.graphics.newQuad(24, 0, 13, 13, 64, 64)

function bulletsprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return bulletsprite
