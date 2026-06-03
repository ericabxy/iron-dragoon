local bullet = require('src.bullet')
local iron_plague_pship = require('src.iron_plague_pship2')
local quickturn = require('src.quickturn')
local bullet_lv1 = bullet:new{ quads = bullet.quads_size_a }
local bullet_lv2 = bullet:new{ quads = bullet.quads_size_b }
local bullet_lv3 = bullet:new{ quads = bullet.quads_size_c }

local BULLETCOOLDOWN = 350
local QUICKTURNCOOLDOWN = 1000

local player_ship = iron_plague_pship:new{
  iron_dragoon_type = 'playership',
  controller_number = 1,
  arena_width = 256,
  arena_height = 256,
  thrust_per_second = 150,
  quickturn_speed = 16,
  quickturn_angle = false,
  quickturn_direction = 1,
  dx = 0,  -- x velocity (change in x position over delta time)
  dy = 0,  -- y velocity (change in y position over delta time)
  --
  quickturn_cooldown_timer = 0,
  bullet_cooldown_timer = 0,
  invincibility_timer = 0,
  hit_points = 100,
  score = 0,
}

function player_ship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  self.quickturn = quickturn:new{ destination = .5 * math.pi }
  return o
end

function player_ship:control(dt)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.dx = self.dx + math.cos(self.angle) * self.thrust_per_second * dt
    self.dy = self.dy + math.sin(self.angle) * self.thrust_per_second * dt
    self:sfx_rocket_loop_on()
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_DOWN) then
    if self.quickturn.cooldown <= 0 then
      self.quickturn:start(self.angle + math.pi)
    end
    if self.quickturn.destination then
      if math.abs(self.angle - self.quickturn.destination) < (math.pi / 10) then
        self.quickturn.destintion = false
      else
        self:rotate(self.quickturn.speed * dt * self.quickturn.direction)
      end
    end
  end
  self:turn_leftright(RETRO_DEVICE_ID_JOYPAD_LEFT, RETRO_DEVICE_ID_JOYPAD_RIGHT, dt)
  return self:fire_bullet(RETRO_DEVICE_ID_JOYPAD_B)
end

function player_ship:turn_leftright(left_button, right_button, frac)
  local turn_speed = 4
  frac = frac or .03  -- Assume a framerate of 30fps unless specified.
  if love.joystick.isDown(self.controller_number, left_button) then
    self:rotate(-turn_speed * frac)
    self.quickturn_direction = -1  -- "Quickturn" always rotates in the last direction that was pressed.
  elseif love.joystick.isDown(self.controller_number, right_button) then
    self:rotate(turn_speed * frac)
    self.quickturn_direction = 1  -- "Quickturn" always rotates in the last direction that was pressed.
  end
end

function player_ship:fire_bullet(fire_button)
  if self.bullet_cooldown_timer <= 0 and love.joystick.isDown(self.controller_number, fire_button) then
    local bullet_r = 12
    local bullet_x = self.x + math.cos(self.angle) * bullet_r
    local bullet_y = self.y + math.sin(self.angle) * bullet_r
    self.bullet_cooldown_timer = BULLETCOOLDOWN
    self:play_sfx_bullet_fire()
    return {
      bullet:new{ x = bullet_x, y = bullet_y, angle = self.angle },
    }
  end
end

function player_ship:move(dt)
  -- Move ship by current velocity and wrap at screen edges.
  self.x = (self.x + self.dx * dt) % self.arena_width
  self.y = (self.y + self.dy * dt) % self.arena_height
  -- Apply aetherial friction.
  self.dx = self.dx * 0.98
  self.dy = self.dy * 0.98
  -- Handle ongoing state timers and sound effects.
  if self.invincibility_timer > 0 then self.invincibility_timer = self.invincibility_timer - dt * 1000 end
  if self.bullet_cooldown_timer > 0 then self.bullet_cooldown_timer = self.bullet_cooldown_timer - dt * 1000 end
  if self.quickturn.cooldown > 0 then self.quickturn.cooldown = self.quickturn.cooldown - dt * 1000 end
  if not love.joystick.isDown(1, 5) then self:sfx_rocket_loop_off() end
end

function player_ship:increase_weapon_power()
end

return player_ship
