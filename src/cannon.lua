--- @module src.cannon
-- Player ability to fire a space bullet out of a space cannon.
local bullet = require('src.bullet')

local MAXCOOLDOWN = 400

local cannon = {
  radius = 8,  -- Distance to spawn bullet from origin.
  timer = 0,  -- Default to being ready to fire immediately.
}

function cannon:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  self.sfx_fire1 = love.audio.newSource('share/sfx_weapon_singleshot21.wav', 'static')
  self.sfx_fire2 = love.audio.newSource('share/sfx_weapon_singleshot21.wav', 'static')
  return o
end

function cannon:cool_down(dt)
  if self.timer > 0 then self.timer = self.timer - dt * 1000 else self.timer = 0 end
end

function cannon:fire(x, y, angle)
  x = x + math.cos(angle) * self.radius
  y = y + math.sin(angle) * self.radius
  self.timer = MAXCOOLDOWN
  if not self.sfx_fire1:isPlaying() then love.audio.play(self.sfx_fire1)
  elseif not self.sfx_fire2:isPlaying() then love.audio.play(self.sfx_fire2)
  end  -- Play sound effect if either source is available.
  return {
    bullet:new{ x = x, y = y, angle = angle },
  }
end

return cannon
