local spacetexture = {
  texture = love.graphics.newImage('share/space.png'),
  tile_width = 256,
  tile_height = 256,
  origin_x = 0,
  origin_y = 0,
}

function spacetexture.canvas(width, height)
  local canvas = love.graphics.newCanvas(width + 512, height + 512)
  love.graphics.setCanvas(canvas)
  for x = -256, width + 256, 256 do
    for y = -256, height + 256, 256 do
      love.graphics.draw(spacetexture.texture, x, y)
    end
  end
end

function spacetexture:new{o}
  o = o or self
  setmetatable(o, self)
  self.__index = self
  return o
end

return spacetexture
