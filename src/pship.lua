local exhaust2sprite = require('src.exhaust2sprite')
local pship2fx = require('src.pship2fx')
local iron_plague_pship = require('src.iron_plague_pship')

local exhaust_offset = {
  [0] = { x = -19, y = -9 }, { x = -19, y = -13 }, { x = -17, y = -17 }, { x = -13, y = -19 },
        { x = -9, y = -19 }, { x = -6, y = -19 }, { x = -2, y = -17 }, { x = 1, y = -13 },
        { x = 1, y = -9 }, { x = 1, y = -5 }, { x = -2, y = -2 }, { x = -6, y = 1 },
        { x = -9, y = 1 }, { x = -13, y = 1 }, { x = -17, y = -2 }, { x = -19, y = -6 }
}

local delta_x = { [0] = 1, .9, .7, .4, 0, -.4, -.7, -.9, -1, -.9, -.7, -.4, 0, .4, .7, .9 }
local delta_y = { [0] = 0, .4, .7, .9, 1, .9, .7, .4, 0, -.4, -.7, -.9, -1, -.9, -.7, -.4 }

local pship = pship2fx:new{
  iron_dragoon_type_id = 'playership',
  rotation_angle_sub = 0,
  rotation_angle = 0,
  controller_number = 1,
  bullet_cooldown_timer = 0,
  invincibility_timer = 0,
  rotation_number = 0,
  space_width = 256,
  space_height = 256,
  hit_points = 64,
  heading_n = 0,
  rotation = 0,
  radius = 12,
  angle = 0,
  dx = 0,
  dy = 0,
}

function pship:init()
  self.texture = self.textures[2]
  self.exhaust = exhaust2sprite:new{
    x = self.x, y = self.y, ox = exhaust_offset[0].x, oy = exhaust_offset[0].y
  }
  return self
end

function pship:is_touching(o)
  local hitsize = 7
  local otherhs = 3
  if self.x - hitsize < o.x + otherhs and self.x + hitsize > o.x - otherhs and self.y - hitsize < o.y + otherhs and self.y + hitsize > o.y - otherhs then
    return true
  end
end

function pship:accelerate(dt)
  local segment = (2 * math.pi) / 16
  local speed = 200
  self.dx = self.dx + delta_x[self.rotation_angle] * speed * dt
  self.dy = self.dy + delta_y[self.rotation_angle] * speed * dt
  self:sfx_rocket_loop_on()
end

function pship:fire_bullet()
  local segment = (2 * math.pi) / 16
  if self.bullet_cooldown_timer <= 0 then
    self.bullet_cooldown_timer = 350
    self:play_sfx_bullet_fire()
    return {
      x = self.x + delta_x[self.rotation_angle] * self.radius,
      y = self.y + delta_y[self.rotation_angle] * self.radius,
      angle = self.rotation_angle * segment
    }
  end
end

function pship:move(dt)
  self.x = (self.x + self.dx * dt) % self.space_width
  self.y = (self.y + self.dy * dt) % self.space_height
  self.dx = self.dx * 0.97
  self.dy = self.dy * 0.97
  self.exhaust.x = self.x
  self.exhaust.y = self.y
  self.exhaust.texture = self.exhaust.textures[math.floor(love.timer.getTime() * 15) % 2]
  if self.invincibility_timer > 0 then self.invincibility_timer = self.invincibility_timer - dt * 1000 end
  if not love.joystick.isDown(1, 5) then self:sfx_rocket_loop_off() end
  if self.bullet_cooldown_timer > 0 then self.bullet_cooldown_timer = self.bullet_cooldown_timer - dt * 1000 end
end

function pship:paint(x, y)
  pship2fx.paint(self, x, y)
  if love.joystick.isDown(1, 5) then self.exhaust:paint(x, y) end
end

function pship:rotate(dt)
  local coarse_angle = 22.5
  local speed = 250
  self.rotation_angle_sub = self.rotation_angle_sub + speed * dt
  if self.rotation_angle_sub > coarse_angle then
    self.rotation_angle = (self.rotation_angle + 1) % 16
  elseif self.rotation_angle_sub < 0 then
    self.rotation_angle = (self.rotation_angle - 1) % 16
  end
  self.rotation_angle_sub = self.rotation_angle_sub % 22.5
  self.quad = self.quads[self.rotation_angle]
  self.exhaust.quad = self.exhaust.quads[self.rotation_angle]
  self.exhaust.ox = exhaust_offset[self.rotation_angle].x
  self.exhaust.oy = exhaust_offset[self.rotation_angle].y
end

function pship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return pship
