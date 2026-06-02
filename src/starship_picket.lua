local libretro_constants = require('src.libretro_constants')
local bullet = require('src.bullet_standard')
local exhaust3_fx = require('src.iron_plague_exhaust3_fx')
local ship2_fx = require('src.iron_plague_ship2_fx')
local vector = require('src.vector')
local vector_sixteen = require('src.vector_sixteen')

local starship_picket = ship2_fx:new{
  heading = vector_sixteen:new(),
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
  local thrust_per_second = 150
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.velocity_x = self.velocity_x + math.cos(self.heading.angle) * thrust_per_second * dt
    self.velocity_y = self.velocity_y + math.sin(self.heading.angle) * thrust_per_second * dt
    self.exhaust:animate()
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    self.angle = self.angle - self.turn_speed * dt
    self.angle = self.angle % (2 * math.pi) 
    --
    self.heading:rotate(-self.turn_speed * dt)
    self.quad = self.quads[self.heading.cardinal]
    self.exhaust.quad = self.exhaust.quads[self.heading.cardinal]
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    self.angle = self.angle + self.turn_speed * dt
    self.angle = self.angle % (2 * math.pi)
    --
    self.heading:rotate(self.turn_speed * dt)
    self.quad = self.quads[self.heading.cardinal]
    self.exhaust.quad = self.exhaust.quads[self.heading.cardinal]
  end
  if self.bullet_cooldown_timer <= 0 and love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_B) then
    local bullet_radius = 3
    self.bullet_cooldown_timer = 350
    local new_bullet = bullet:new{
      x = self.x + math.cos(self.heading.angle) * bullet_radius,
      y = self.y + math.sin(self.heading.angle) * bullet_radius,
      angle = self.heading.angle
    }
    new_bullet.quad = new_bullet.quads[math.floor(self.heading.cardinal / 2)]
    return new_bullet
  end
end

function starship_picket:move(dt)
  local exhaust_radius = 20
  self.x = (self.x + self.velocity_x * dt) % self.arena_width
  self.y = (self.y + self.velocity_y * dt) % self.arena_height
  self.velocity_x = self.velocity_x * .98
  self.velocity_y = self.velocity_y * .98
  self.exhaust.x = self.x - math.cos(self.heading.angle) * exhaust_radius
  self.exhaust.y = self.y - math.sin(self.heading.angle) * exhaust_radius
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
