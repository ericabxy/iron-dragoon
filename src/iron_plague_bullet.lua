local sprite = require('src.sprite')

local CARDINALS = 16
local STEP_IN_DEGREES = 22.5

local iron_plague_bullet = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/iron_plague_bullet2_flame.png'),
    [1] = love.graphics.newImage('share/iron_plague_bullet2_frost.png'),
    [2] = love.graphics.newImage('share/iron_plague_bullet2_fluid.png'),
  },
  quads_size_a = {
    [0] = love.graphics.newQuad(24, 12, 13, 13, 128, 64),
    [2] = love.graphics.newQuad(24, 24, 13, 13, 128, 64),
    [4] = love.graphics.newQuad(12, 24, 13, 13, 128, 64),
    [6] = love.graphics.newQuad(0, 24, 13, 13, 128, 64),
    [8] = love.graphics.newQuad(0, 12, 13, 13, 128, 64),
    [10] = love.graphics.newQuad(0, 0, 13, 13, 128, 64),
    [12] = love.graphics.newQuad(12, 0, 13, 13, 128, 64),
    [14] = love.graphics.newQuad(24, 0, 13, 13, 128, 64),
  },
  quads_size_b = {
    [0] = love.graphics.newQuad(60, 12, 13, 13, 128, 64),
    [2] = love.graphics.newQuad(60, 24, 13, 13, 128, 64),
    [4] = love.graphics.newQuad(48, 24, 13, 13, 128, 64),
    [6] = love.graphics.newQuad(36, 24, 13, 13, 128, 64),
    [8] = love.graphics.newQuad(36, 12, 13, 13, 128, 64),
    [10] = love.graphics.newQuad(36, 0, 13, 13, 128, 64),
    [12] = love.graphics.newQuad(48, 0, 13, 13, 128, 64),
    [14] = love.graphics.newQuad(60, 0, 13, 13, 128, 64),
  },
  quads_size_c = {
    [0] = love.graphics.newQuad(96, 12, 13, 13, 128, 64),
    [2] = love.graphics.newQuad(96, 24, 13, 13, 128, 64),
    [4] = love.graphics.newQuad(84, 24, 13, 13, 128, 64),
    [6] = love.graphics.newQuad(72, 24, 13, 13, 128, 64),
    [8] = love.graphics.newQuad(72, 12, 13, 13, 128, 64),
    [10] = love.graphics.newQuad(72, 0, 13, 13, 128, 64),
    [12] = love.graphics.newQuad(84, 0, 13, 13, 128, 64),
    [14] = love.graphics.newQuad(96, 0, 13, 13, 128, 64),
  },
  angle_in_degrees = 0,  -- Default to pointing "right".
  fine_angle_in_degrees = 11.25,  -- Track degrees since radians are floating-point imprecise.
  cardinal = 0,  -- "Right" is the zeroth cardinal.
  angle = 0,  -- Default to pointing "right".
  ox = -6,
  oy = -6,
}

-- Fill in the extra directions with repeated quads.
for x = 2, 14, 4 do
  iron_plague_bullet.quads_size_a[x - 1] = iron_plague_bullet.quads_size_a[x]
  iron_plague_bullet.quads_size_b[x - 1] = iron_plague_bullet.quads_size_b[x]
  iron_plague_bullet.quads_size_c[x - 1] = iron_plague_bullet.quads_size_c[x]
  iron_plague_bullet.quads_size_a[x + 1] = iron_plague_bullet.quads_size_a[x]
  iron_plague_bullet.quads_size_b[x + 1] = iron_plague_bullet.quads_size_b[x]
  iron_plague_bullet.quads_size_c[x + 1] = iron_plague_bullet.quads_size_c[x]
end

iron_plague_bullet.quads = iron_plague_bullet.quads_size_a
iron_plague_bullet.texture = iron_plague_bullet.textures[0]
iron_plague_bullet.quad = iron_plague_bullet.quads[0]

function iron_plague_bullet:is_touching(o)
  local hitsize = 5
  if math.abs(self.x - o.x) < hitsize and math.abs(self.y - o.y) < hitsize then return true end
end

function iron_plague_bullet:set_angle(angle)
  self.angle_in_degrees = math.deg(angle)
  self.cardinal = math.floor(CARDINALS * angle / (2 * math.pi) + CARDINALS + 0.5) % CARDINALS
  self.quad = self.quads[self.cardinal]
  self.angle = angle
end

function iron_plague_bullet:rotate(a)
  local angle_in_degrees = math.deg(a)
  self.fine_angle_in_degrees = self.fine_angle_in_degrees + angle_in_degrees
  if self.fine_angle_in_degrees > STEP_IN_DEGREES then
    self.angle_in_degrees = self.angle_in_degrees + STEP_IN_DEGREES
    self.cardinal = (self.cardinal + 1) % CARDINALS
    self.quad = self.quads[self.cardinal]
  elseif self.fine_angle_in_degrees < 0 then
    self.angle_in_degrees = self.angle_in_degrees - STEP_IN_DEGREES
    self.cardinal = (self.cardinal - 1) % CARDINALS
    self.quad = self.quads[self.cardinal]
  end
  self.fine_angle_in_degrees = self.fine_angle_in_degrees % STEP_IN_DEGREES
  self.angle_in_degrees = self.angle_in_degrees % 360
  self.angle = math.rad(self.angle_in_degrees)
end

function iron_plague_bullet:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return iron_plague_bullet
