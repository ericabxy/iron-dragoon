--- Physical geometry for circle-based collisions.
-- @module src.hitball
local hitball = {
  radius = 8,
  x = 0,
  y = 0,
}

function hitball:is_touching(o)
  local dx, dy = o.x - self.x, o.y - self.y
  return math.sqrt(dx * dx + dy * dy) < o.radius + self.radius
end

function hitball:is_touching_box(x, y)
  -- TODO: Implement circle-box collision physics.
end

function hitball:is_touching_point(x, y)
  local dx, dy = x - self.x, y - self.y
  return math.sqrt(dx * dx + dy * dy) < self.radius
end

function hitball:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return hitball
