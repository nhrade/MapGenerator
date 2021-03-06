--[[
mapgen.lua
]]

local mapgen = {}
local biomeMap = {}

--[[
	Returns 0 if on line, and sign based on side
]]
function mapgen:pointOnSide(a, b, c)
	return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
end



--[[
Generate map, more iterations means less tesselation
dh is change in height to be applied at each iteration
]]
function mapgen:createMap(iterations, dh, seed)
	love.math.setRandomSeed(seed)
	map = {}
	width, height = love.window.getDimensions()

	for x = 0, width do
		map[x] = {}
		for y = 0, height do
			map[x][y] = 0.4
		end
	end

	for i = 0, iterations do
		local p1 = {x = love.math.random(width), y = love.math.random(height)}
		local p2 = {x = love.math.random(width), y = love.math.random(height)}
		for xi = 0, width do
			for yi = 0, height do
				local currPoint = {x = xi, y = yi}
				local side = mapgen:pointOnSide(p1, p2, currPoint)
				local normalized = side
				if normalized == 0 then
					normalized = -1
				else
					normalized = side / math.abs(side)
				end
				map[xi][yi] = map[xi][yi] + normalized * dh
			end
		end
	end
	return map
end

function mapgen:distance(x1, y1, x2, y2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end




return mapgen