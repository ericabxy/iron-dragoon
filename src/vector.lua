--- @module src.vector
local vector = {}

-- class table
local Vector = {
  x = 0,
  y = 0,
}

function Vector:Vector()
end

function Vector:set(x, y)
  self.x = x
  self.y = y
end

function Vector:length()
  return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector:add(v)
  self.x = self.x + v.x
  self.y = self.y + v.y
end

function Vector:subtract(v)
  self.x = self.x - v.x
  self.y = self.y - v.y
end

function Vector:normalize()
  local d = math.sqrt(self.x * self.x + self.y * self.y)
  assert(d > 0)
  return self.x / d, self.y / d
end

function Vector:scale(s)
  self.x = self.x * s
  self.y = self.y * s
end

function vector.new(...)
  local self = {}
  setmetatable(self, { __index = Vector })
  self:Vector(...)
  return self
end

return vector
