local bulletsprite = require('src.iron_plague_bullet_flame_sixteen_way_fx')

local bullet = bulletsprite:new{
  iron_dragoon_type_id = 'bullet',
  iron_dragoon_bullet_type = 'flame',
  space_width = 256,
  space_height = 256,
  time_to_live = 750,
  angle = 0,
  speed = 200,
}

function bullet:init()
  self:set_sprite_angle(math.deg( self.angle ))
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
  return o:init()
end

return bullet
