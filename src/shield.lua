--- @module src.debris_shield
-- Object protection against collisions with bullets or debris.
local shield = {
  hit_points = 100,  -- Start at a reasonable amount of hit points.
}

function shield:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  --o.sfx_damage = love.audio.newSource('share/', 'static')
  return o
end

function shield:take_damage(o)
  if not o.damage_value then return end
  --if not self.sfx_damage:isPlaying() then love.audio.play(self.sfx_damage) end
  self.hitpoints = self.hitpoints - o.damage_value
  o.remove_me_from_all_lists = true
end

return shield
