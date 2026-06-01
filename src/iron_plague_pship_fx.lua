local sprite = require('src.sprite')

local iron_plague_pship_fx = sprite:new{
  texture = love.graphics.newImage('share/iron_plague_pship.png'),
  quads = {
    [12] = love.graphics.newQuad(0, 0, 24, 24, 193, 49),
    [13] = love.graphics.newQuad(24, 0, 24, 24, 193, 49),
    [14] = love.graphics.newQuad(48, 0, 24, 24, 193, 49),
    [15] = love.graphics.newQuad(72, 0, 24, 24, 193, 49),
    [0] = love.graphics.newQuad(96, 0, 24, 24, 193, 49),
    [1] = love.graphics.newQuad(120, 0, 24, 24, 193, 49),
    [2] = love.graphics.newQuad(144, 0, 24, 24, 193, 49),
    [3] = love.graphics.newQuad(168, 0, 24, 24, 193, 49),
    [4] = love.graphics.newQuad(0, 24, 24, 24, 193, 49),
    [5] = love.graphics.newQuad(24, 24, 24, 24, 193, 49),
    [6] = love.graphics.newQuad(48, 24, 24, 24, 193, 49),
    [7] = love.graphics.newQuad(72, 24, 24, 24, 193, 49),
    [8] = love.graphics.newQuad(96, 24, 24, 24, 193, 49),
    [9] = love.graphics.newQuad(120, 24, 24, 24, 193, 49),
    [10] = love.graphics.newQuad(144, 24, 24, 24, 193, 49),
    [11] = love.graphics.newQuad(168, 24, 24, 24, 193, 49),
  },
  ox = -12,
  oy = -12,
}

function iron_plague_pship_fx:init()
  self.quad = self.quads[12]
  return self
end

function iron_plague_pship_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_pship_fx
