local cos = { [0] = math.cos(math.rad(0)), math.cos(math.rad(22.5)), math.cos(math.rad(45)), math.cos(math.rad(67.5)), math.cos(math.rad(90)), math.cos(math.rad(112.5)), math.cos(math.rad(135)), math.cos(math.rad(157.5)), math.cos(math.rad(180)), math.cos(math.rad(202.5)), math.cos(math.rad(225)), math.cos(math.rad(247.5)), math.cos(math.rad(270)), math.cos(math.rad(292.5)), math.cos(math.rad(315)), math.cos(math.rad(337.5)) }

local sin = { [0] = math.sin(math.rad(0)), math.sin(math.rad(22.5)), math.sin(math.rad(45)), math.sin(math.rad(67.5)), math.sin(math.rad(90)), math.sin(math.rad(112.5)), math.sin(math.rad(135)), math.sin(math.rad(157.5)), math.sin(math.rad(180)), math.sin(math.rad(202.5)), math.sin(math.rad(225)), math.sin(math.rad(247.5)), math.sin(math.rad(270)), math.sin(math.rad(292.5)), math.sin(math.rad(315)), math.sin(math.rad(337.5)) }

local vector_sixteen = {
  sector_length = 22.5,
  number_of_sectors = 16,
  subsector = 11.25,
  sector = 12,
}

function vector_sixteen:cardinal(angle)
  local steps = 16
  return math.floor(steps * angle / (2 * math.pi) + steps + 0.5) % steps
end

function vector_sixteen:rotate(length)
  self.subsector = self.subsector + length
  if self.subsector > self.sector_length then
    self.sector = (self.sector + 1) % self.number_of_sectors
  elseif self.subsector < 0 then
    self.sector = (self.sector - 1) % self.number_of_sectors
  end
  self.subsector = self.subsector % self.sector_length
end

function vector_sixteen:scale(s)
  return cos[self.sector] * s, sin[self.sector] * s
end

function vector_sixteen:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return vector_sixteen
