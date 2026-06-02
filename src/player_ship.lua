local iron_plague_pship = require('src.iron_plague_pship2')

local player_ship = iron_plague_pship:new{
  iron_dragoon_type = 'playership',
  controller_number = 1,
  arena_width = 260,
  arena_height = 240,
  thrust_per_second = 175,
  turn_speed = 3.5,
  dx = 0,  -- x velocity (change in x position over delta time)
  dy = 0,  -- y velocity (change in y position over delta time)
  --
  bullet_cooldown_timer = 0,
  invincibility_timer = 0,
  hit_points = 64,
}

function player_ship:control(dt)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.dx = self.dx + math.cos(self.angle) * self.thrust_per_second * dt
    self.dy = self.dy + math.sin(self.angle) * self.thrust_per_second * dt
    self:sfx_rocket_loop_on()
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    self:rotate(-self.turn_speed * dt)
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    self:rotate(self.turn_speed * dt)
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
  if not love.joystick.isDown(1, 5) then self:sfx_rocket_loop_off() end
end

function player_ship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return player_ship
