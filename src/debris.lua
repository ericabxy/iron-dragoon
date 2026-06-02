--- @module src.debris_sprite
local iron_plague_debris = require('src.iron_plague_debris')
local explode2 = require('src.explode2')

local LARGE = 'large'
local MEDIUM = 'medium'
local SMALL = 'small'

-- class table
local debris = iron_plague_debris:new{
  iron_dragoon_type = 'debris',
  space_width = 260,
  space_height = 240,
  size = LARGE,
  speed = 20,
  dx = 0,
  dy = 0,
}

function debris:init()
  local angle = love.math.random() * ( 2 * math.pi )
  self.texture = self.textures[self.size]
  self.dx = math.cos(angle) * self.speed 
  self.dy = math.sin(angle) * self.speed
  return self
end

function debris:check_for_collision_with_bullets(bullets_t)
  -- TODO: Code debris to handle this check internally.
end

-- Remove this debris from play and optionally spawn two smaller debris.
-- Usually called when a bullet hits a debris.
function debris:destroy()
  local angle1 = love.math.random() * (2 * math.pi)
  local angle2 = (angle1 - math.pi) % (2 * math.pi)
  self.remove_me_from_all_lists = true
  self:play_sfx_explode()
  if self.size == LARGE then
    return {
      debris:new{ x = self.x, y = self.y, angle = angle1, speed = 30, size = MEDIUM },
      debris:new{ x = self.x, y = self.y, angle = angle2, speed = 30, size = MEDIUM },
    }
  elseif self.size == MEDIUM then
    return {
      debris:new{ x = self.x, y = self.y, angle = angle1, speed = 40, size = SMALL },
      debris:new{ x = self.x, y = self.y, angle = angle2, speed = 40, size = SMALL },
    }
  end  
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
