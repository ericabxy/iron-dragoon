local iron_plague_bullet = require('src.iron_plague_bullet')

local bullet = iron_plague_bullet:new{
  iron_dragoon_type = 'bullet',
  iron_dragoon_bullet_type = 'flame',
  space_width = 260,
  space_height = 240,
  time_to_live = 800,
  speed = 200,
}

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
  return o:init()
end

return bullet
