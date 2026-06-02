local graphics = require('graphics')
local bullet = require('src.bullet')
local debris = require('src.debris')
local explode1 = require('src.explode1')
local explode2 = require('src.explode2')

local explosion_hard = love.audio.newSource('share/sfx_exp_shortest_hard1.wav', 'static')

-- functions to handle game logic
local programs = {
  debris_t = {},
  enemies_t = {},
}

local bullets_t = {}
local explodes_t = {}
local pships_t = {}
local tractors_t = {}
local all_objects_table = {}

function programs.advance_physics(dt)
  for i = #bullets_t, 1, -1 do
    this = bullets_t[i]
    this:move(dt)
    if this.remove_me_from_all_lists then table.remove(bullets_t, i) end
  end
  for i = #programs.debris_t, 1, -1 do
    this_debris = programs.debris_t[i]
    this_debris:move(dt)
    for j = #bullets_t, 1, -1 do
      this_bullet = bullets_t[j]
      if this_debris:is_touching_bullet(this_bullet) then
        local new_objects = this_debris:collide_with_bullet(this_bullet)
        programs.add_new_objects_to_lists(new_objects)
      end
      if this_bullet.remove_me_from_all_lists then table.remove(bullets_t, j) end
    end
    if this_debris.remove_me_from_all_lists then table.remove(programs.debris_t, i) end
  end
  for i = #programs.enemies_t, 1, -1 do
    this_enemy = programs.enemies_t[i]
    local any_spawns = this_enemy:move(dt)
    if type(any_spawns) == 'table' then
      print('spawn bullet')
      programs.add_new_objects_to_lists(any_spawns)
    end
    if this_enemy.remove_me_from_all_lists then table.remove(programs.enemies_t, i) end
  end
  for i = #explodes_t, 1, -1 do
    this = explodes_t[i]
    this:move(dt)
    if this.remove_me_from_all_lists then table.remove(explodes_t, i) end
  end
  for i = #pships_t, 1, -1 do
    ship = pships_t[i]
    ship:move(dt)
    for j = #programs.debris_t, 1, -1 do
      that = programs.debris_t[j]
      if ship.invincibility_timer <= 0 and ship:is_touching(that) then
        ship.hit_points = ship.hit_points - ((that.size + 1) * 8)
        ship.invincibility_timer = 1000
        programs.destroy_debris(that)
      end
      if that.remove_me_from_all_lists then table.remove(programs.debris_t, j) end
    end
    if ship.remove_me_from_all_lists then table.remove(pships_t, i) end
  end
end

function programs.destroy_debris(o)
  programs.spawn_explosion{ x = o.x, y = o.y }
  love.audio.stop(explosion_hard)
  love.audio.play(explosion_hard)
  if o.size == 2 then
    programs.spawn_debris{ x = o.x, y = o.y, size = 1 }
    programs.spawn_debris{ x = o.x, y = o.y, size = 1 }
  elseif o.size == 1 then
    programs.spawn_debris{ x = o.x, y = o.y, size = 0 }
    programs.spawn_debris{ x = o.x, y = o.y, size = 0 }
  end
  o.remove_me_from_all_lists = true
end

function programs.flush_objects()
  bullets_t = {}
  programs.debris_t = {}
  explodes_t = {}
  pships_t = {}
  tractors_t = {}
end

function programs.spawn_bullet(o)
  o = o or {}
  o.space_width = graphics.space_width
  o.space_height = graphics.space_height
  local object = bullet:new(o)
  object.texture = object.textures[0]
  table.insert(bullets_t, object)
  table.insert(graphics.sprites_layer_3, object)
  return object
end

function programs.spawn_debris(o)
  o = o or {}
  o.space_width = graphics.space_width
  o.space_height = graphics.space_height
  local object = debris:new(o)
  table.insert(programs.debris_t, object)
  table.insert(graphics.sprites_layer_2, object)
  return object
end

function programs.spawn_explosion(o)
  local object = explode2:new(o)
  table.insert(explodes_t, object)
  table.insert(graphics.sprites_layer_3, object)
end

function programs.spawn_pship(o)
  local object = pship:new(o)
  table.insert(pships_t, object)
  table.insert(graphics.sprites_layer_1, object)
  table.insert(graphics.radar.blips_green_t, object)
  return object
end

function programs.spawn_ship_5(o)
  o = ship5:new(o)
  table.insert(programs.enemies_t, o)
  table.insert(graphics.sprites_layer_3, o)
end

function programs.spawn_sun(o)
  local object = sun:new(o)
  object.quad = object.quads[1]
  table.insert(tractors_t, object)
  table.insert(graphics.sprites_layer_0, object)
  table.insert(graphics.radar.blips_yellow_t, object)
end

function programs.start_game()
  graphics.flush_sprites()
  programs.flush_objects()
  players_t = {}
  bullets_t = {}
  debris_t = {}
  player0 = programs.spawn_pship{ x = 128, y = 120 }
  graphics.player0 = player0
end

function programs.add_object_to_all_tables(o)
  if o.iron_dragoon_type == 'bullet' then
    table.insert(bullets_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_3, o)
  elseif o.iron_dragoon_type == 'debris' then
    table.insert(programs.debris_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_2, o)
  elseif o.iron_dragoon_type == 'explosion' then
    table.insert(explodes_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_3, o)          
  elseif o.iron_dragoon_type == 'pickup' then
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_2, o)          
  elseif o.iron_dragoon_type == 'playership' then
    table.insert(pships_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_1, o)          
  end
end

function programs.update(dt)
  local list_of_newly_spawned_objects = {}
  for a = #all_objects_table, 1, -1 do
    local obj_a = all_objects_table[a]
    obj_a:move(dt)
    if obj_a.iron_dragoon_type == 'debris' then
      for b = #bullets_t, 1, -1 do
        local obj_b = bullets_t[b]
        if obj_a:is_touching_bullet(obj_b) then
          local new_debris_t = obj_a:destroy()
          if type(new_debris_t) == 'table' then
            for _, new_debris in ipairs(new_debris_t) do
              table.insert(list_of_newly_spawned_objects, new_debris)
            end
          end
          table.insert(list_of_newly_spawned_objects, explode2:new{ x = obj_a.x, y = obj_a.y })
          obj_b.remove_me_from_all_lists = true
        end
        if obj_b.remove_me_from_all_lists then table.remove(bullets_t, b) end
      end
    end
    if obj_a.remove_me_from_all_lists then table.remove(all_objects_table, a) end
  end
  for _, new_object in ipairs(list_of_newly_spawned_objects) do
    programs.add_object_to_all_tables(new_object)
  end
end

return programs
