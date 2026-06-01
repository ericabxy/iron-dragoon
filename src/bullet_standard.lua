local bullet_fx = require('src.iron_plague_bullets_frost_fx')

local bullet = bullet_fx:new{
  iron_dragoon_type_id = 'bullet',
  iron_dragoon_bullet_type = 'frost',
  arena_width = 256,
  arena_height = 256,
  time_to_live = 750,
  speed = 200,
  angle = 0,
}

function bullet:init()
  self:set_sprite_rotation(math.deg( self.angle ))
  return self
end

function bullet:move(dt)
  self.x = (self.x + math.cos(self.angle) * self.speed * dt) % self.arena_width
  self.y = (self.y + math.sin(self.angle) * self.speed * dt) % self.arena_height
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
