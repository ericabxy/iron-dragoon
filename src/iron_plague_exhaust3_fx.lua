local sprite = require('src.sprite')

local exhaust3_fx = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/iron_plague_exhaust3a.png'),
    [1] = love.graphics.newImage('share/iron_plague_exhaust3b.png'),
    [2] = love.graphics.newImage('share/iron_plague_exhaust3c.png')
  },
  quads = {
    [8] = love.graphics.newQuad(96, 48, 25, 25, 128, 128),
    [7] = love.graphics.newQuad(96, 25, 25, 24, 128, 128),
    [6] = love.graphics.newQuad(96, 0, 25, 25, 128, 128),
    [5] = love.graphics.newQuad(72, 0, 25, 25, 128, 128),
    [4] = love.graphics.newQuad(48, 0, 25, 25, 128, 128),
    [3] = love.graphics.newQuad(24, 0, 25, 25, 128, 128),
    [2] = love.graphics.newQuad(0, 0, 25, 25, 128, 128),
    [1] = love.graphics.newQuad(0, 25, 25, 24, 128, 128),
    [0] = love.graphics.newQuad(0, 48, 25, 25, 128, 128),
    [15] = love.graphics.newQuad(0, 72, 25, 25, 128, 128),
    [14] = love.graphics.newQuad(0, 96, 25, 25, 128, 128),
    [13] = love.graphics.newQuad(24, 96, 25, 25, 128, 128),
    [12] = love.graphics.newQuad(48, 96, 25, 25, 128, 128),
    [11] = love.graphics.newQuad(72, 96, 25, 25, 128, 128),
    [10] = love.graphics.newQuad(96, 96, 25, 25, 128, 128),
    [9] = love.graphics.newQuad(96, 72, 25, 25, 128, 128)
  },
  ox = -13,
  oy = -13,
}

function exhaust3_fx:init()
  self.texture = self.textures[0]
  self.quad = self.quads[0]
  return self
end

function exhaust3_fx:set_sprite_rotation(angle_in_degrees)
  self.quad = self.quads[math.ceil( angle_in_degrees / 22.5 )]
end

function exhaust3_fx:animate()
  self.texture = self.textures[math.floor(love.timer.getTime() * 15) % 3]
end

function exhaust3_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return exhaust3_fx
