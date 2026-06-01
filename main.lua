local constants = require('src.constants')
local graphics = require('graphics')
local programs = require('programs')
local game01 = require('game01')
local game02 = require('game02')

local bullet_laser = love.audio.newSource('share/sfx_wpn_laser1.wav', 'static')

local globalcooldown = 0
local players_t = {}
local bullets_t = {}
local debris_t = {}
local player0 = false
local current_game = game01

function love.load()
  player0 = current_game.start()
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
  if love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_B) then
    local bullet = player0:fire_bullet()
    if bullet then
      table.insert(bullets_t, programs.spawn_bullet(bullet))
    end
  end
  programs.advance_physics(dt)
  current_game.run(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'return' then
    love.load()
  elseif key == '1' then
    current_game = game01
    player0 = current_game.start()
  elseif key == '2' then
    current_game = game02
    player0 = current_game.start()
  end
end
