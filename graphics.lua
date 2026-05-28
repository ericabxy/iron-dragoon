local background = love.graphics.newImage('share/space.png')
local bitmapfont = require('src.bitmap_font_futuristic')
local standard_color_names = require('src.standard_color_names')

local graphics = {
  object_to_follow_with_camera = false,
  origin_x = 0,
  origin_y = 0,
  scroll_x = 0,
  scroll_y = 0,
  space_width = 256,
  space_height = 256,
  background_layer = love.graphics.newCanvas(256, 256),
  sprites_layer_0 = {},
  sprites_layer_1 = {},
  sprites_layer_2 = {},
  sprites_layer_3 = {},
  player0 = { hit_points = 64 },
  stage_name = {
    'GAME 01',
    'PHYSICS',
    'DEMO',
  },
}

graphics.radar = {
  blips_red_t = {},
  blips_green_t = {},
  blips_yellow_t = {},
}

love.graphics.setCanvas(graphics.background_layer)
love.graphics.draw(background, 0, 0)

function graphics.draw_sprite_layer(o, x, y)
  for i = #o, 1, -1 do
    o[i]:paint(x, y)
    if o[i].remove_me_from_all_lists then table.remove(o, i) end
  end
end

function graphics.flush_sprites()
  graphics.sprites_layer_0 = {}
  graphics.sprites_layer_1 = {}
  graphics.sprites_layer_2 = {}
  graphics.sprites_layer_3 = {}
  graphics.radar.blips_red_t = {}
  graphics.radar.blips_green_t = {}
  graphics.radar.blips_yellow_t = {}
end

function love.draw()
  love.graphics.setCanvas()
  if graphics.object_to_follow_with_camera then
    graphics.scroll_x = -graphics.object_to_follow_with_camera.x + 128
    graphics.scroll_y = -graphics.object_to_follow_with_camera.y + 128
  end
  love.graphics.draw(graphics.background_layer, graphics.origin_x + graphics.scroll_x, graphics.origin_y + graphics.scroll_y)
  for x = -graphics.space_width, graphics.space_width, graphics.space_width do
    for y = -graphics.space_height, graphics.space_height, graphics.space_height do
      graphics.draw_sprite_layer(graphics.sprites_layer_0, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_1, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_2, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_3, x + graphics.scroll_x, y + graphics.scroll_y)
    end
  end
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', 256, 0, 64, 240)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', 256, 0, graphics.player0.hit_points, 6)
  love.graphics.setColor(0, 85, 0)
  love.graphics.rectangle('fill', 256, 176, 64, 64)
  love.graphics.setColor(85, 170, 85)
  for i = #graphics.radar.blips_green_t, 1, -1 do
    local o = graphics.radar.blips_green_t[i]
    love.graphics.rectangle('fill', 256 + (o.x / (graphics.space_width / 64)), 176 + (o.y / (graphics.space_height / 64)), 2, 2)
    if o.remove_me_from_all_lists then table.remove(graphics.radar.blips_green_t, i) end
  end
  love.graphics.setColor(170, 170, 85)
  for i = #graphics.radar.blips_yellow_t, 1, -1 do
    local o = graphics.radar.blips_yellow_t[i]
    love.graphics.rectangle('fill', 256 + (o.x / (graphics.space_width / 64)), 176 + (o.y / (graphics.space_height / 64)), 2, 2)
    if o.remove_me_from_all_lists then table.remove(graphics.radar.blips_yellow_t, i) end
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('line', 256, 0, 63, 5)
end

return graphics
