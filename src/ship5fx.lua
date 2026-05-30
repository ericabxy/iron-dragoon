local sprite = require('src.sprite')

local ship5fx = sprite:new{
  sfx_helicopter_loop = love.audio.newSource('share/sfx_vehicle_helicopterloop2.wav', 'static'),
  texture = love.graphics.newImage('share/iron_plague_ship5.png'),
  quad = love.graphics.newQuad(0, 0, 25, 25, 128, 32),
  textures = {},
  quads = {},
  ox = 12,
  oy = 12,
}

ship5fx.sfx_helicopter_loop:setLooping(true)
ship5fx.quads[0] = ship5fx.quad
ship5fx.quads[1] = love.graphics.newQuad(24, 0, 25, 25, 128, 32)
ship5fx.quads[2] = love.graphics.newQuad(48, 0, 25, 25, 128, 32)
ship5fx.quads[3] = love.graphics.newQuad(72, 0, 25, 25, 128, 32)

function ship5fx:animate()
  local fps = 15
  self.quad = self.quads[math.floor(love.timer.getTime() * fps) % 4]
end

function ship5fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return ship5fx
