--[[
main.lua
]]


local mapgen = require "mapgen"

function love.load()
	tileSize = 2
	map = mapgen.createMap(3000, 0.05, love.timer.getTime())
end



function love.draw()
	mapgen.drawMap(map, tileSize)
end