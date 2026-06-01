local sprite = require('src.sprite')

local iron_plague_guard_fx = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/iron_plague_guard.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(75, 46, 30, 30, 128, 128),
    [1] = love.graphics.newQuad(76, 16, 30, 30, 128, 128),
    [2] = love.graphics.newQuad(45, 17, 30, 30, 128, 128),
    [3] = love.graphics.newQuad(15, 16, 30, 30, 128, 128),
    [4] = love.graphics.newQuad(16, 46, 30, 30, 128, 128),
    [5] = love.graphics.newQuad(15, 77, 30, 30, 128, 128),
    [6] = love.graphics.newQuad(45, 76, 30, 30, 128, 128),
    [7] = love.graphics.newQuad(76, 77, 30, 30, 128, 128),
  },
  ox = -15,
  oy = -15,
}

function iron_plague_guard_fx:init()
  self.texture = self.textures[0]
  self.quad = self.quads[0]
  return self
end

function iron_plague_guard_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_guard_fx
