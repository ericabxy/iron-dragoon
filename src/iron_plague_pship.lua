local sprite = require('src.sprite')

local CARDINALS = 16
local STEP_IN_DEGREES = 22.5
local BULLET_SFX_FILENAME = 'share/sfx_weapon_singleshot21.wav'

local iron_plague_pship = sprite:new{
  sfx_rocket_loop = love.audio.newSource('share/sfx_vehicle_plainloop.wav', 'static'),
  sfx_bullet_fire = love.audio.newSource(BULLET_SFX_FILENAME, 'static'),
  sfx_bullet_fire2 = love.audio.newSource(BULLET_SFX_FILENAME, 'static'),
  sfx_bullet_fire3 = love.audio.newSource(BULLET_SFX_FILENAME, 'static'),
  texture = love.graphics.newImage('share/iron_plague_pship.png'),
  textures = {
    love.graphics.newImage('share/iron_plague_exhaust2_a.png'),
    love.graphics.newImage('share/iron_plague_exhaust2_b.png'),
    love.graphics.newImage('share/iron_plague_exhaust2_c.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(96, 0, 24, 24, 193, 49),
    [1] = love.graphics.newQuad(120, 0, 24, 24, 193, 49),
    [2] = love.graphics.newQuad(144, 0, 24, 24, 193, 49),
    [3] = love.graphics.newQuad(168, 0, 24, 24, 193, 49),
    [4] = love.graphics.newQuad(0, 24, 24, 24, 193, 49),
    [5] = love.graphics.newQuad(24, 24, 24, 24, 193, 49),
    [6] = love.graphics.newQuad(48, 24, 24, 24, 193, 49),
    [7] = love.graphics.newQuad(72, 24, 24, 24, 193, 49),
    [8] = love.graphics.newQuad(96, 24, 24, 24, 193, 49),
    [9] = love.graphics.newQuad(120, 24, 24, 24, 193, 49),
    [10] = love.graphics.newQuad(144, 24, 24, 24, 193, 49),
    [11] = love.graphics.newQuad(168, 24, 24, 24, 193, 49),
    [12] = love.graphics.newQuad(0, 0, 24, 24, 193, 49),
    [13] = love.graphics.newQuad(24, 0, 24, 24, 193, 49),
    [14] = love.graphics.newQuad(48, 0, 24, 24, 193, 49),
    [15] = love.graphics.newQuad(72, 0, 24, 24, 193, 49),
  },
  angle_in_degrees = 270,  -- Default to pointing "up".
  fine_angle_in_degrees = 11.25,  -- Track degrees since radians are floating-point imprecise.
  cardinal = 12,  -- "Up" is the twelfth cardinal.
  angle = 1.5 * math.pi,  -- Default to pointing "up".
  ox = -12,
  oy = -12,
}

iron_plague_pship.sfx_rocket_loop:setLooping(true)

function iron_plague_pship:init()
  self.quad = self.quads[12]
  return self
end

function iron_plague_pship:is_touching(o)
  -- Placeholder. We are working on pship2 collision first.
end

-- Note: Draw exhaust using superclass quads since "pship2" replaces them.
function iron_plague_pship:paint(x, y)
  sprite.paint(self, x, y)
  if self.sfx_rocket_loop:isPlaying() then
    local animation_frame = math.floor(love.timer.getTime() * 15) % 3
    local exhaust_radius = 10
    x = x - math.cos(self.angle) * exhaust_radius
    y = y - math.sin(self.angle) * exhaust_radius
    love.graphics.draw(self.textures[animation_frame + 1], iron_plague_pship.quads[self.cardinal], x + self.ox + self.x, y + self.oy + self.y)
  end
end

-- Since sprite has sixteen rotated tiles, "angle" is limited to sixteen
-- cardinal directions and "fine angle" is used to keep track of smaller
-- corrections. The child object then only has to worry about its "angle"
-- without complicated math.
function iron_plague_pship:rotate(a)
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

function iron_plague_pship:play_sfx_bullet_fire()
  if not self.sfx_bullet_fire:isPlaying() then love.audio.play(self.sfx_bullet_fire)
  elseif not self.sfx_bullet_fire2:isPlaying() then love.audio.play(self.sfx_bullet_fire2)
  elseif not self.sfx_bullet_fire3:isPlaying() then love.audio.play(self.sfx_bullet_fire3) end
end

function iron_plague_pship:sfx_rocket_loop_off()
  love.audio.stop(self.sfx_rocket_loop)
end

function iron_plague_pship:sfx_rocket_loop_on()
  if not self.sfx_rocket_loop:isPlaying() then love.audio.play(self.sfx_rocket_loop) end
end

function iron_plague_pship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_pship
