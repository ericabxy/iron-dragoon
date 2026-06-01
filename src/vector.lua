--- @module src.vector
local vector = {}

-- class table
local Vector = {
  x = 0,
  y = 0,
}

function Vector:Vector(args)
  self.x = args and args.x or 0
  self.y = args and args.y or 0
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

function Vector:rotate(a)
  local cos = math.cos(a)
  local sin = math.sin(a)
  self.x = cos * self.x - sin * self.y
  self.y = sin * self.x + cos * self.y
end

function Vector:scale(s)
  self.x = self.x * s
  self.y = self.y * s
end

function Vector:vangle()
  return math.atan2(self.y, self.x) % (math.pi * 2)
end

function vector.new(...)
  local self = {}
  setmetatable(self, { __index = Vector })
  self:Vector(...)
  return self
end

return vector
