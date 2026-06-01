local sprite = require('src.sprite')

local iron_plague_bullets_frost_fx = sprite:new{
  texture = love.graphics.newImage('share/iron_plague_bullets_frost.png'),
  quads = {
    [0] = love.graphics.newQuad(24, 12, 13, 13, 128, 128),
    [1] = love.graphics.newQuad(24, 24, 13, 13, 128, 128),
    [2] = love.graphics.newQuad(12, 24, 13, 13, 128, 128),
    [3] = love.graphics.newQuad(0, 24, 13, 13, 128, 128),
    [4] = love.graphics.newQuad(0, 12, 13, 13, 128, 128),
    [5] = love.graphics.newQuad(0, 0, 13, 13, 128, 128),
    [6] = love.graphics.newQuad(12, 0, 13, 13, 128, 128),
    [7] = love.graphics.newQuad(24, 0, 13, 13, 128, 128),
  },
  quads_medium = {
    [0] = love.graphics.newQuad(60, 12, 13, 13, 128, 128),
    [1] = love.graphics.newQuad(60, 24, 13, 13, 128, 128),
    [2] = love.graphics.newQuad(48, 24, 13, 13, 128, 128),
    [3] = love.graphics.newQuad(36, 24, 13, 13, 128, 128),
    [4] = love.graphics.newQuad(36, 12, 13, 13, 128, 128),
    [5] = love.graphics.newQuad(36, 0, 13, 13, 128, 128),
    [6] = love.graphics.newQuad(48, 0, 13, 13, 128, 128),
    [7] = love.graphics.newQuad(60, 0, 13, 13, 128, 128),
  },
  ox = -7,
  oy = -7,
}

function iron_plague_bullets_frost_fx:init()
  self.quads = self.quads_medium
  self.quad = self.quads[0]
  return self
end

function iron_plague_bullets_frost_fx:set_sprite_rotation(angle_in_degrees)
  self.quad = self.quads[math.ceil( angle_in_degrees / 45 )]
end

function iron_plague_bullets_frost_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_bullets_frost_fx
