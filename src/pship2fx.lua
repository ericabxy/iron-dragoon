local exhaust2sprite = require('src.exhaust2sprite')
local sprite = require('src.sprite')

--local bullet_sfx_filename = 'share/sfx_wpn_laser1.wav'
local bullet_sfx_filename = 'share/sfx_weapon_singleshot21.wav'

local pship2fx = sprite:new{
  exhaust = exhaust2sprite:new(),
  -- Load a limited number of channels to play multiple bullet sounds at once.
  sfx_bullet_fire = love.audio.newSource(bullet_sfx_filename, 'static'),
  sfx_bullet_fire2 = love.audio.newSource(bullet_sfx_filename, 'static'),
  sfx_bullet_fire3 = love.audio.newSource(bullet_sfx_filename, 'static'),
  sfx_rocket_loop = love.audio.newSource('share/sfx_vehicle_plainloop.wav', 'static'),
  texture = love.graphics.newImage('share/iron_plague_ship.png'),
  quad = love.graphics.newQuad(96, 48, 25, 25, 128, 128),
  textures = {},
  quads = {},
  ox = -13,
  oy = -13,
  x = 0,
  y = 0,
}

pship2fx.sfx_rocket_loop:setLooping(true)
pship2fx.textures[0] = pship2fx.texture
pship2fx.textures[1] = love.graphics.newImage('share/iron_plague_ship2.png')
pship2fx.textures[2] = love.graphics.newImage('share/iron_plague_pship2.png')
pship2fx.quads[0] = pship2fx.quad
pship2fx.quads[1] = love.graphics.newQuad(96, 72, 25, 25, 128, 128)
pship2fx.quads[2] = love.graphics.newQuad(96, 96, 25, 25, 128, 128)
pship2fx.quads[3] = love.graphics.newQuad(72, 96, 25, 25, 128, 128)
pship2fx.quads[4] = love.graphics.newQuad(48, 96, 25, 25, 128, 128)
pship2fx.quads[5] = love.graphics.newQuad(24, 96, 25, 25, 128, 128)
pship2fx.quads[6] = love.graphics.newQuad(0, 96, 25, 25, 128, 128)
pship2fx.quads[7] = love.graphics.newQuad(0, 72, 25, 25, 128, 128)
pship2fx.quads[8] = love.graphics.newQuad(0, 48, 25, 25, 128, 128)
pship2fx.quads[9] = love.graphics.newQuad(0, 24, 25, 25, 128, 128)
pship2fx.quads[10] = love.graphics.newQuad(0, 0, 25, 25, 128, 128)
pship2fx.quads[11] = love.graphics.newQuad(24, 0, 25, 25, 128, 128)
pship2fx.quads[12] = love.graphics.newQuad(48, 0, 25, 25, 128, 128)
pship2fx.quads[13] = love.graphics.newQuad(72, 0, 25, 25, 128, 128)
pship2fx.quads[14] = love.graphics.newQuad(96, 0, 25, 25, 128, 128)
pship2fx.quads[15] = love.graphics.newQuad(96, 24, 25, 25, 128, 128)

function pship2fx:init()
  self.texture = self.textures[0]
  return self
end

function pship2fx:play_sfx_bullet_fire()
  if not self.sfx_bullet_fire:isPlaying() then love.audio.play(self.sfx_bullet_fire)
  elseif not self.sfx_bullet_fire2:isPlaying() then love.audio.play(self.sfx_bullet_fire2)
  elseif not self.sfx_bullet_fire3:isPlaying() then love.audio.play(self.sfx_bullet_fire3) end
end

function pship2fx:sfx_rocket_loop_off()
  love.audio.stop(self.sfx_rocket_loop)
end

function pship2fx:sfx_rocket_loop_on()
  if not self.sfx_rocket_loop:isPlaying() then love.audio.play(self.sfx_rocket_loop) end
end

function pship2fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return pship2fx
