local libretro_constants = require('src.libretro_constants')
local bullet = require('src.bullet_standard')
local exhaust3_fx = require('src.iron_plague_exhaust3_fx')
local ship2_fx = require('src.iron_plague_ship2_fx')
local vector = require('src.vector')

local starship_picket = ship2_fx:new{
  rotation_value_fine = 0,
  coarse_angle_in_degrees = 0,
  rotation_value_fine = 0,
  bullet_cooldown_timer = 0,
  coarse_angle_in_degrees = 0,
  velocity = vector:new(),
  controller_number = 0,
  velocity_x = 0,
  velocity_y = 0,
  turn_speed = 4,
  angle = 1.5 * math.pi,
  arena_width = 256,
  arena_height = 256,
}

function starship_picket:init()
  self.exhaust = exhaust3_fx:new{ x = self.x, y = self.y }
  return self
end

function starship_picket:control(dt)
  if self.controller_number < 1 or self.controller_number > 8 then return end
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

function starship_picket:fire_weapons()
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if self.bullet_cooldown_timer > 0 then return end
  local bullet_radius = 3
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_B) then
    self.bullet_cooldown_timer = 350
    local new_bullet = bullet:new{
      x = self.x + math.cos(math.rad(self.coarse_angle_in_degrees)) * bullet_radius,
      y = self.y + math.sin(math.rad(self.coarse_angle_in_degrees)) * bullet_radius,
      angle = math.rad(self.coarse_angle_in_degrees)
    }
    new_bullet:set_sprite_rotation(self.coarse_angle_in_degrees)
    return new_bullet
  end
end

function starship_picket:move(dt)
  local steps = 16
  local exhaust_radius = 20
  local cardinal = math.floor(steps * self.angle / (2 * math.pi) + steps + 0.5) % steps
  self.x = (self.x + self.velocity_x * dt) % self.arena_width
  self.y = (self.y + self.velocity_y * dt) % self.arena_height
  self.velocity_x = self.velocity_x * .975
  self.velocity_y = self.velocity_y * .975
  self.exhaust.x = math.floor(self.x) - math.cos(cardinal * (math.pi / 8)) * exhaust_radius
  self.exhaust.y = math.floor(self.y) - math.sin(cardinal * (math.pi / 8)) * exhaust_radius
  if self.bullet_cooldown_timer > 0 then
    self.bullet_cooldown_timer = self.bullet_cooldown_timer - dt * 1000
  end
end

function starship_picket:paint(x, y)
  ship2_fx.paint(self, x, y)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.exhaust:paint(x, y)
  end
end

function starship_picket:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return starship_picket
