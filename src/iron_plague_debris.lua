local hitball = require('src.hitball')
local sprite = require('src.sprite')

--local explode_sfx_filename = 'share/sfx_exp_shortest_hard1.wav'
local explode_sfx_filename = 'share/sfx_exp_short_soft1.wav'

local RADIUS1 = 4.5
local RADIUS2 = 2.5
local RADIUS3 = 3.5
local LARGE = 1
local MEDIUM = 3
local SMALL = 2

local iron_plague_debris = sprite:new{
  textures = {
    large = love.graphics.newImage('share/iron_plague_debris1.png'),
    small = love.graphics.newImage('share/iron_plague_debris2.png'),
    medium = love.graphics.newImage('share/iron_plague_debris3.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(0, 0, 25, 25, 145, 25),
    [1] = love.graphics.newQuad(24, 0, 25, 25, 145, 25),
    [2] = love.graphics.newQuad(48, 0, 25, 25, 145, 25),
    [3] = love.graphics.newQuad(72, 0, 25, 25, 145, 25),
    [4] = love.graphics.newQuad(96, 0, 25, 25, 145, 25),
    [5] = love.graphics.newQuad(120, 0, 25, 25, 145, 25),
  },
  -- Load a limited number of channels to play multiple explosion sounds at once.
  sfx_explode = love.audio.newSource(explode_sfx_filename, 'static'),
  sfx_explode2 = love.audio.newSource(explode_sfx_filename, 'static'),
  sfx_explode3 = love.audio.newSource(explode_sfx_filename, 'static'),
  radius = RADIUS1,
  ox = -13,
  oy = -13,
  x = 0,
  y = 0,
}

iron_plague_debris.texture = iron_plague_debris.textures.large
iron_plague_debris.quad = iron_plague_debris.quads[0]

function iron_plague_debris:animate()
  local fps = 15
  self.quad = self.quads[math.floor(love.timer.getTime() * fps) % 6]
end

function iron_plague_debris:play_sfx_explode()
  if not self.sfx_explode:isPlaying() then love.audio.play(self.sfx_explode)
  elseif not self.sfx_explode2:isPlaying() then love.audio.play(self.sfx_explode2)
  elseif not self.sfx_explode3:isPlaying() then love.audio.play(self.sfx_explode3) end
end

function iron_plague_debris:set_size_to_large()
  self.texture = self.textures.large
  self.radius = RADIUS1
  self.ox = -13
  self.oy = -13
end

function iron_plague_debris:set_size_to_medium()
  self.texture = self.textures.medium
  self.radius = RADIUS3
  self.ox = -14
  self.oy = -13
end

function iron_plague_debris:set_size_to_small()
  self.texture = self.textures.small
  self.radius = RADIUS2
  self.ox = -15
  self.oy = -13
end

function iron_plague_debris:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return iron_plague_debris
