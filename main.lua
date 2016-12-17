HC = require 'HC'
require 'box'

function love.load()
	box1 = Box:new(100, 100, 50, 50)
end

function love.update(dt)
	box1:update(dt)
end

function love.draw()
	box1:draw(dt)
end