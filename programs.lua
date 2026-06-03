local graphics = require('graphics')
local bullet = require('src.bullet')
local coin = require('src.coin')
local debris = require('src.debris')
local explode1 = require('src.explode1')
local explode2 = require('src.explode2')

-- functions to handle game logic
local programs = {
  coin_counter = 0,
}

local bullets_t = {}
local debris_t = {}
local enemies_t = {}
local explodes_t = {}
local pickups_t = {}
local players_t = {}

function programs.flush_objects()
  bullets_t = {}
  debris_t = {}
  enemies_t = {}
  explodes_t = {}
  pickups_t = {}
  players_t = {}
end

-- Restore all data to initial values.
function programs.reset()
  programs.flush_objects()
  graphics.flush_sprites()
end

function programs.start(stage_number)
  local number_of_debris = math.min(3 + math.floor(stage_number / 2), 10)
  for _ = 1, number_of_debris do
    programs.add_object_to_all_tables(
      debris:new{ x = love.math.random(0, 256), y = love.math.random(246, 250) }
    )
  end
  graphics.current_stage_number = stage_number
end

function programs.add_object_to_all_tables(o)
  if o.iron_dragoon_type == 'bullet' then
    table.insert(bullets_t, o)
    table.insert(graphics.sprites_layer_3, o)
  elseif o.iron_dragoon_type == 'debris' then
    table.insert(debris_t, o)
    table.insert(graphics.sprites_layer_2, o)
  elseif o.iron_dragoon_type == 'explosion' then
    table.insert(explodes_t, o)
    table.insert(graphics.sprites_layer_3, o)          
  elseif o.iron_dragoon_type == 'pickup' then
    table.insert(pickups_t, o)
    table.insert(graphics.sprites_layer_2, o)          
  elseif o.iron_dragoon_type == 'playership' then
    table.insert(players_t, o)
    table.insert(graphics.sprites_layer_1, o)          
  end
end

function check_for_bullets_colliding_with_debris(dt)
  local list_of_spawned_objects = {}
  for i = #bullets_t, 1, -1 do
    local thisbullet = #bullets_t[i]
    thisbullet:move(dt)
    for j = #debris_t, 1, -1 do
      local thisdebris = #debris_t[j]
      if thisbullet:is_touching(thisdebris) then
        thisdebris:destroy()
        thisbullet.remove_me_from_all_lists = true
      end
    end
    if thisbullet.remove_me_from_all_lists then table.remove(bullets_t, i) end
  end
  return list_of_spawned_objects
end

function check_for_players_colliding_with_debris(dt)
  local list_of_spawned_objects = {}
  for i = #players_t, 1, -1 do
    local thisplayer = #players_t[i]
    --thisplayer:control(dt)
    thisplayer:move(dt)
    for j = #debris_t, 1, -1 do
      local thisdebris = #debris_t[j]
      if thisplayer:is_touching(thisdebris) then
        thisdebris:destroy()
      end
    end
  end
  return list_of_spawned_objects
end

function check_all_bullets(dt)
  local list_of_newly_spawned_objects = {}
  for b = #bullets_t, 1, -1 do
    local thisbullet = bullets_t[b]
    thisbullet:move(dt)
    for d = #debris_t, 1, -1 do
      local thisdebris = debris_t[d]
      if thisbullet:is_touching(thisdebris) then
        graphics.current_score = graphics.current_score + thisdebris.value
        programs.coin_counter = programs.coin_counter + thisdebris.value
        local spawns = thisdebris:destroy()
        thisbullet.remove_me_from_all_lists = true
        thisdebris.remove_me_from_all_lists = true
        for _, spawn in ipairs(spawns) do
          table.insert(list_of_newly_spawned_objects, spawn)
        end
      end
      if thisdebris.remove_me_from_all_lists then table.remove(debris_t, d) end
    end
    if thisbullet.remove_me_from_all_lists then table.remove(bullets_t, b) end
  end
  for _, new_object in ipairs(list_of_newly_spawned_objects) do
    programs.add_object_to_all_tables(new_object)
  end
end

function check_all_debris(dt)
  local list_of_newly_spawned_objects = {}
  for d = #debris_t, 1, -1 do
    local thisdebris = debris_t[d]
    thisdebris:move(dt)
    for p = #players_t, 1, -1 do
      local thisplayer = players_t[p]
      if not thisplayer.invulnerable and thisplayer:is_touching(thisdebris) then
        local spawns = thisdebris:destroy()
        thisdebris.remove_me_from_all_lists = true
        thisplayer.invulnerable = 500
        for _, spawn in ipairs(spawns) do
          table.insert(list_of_newly_spawned_objects, spawn)
        end
      end
    end
    if thisdebris.remove_me_from_all_lists then table.remove(debris_t, d) end
  end
  for _, new_object in ipairs(list_of_newly_spawned_objects) do
    programs.add_object_to_all_tables(new_object)
  end
end

function check_all_pickups(dt)
  for u = #pickups_t, 1, -1 do
    local thispickup = pickups_t[u]
    thispickup:move(dt)
    for p = #players_t, 1, -1 do
      local thisplayer = players_t[p]
      if thisplayer:is_touching(thispickup) then
        graphics.current_score = graphics.current_score + thispickup.value
        thisplayer.coinbank:collect(thispickup)
        thispickup.remove_me_from_all_lists = true
      end
    end
    if thispickup.remove_me_from_all_lists then table.remove(pickups_t, u) end
  end
end

function programs.update(dt)
  check_all_bullets(dt)
  --for _, thisbullet in ipairs(bullets_t) do thisbullet:move(dt) end
  check_all_debris(dt)
  --for _, thisdebris in ipairs(debris_t) do thisdebris:move(dt) end
  for _, thisexplode in ipairs(explodes_t) do thisexplode:move(dt) end
  check_all_pickups(dt)
  --for _, thispickup in ipairs(pickups_t) do thispickup:move(dt) end
  for _, thisplayer in ipairs(players_t) do thisplayer:move(dt) end
  -- Check to spawn coins.
  if programs.coin_counter >= 525 then
    programs.coin_counter = programs.coin_counter - 525
    programs.add_object_to_all_tables(
      coin:new{ x = love.math.random(0, 256), y = love.math.random(246, 250) }
    )
  end
  -- Check to advance stage.
  if #debris_t == 0 then
    print('next stage')
    programs.start(graphics.current_stage_number + 1)
  end
end

return programs
