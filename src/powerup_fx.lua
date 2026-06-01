local sprite = require('src.sprite')

local powerup_fx = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/powerups.png')
  },
  quads = {
    [0] = love.graphics.newQuad(0, 0, 17, 17, 71, 97),
    [1] = love.graphics.newQuad(16, 0, 17, 17, 71, 97),
    [2] = love.graphics.newQuad(32, 0, 17, 17, 71, 97)
  }
}

function powerup_fx:init()
  self.texture = self.textures[0]
  self.quad = self.quads[0]
  return self
end

function powerup_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return powerup_fx
