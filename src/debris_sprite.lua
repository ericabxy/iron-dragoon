local sprite = require('src.sprite')

--local explode_sfx_filename = 'share/sfx_exp_shortest_hard1.wav'
local explode_sfx_filename = 'share/sfx_exp_short_soft1.wav'

local debris_sprite = sprite:new{
  -- Load a limited number of channels to play multiple explosion sounds at once.
  sfx_explode = love.audio.newSource(explode_sfx_filename, 'static'),
  sfx_explode2 = love.audio.newSource(explode_sfx_filename, 'static'),
  sfx_explode3 = love.audio.newSource(explode_sfx_filename, 'static'),
  texture = love.graphics.newImage('share/iron_plague_debris2.png'),
  quad = love.graphics.newQuad(0, 0, 25, 25, 145, 25),
  textures = {},
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

function debris_sprite:animate()
  local fps = 15
  self.quad = self.quads[0] --math.floor(love.timer.getTime() * fps) % 6]
end

function debris_sprite:play_sfx_explode()
  if not self.sfx_explode:isPlaying() then love.audio.play(self.sfx_explode)
  elseif not self.sfx_explode2:isPlaying() then love.audio.play(self.sfx_explode2)
  elseif not self.sfx_explode3:isPlaying() then love.audio.play(self.sfx_explode3) end
end

function debris_sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return debris_sprite
