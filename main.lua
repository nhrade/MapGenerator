--[[
main.lua
]]



local mapgen = require "mapgen"
local renderer = require "renderer"


function love.load()
	tileSize = 1
	map = mapgen:createMap(3000, 0.03, love.timer.getTime())
end


function drawElevation(map)

end


function love.draw()
	renderer:drawMap(map, tileSize, 0.5)
end