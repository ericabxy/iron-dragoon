local constants = require('src.constants')
local bullet = require('src.bullet')
local debris = require('src.debris')
local pickup_metal = require('src.pickup_metal')
local player_ship = require('src.player_ship')
local graphics = require('graphics')
local programs = require('programs')

local players_t = {}
local player0 = player_ship:new{ x = 128, y = 128, controller_number = 1 }

function love.load()
  graphics.sprites_layer_0 = {}
  graphics.sprites_layer_1 = {}
  graphics.sprites_layer_2 = {}
  graphics.sprites_layer_3 = {}
  bullets_t = {}
  debris_t = {}
  players_t = {}
  for _ = 1, 3 do
    programs.add_object_to_all_tables(
      debris:new{ x = love.math.random(200, 300), y = love.math.random(200, 300) }
    )
  end
  programs.add_object_to_all_tables(pickup_metal:new{ x = 20, y = 20 })
  table.insert(players_t, player0)
  programs.add_object_to_all_tables(player0)
end

function love.update(dt)
  player0:control(dt)
  if player0.bullet_cooldown_timer <= 0 and love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_B) then
    local bullet_radius = 12
    local x = player0.x + math.cos(player0.angle) * bullet_radius
    local y = player0.y + math.sin(player0.angle) * bullet_radius
    programs.add_object_to_all_tables(
      bullet:new{ x = x, y = y, angle = player0.angle }
    )
    player0.bullet_cooldown_timer = 500
  end
  player0:move(dt)
  programs.update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'return' then
    love.load()
  elseif key == '1' then
  elseif key == '2' then
  end
end
