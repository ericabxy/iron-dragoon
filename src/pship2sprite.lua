local exhaust2sprite = require('src.exhaust2sprite')
local sprite = require('src.sprite')

local pship2sprite = sprite:new{
  exhaust = exhaust2sprite:new(),
  texture = love.graphics.newImage('share/pship2_transparent.png'),
  quad = love.graphics.newQuad(96, 48, 25, 25, 128, 128),
  quads = {},
  ox = -13,
  oy = -13,
  x = 0,
  y = 0,
}

pship2sprite.quads[0] = pship2sprite.quad
pship2sprite.quads[1] = love.graphics.newQuad(96, 72, 25, 25, 128, 128)
pship2sprite.quads[2] = love.graphics.newQuad(96, 96, 25, 25, 128, 128)
pship2sprite.quads[3] = love.graphics.newQuad(72, 96, 25, 25, 128, 128)
pship2sprite.quads[4] = love.graphics.newQuad(48, 96, 25, 25, 128, 128)
pship2sprite.quads[5] = love.graphics.newQuad(24, 96, 25, 25, 128, 128)
pship2sprite.quads[6] = love.graphics.newQuad(0, 96, 25, 25, 128, 128)
pship2sprite.quads[7] = love.graphics.newQuad(0, 72, 25, 25, 128, 128)
pship2sprite.quads[8] = love.graphics.newQuad(0, 48, 25, 25, 128, 128)
pship2sprite.quads[9] = love.graphics.newQuad(0, 24, 25, 25, 128, 128)
pship2sprite.quads[10] = love.graphics.newQuad(0, 0, 25, 25, 128, 128)
pship2sprite.quads[11] = love.graphics.newQuad(24, 0, 25, 25, 128, 128)
pship2sprite.quads[12] = love.graphics.newQuad(48, 0, 25, 25, 128, 128)
pship2sprite.quads[13] = love.graphics.newQuad(72, 0, 25, 25, 128, 128)
pship2sprite.quads[14] = love.graphics.newQuad(96, 0, 25, 25, 128, 128)
pship2sprite.quads[15] = love.graphics.newQuad(96, 24, 25, 25, 128, 128)

function pship2sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return pship2sprite
