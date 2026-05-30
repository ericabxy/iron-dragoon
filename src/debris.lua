--- @module src.debris_sprite
local debris_sprite = require('src.debris_sprite')
local explode2 = require('src.explode2')

local LARGE = 2
local MEDIUM = 1
local SMALL = 0

-- class table
local debris = debris_sprite:new{
  iron_dragoon_type_id = 'debris',
  space_width = 256,
  space_height = 256,
  size = LARGE,
  dx = 0,
  dy = 0,
}

function debris:collide_with_bullet(this_bullet)
  local angle1 = love.math.random() * (2 * math.pi)
  local angle2 = (angle1 - math.pi) % (2 * math.pi)
  local spawns = {}
  self:play_sfx_explode()
  self.remove_me_from_all_lists = true
  this_bullet.remove_me_from_all_lists = true
  table.insert(spawns, explode2:new{ x = self.x, y = self.y })
  -- Breakup into smaller debris.
  if self.size == LARGE then
    table.insert(spawns, debris:new{ size = MEDIUM, x = self.x, y = self.y, angle = angle1 })
    table.insert(spawns, debris:new{ size = MEDIUM, x = self.x, y = self.y, angle = angle2 })
  elseif self.size == MEDIUM then
    table.insert(spawns, debris:new{ size = SMALL, x = self.x, y = self.y, angle = angle1 })
    table.insert(spawns, debris:new{ size = SMALL, x = self.x, y = self.y, angle = angle2 })
  end
  return spawns
end

function debris:init()
  local speed = self.size == LARGE and 20 or self.size == MEDIUM and 30 or self.size == SMALL and 40
  local angle = love.math.random() * ( 2 * math.pi )
  self.texture = self.textures[self.size]
  self.dx = math.cos(angle) * speed 
  self.dy = math.sin(angle) * speed
  return self
end

function debris:is_touching_bullet(o)
  local hitsize = 5
  if self.x - hitsize < o.x and self.x + hitsize > o.x and self.y - hitsize < o.y and self.y + hitsize > o.y then
    return true
  end
end

-- Move according to momentum and update graphics
function debris:move(dt)
  self.x = (self.x + self.dx * dt) % self.space_width
  self.y = (self.y + self.dy * dt) % self.space_height
  self:animate(dt)
end

function debris:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return debris
