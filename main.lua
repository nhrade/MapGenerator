
--[[
	Returns 0 if on line, and sign based on side
]]
function pointOnSide(a, b, c)
	return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
end


function bounding(x)
	return 1 / (1 + math.exp(-x))
end

function createMap(iterations, dh, seed)
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
				local side = pointOnSide(p1, p2, currPoint)
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

function distance(x1, y1, x2, y2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end


function drawMap(map, tileSize)
	for x = 0, #map do
		for y = 0, #map[x] do
			local height = bounding(map[x][y])
			if height < 0.5 then
				love.graphics.setColor(18, 150, 255, 255)
			elseif height >= 0.5 and height < 0.9 then
				love.graphics.setColor(53, 173, 0, 1 / height * 100)
			elseif height >= 0.9 and height < 0.99 then
				love.graphics.setColor(158, 111, 0, 1 / height * 100)
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


function love.load()
	tileSize = 2
	map = createMap(3000, 0.05, 12920392)
end



function love.draw()
	drawMap(map, tileSize)
end