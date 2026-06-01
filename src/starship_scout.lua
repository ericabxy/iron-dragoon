local libretro_constants = require('src.libretro_constants')
local exhaust3_fx = require('src.iron_plague_exhaust3_fx')
local pship_fx = require('src.iron_plague_pship_fx')
local vector = require('src.vector')
local vector_sixteen = require('src.vector_sixteen')

local starship_scout = pship_fx:new{
  heading = vector_sixteen:new(),
  velocity = vector.new(),
  controller_number = 0,
  arena_width = 256,
  arena_height = 256,
  thrust_per_second = 200,
  velocity_x = 0,
  velocity_y = 0,
  heading_x = 0,
  heading_y = -1,
  angle = 1.5 * math.pi,
  turn_speed = 4,
}

function starship_scout:init()
  self.exhaust = exhaust3_fx:new{ x = self.x, y = self.y }
  return self
end

function starship_scout:control(dt)
  if self.controller_number == 0 then return end
  local steps = 16
  local thrust_per_second = 100
  local cardinal = math.floor(steps * self.angle / (2 * math.pi) + steps + 0.5) % steps
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.velocity_x = self.velocity_x + math.cos(cardinal * (math.pi / 8)) * thrust_per_second * dt
    self.velocity_y = self.velocity_y + math.sin(cardinal * (math.pi / 8)) * thrust_per_second * dt
    self.exhaust:animate()
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    self.angle = self.angle - self.turn_speed * dt
    self.angle = self.angle % (2 * math.pi) 
    self.quad = self.quads[cardinal]
    self.exhaust.quad = self.exhaust.quads[cardinal]
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    self.angle = self.angle + self.turn_speed * dt
    self.angle = self.angle % (2 * math.pi)
    self.quad = self.quads[cardinal]
    self.exhaust.quad = self.exhaust.quads[cardinal]
  end
end

function starship_scout:move(dt)
  local exhaust_radius = 20
  self.x = (self.x + self.velocity_x * dt) % self.arena_width
  self.y = (self.y + self.velocity_y * dt) % self.arena_height
  self.velocity_x = self.velocity_x * .975
  self.velocity_y = self.velocity_y * .975
  self.exhaust.x = math.floor(self.x) - math.cos(self.angle) * exhaust_radius
  self.exhaust.y = math.floor(self.y) - math.sin(self.angle) * exhaust_radius
end

function starship_scout:paint(x, y)
  pship_fx.paint(self, x, y)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.exhaust:paint(x, y)
  end
end

function starship_scout:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return starship_scout
