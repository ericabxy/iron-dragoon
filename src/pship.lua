local exhaust2sprite = require('src.exhaust2sprite')
local pship2sprite = require('src.pship2sprite')
local sfx_wpn_laser1 = require('src.sfx_wpn_laser1')
local vehicle_plainloop = require('src.vehicle_plainloop')

local exhaust_offset = {
  [0] = { x = -19, y = -9 }, { x = -19, y = -13 }, { x = -17, y = -17 }, { x = -13, y = -19 },
        { x = -9, y = -19 }, { x = -6, y = -19 }, { x = -2, y = -17 }, { x = 1, y = -13 },
        { x = 1, y = -9 }, { x = 1, y = -5 }, { x = -2, y = -2 }, { x = -6, y = 1 },
        { x = -9, y = 1 }, { x = -13, y = 1 }, { x = -17, y = -2 }, { x = -19, y = -6 }
}

local pship = pship2sprite:new{
  iron_dragoon_type_id = 'playership',
  controller_number = 1,
  sfx_rocket = vehicle_plainloop:new(),
  sfx_bullet = sfx_wpn_laser1:new(),
  bullet_cooldown_timer = 0,
  invincibility_timer = 0,
  space_width = 256,
  space_height = 256,
  hit_points = 64,
  firing_angle = 0,
  heading_n = 0,
  rotation = 0,
  angle = 0,
  dx = 0,
  dy = 0,
}

function pship:init()
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
  local speed = 200
  self.dx = self.dx + math.cos(self.angle) * speed * dt
  self.dy = self.dy + math.sin(self.angle) * speed * dt
  self.accelerating = true  -- TODO: unneeded?
  self.sfx_rocket:on()
end

function pship:fire_bullet()
  if self.bullet_cooldown_timer <= 0 then
    self.bullet_cooldown_timer = 350
    self:play_sfx_bullet_fire()
    return {
      x = self.x + math.cos(self.angle) * 10,
      y = self.y + math.sin(self.angle) * 10,
      dx = self.dx,
      dy = self.dy,
      angle = self.angle
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
  if not love.joystick.isDown(1, 5) then self.sfx_rocket:off() end
  if self.bullet_cooldown_timer > 0 then self.bullet_cooldown_timer = self.bullet_cooldown_timer - dt * 1000 end
end

function pship:paint(x, y)
  pship2sprite.paint(self, x, y)
  if love.joystick.isDown(1, 5) then self.exhaust:paint(x, y) end
end

function pship:rotate(dt)
  local speed = 250
  self.rotation = (self.rotation + dt * speed) % 360
  self.heading_n = math.floor(self.rotation / 22.5)
  self.quad = self.quads[self.heading_n]
  self.angle = math.rad(self.heading_n * 22.5)
  self.exhaust.quad = self.exhaust.quads[self.heading_n]
  self.exhaust.ox = exhaust_offset[self.heading_n].x
  self.exhaust.oy = exhaust_offset[self.heading_n].y
end

function pship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return pship
