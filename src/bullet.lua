local bulletsprite = require('src.bulletsprite')

local bullet = bulletsprite:new{
  space_width = 256,
  space_height = 256,
  time_to_live = 750,
  angle = 0,
  speed = 250,
}

function bullet:init()
  --self:shift(36, 0)
  local n = math.floor(math.deg(self.angle) / 45)
  self.quad = self.quads[n]
  return self
end

function bullet:move(dt)
  self.x = (self.x + math.cos(self.angle) * self.speed * dt) % self.space_width
  self.y = (self.y + math.sin(self.angle) * self.speed * dt) % self.space_height
  self.time_to_live = self.time_to_live - dt * 1000
  if self.time_to_live < 0 then
    self.remove_me_from_all_lists = true
  end
end

function bullet:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return bullet
