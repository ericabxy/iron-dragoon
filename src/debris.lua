--- @module src.debris_sprite
local explode2 = require('src.explode2')
local iron_plague_debris = require('src.iron_plague_debris')

local LARGE = 'large'
local MEDIUM = 'medium'
local SMALL = 'small'
local LARGESPEED = 25
local MEDIUMSPEED = 40
local SMALLSPEED = 55
local LARGEVALUE = 25
local MEDIUMVALUE = 50
local SMALLVALUE = 100

-- class table
local debris = iron_plague_debris:new{
  iron_dragoon_type = 'debris',
  currently_spawning = true,
  space_width = 256,
  space_height = 256,
  value = LARGEVALUE,
  size = LARGE,
  speed = LARGESPEED,
  dx = 0,
  dy = 0,
}

function debris:init()
  local angle = love.math.random() * ( 2 * math.pi )
  self.texture = self.textures[self.size]
  self.dx = self.dx + math.cos(angle) * self.speed 
  self.dy = self.dy + math.sin(angle) * self.speed
  return self
end

function debris:check_for_collision_with_bullets(bullets_t)
  -- TODO: Code debris to handle this check internally.
  for i = #bullets_t, 1, -1 do
    local this_bullet = bullets_t[i]
    if self:is_touching_bullet(this_bullet) then
    end
  end
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
      debris:new{ x = self.x, y = self.y, angle = angle1, speed = MEDIUMSPEED, size = MEDIUM, value = MEDIUMVALUE },
      debris:new{ x = self.x, y = self.y, angle = angle2, speed = MEDIUMSPEED, size = MEDIUM, value = MEDIUMVALUE },
      explode2:new{ x = self.x, y = self.y },
    }
  elseif self.size == MEDIUM then
    return {
      debris:new{ x = self.x, y = self.y, angle = angle1, speed = SMALLSPEED, size = SMALL, value = SMALLVALUE },
      debris:new{ x = self.x, y = self.y, angle = angle2, speed = SMALLSPEED, size = SMALL, value = SMALLVALUE },
      explode2:new{ x = self.x, y = self.y },
    }
  elseif self.size == SMALL then
    return {
      explode2:new{ x = self.x, y = self.y },
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
  self:animate(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = self.x % self.space_width
  self.y = self.y % self.space_height
end

function debris:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return debris
