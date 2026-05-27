local graphics = require('graphics')
local programs = require('programs')
local game01 = require('game01')
local game02 = require('game02')

local bullet_laser = love.audio.newSource('share/sfx_wpn_laser1.wav', 'static')

require('const')

local globalcooldown = 0
local players_t = {}
local bullets_t = {}
local debris_t = {}
local player0 = false 

function love.load()
  player0 = game01.start()
end

function love.update(dt)
  if love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    player0:rotate(-dt)
  elseif love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    player0:rotate(dt)
  end
  if love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_UP) then
    player0:accelerate(dt)
  end
  if love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_B) and globalcooldown < 0 then
    love.audio.play(bullet_laser)
    table.insert(bullets_t, programs.spawn_bullet{
      x = player0.x + math.cos(player0.angle) * 10,
      y = player0.y + math.sin(player0.angle) * 10,
      dx = player0.dx,
      dy = player0.dy,
      angle = player0.angle
    }:init( ))
    globalcooldown = 500
  end
  globalcooldown = globalcooldown - dt * 1000
  programs.advance_physics(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'return' then
    love.load()
  elseif key == '1' then
    player0 = game01.start()
  elseif key == '2' then
    player0 = game02.start()
  end
end
