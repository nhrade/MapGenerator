
local renderer = {}


--[[
Bounding function to squish height between 0 and 1
]]
function renderer:bounding(x)
	return 1 / (1 + math.exp(-x))
end


--[[
Draws map based on heightmap
]]
function renderer:drawMap(map, tileSize, seaLevel)
	for x = 0, #map do
		for y = 0, #map[x] do
			local height = renderer:bounding(map[x][y])
			if height <seaLevel then
				love.graphics.setColor(18, 150, 255, 255)
			elseif height >= seaLevel and height < 0.9 then
				love.graphics.setColor(53, 173, 0, 1 / height * 100)
			elseif height >= 0.9 and height < 0.995 then
				love.graphics.setColor(158, 111, 0, 1 / height * 100)
			elseif height > 0.99 then
				love.graphics.setColor(255, 255, 255, 255)
			end
			local vertices = {
			x*tileSize, y*tileSize,
			 (x+1)*tileSize, y*tileSize,
			  (x+1)*tileSize, (y+1)*tileSize,
			  x*tileSize, (y+1)*tileSize}
			  love.graphics.polygon("fill", vertices)
		end
	end
end

return renderer