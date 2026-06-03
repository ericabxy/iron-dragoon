local iron_plague_bullet = require('src.iron_plague_bullet')

local bullet = iron_plague_bullet:new{
  iron_dragoon_type = 'bullet',
  iron_dragoon_bullet_type = 'flame',
  max_width = 256,
  max_height = 256,
  time_to_live = 800,
  speed = 200,
  dx = 0,
  dy = 0,
}

function bullet:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  o.dx = o.dx + math.cos(o.angle) * o.speed
  o.dy = o.dy + math.sin(o.angle) * o.speed
  o:set_angle(o.angle)
  return o
end

function bullet:move(dt)
  self.x = (self.x + self.dx * dt) % self.max_width
  self.y = (self.y + self.dy * dt) % self.max_height
  self.time_to_live = self.time_to_live - dt * 1000
  if self.time_to_live < 0 then
    self.remove_me_from_all_lists = true
  end
end

return bullet
