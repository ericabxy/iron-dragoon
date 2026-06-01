local iron_plague_guard_fx = require('src.iron_plague_guard_fx')
local bullet = require('src.bullet')

local guardian_turret = iron_plague_guard_fx:new{
  angle = 0,
  turning_direction = 1,
}

function guardian_turret:move(dt)
  local segment = (2 * math.pi) / 8
  self.angle = self.angle + self.turning_direction * dt
  self.angle = self.angle % (2 * math.pi)
  self.quad = self.quads[math.floor( self.angle / segment )]
  if love.math.random(100) <= 1 then
    self.turning_direction = -self.turning_direction
    return {
      bullet:new{
        x = self.x + math.cos(self.angle) * 10,
        y = self.y + math.sin(self.angle) * 10,
        angle = self.angle
      }
    }
  end
end

function guardian_turret:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return guardian_turret
