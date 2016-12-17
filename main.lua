HC = require 'HC'
require 'Object'
require 'EventHandler'
require 'CollisionEvent'
require 'Box'

function love.load()
	handler = EventHandler:new() -- object that tracks all events that occur in the game, e.g. collisions
	step = 0 -- global variable for tracking the current game step
	actors = {} -- global table of all active objects
	
	collidable = {"Box"}
	drawable = {"Box"}
	
	box1 = Box:new(100, 100, 150, 50)
	box2 = Box:new(100, 300, 50, 250)
	table.insert(actors, box1)
	table.insert(actors, box2)
	table.insert(actors, handler)
	
	lmb = false
	lmbOld = false
end

function love.update(dt)
	step = step + 1
	
	lmbOld = lmb
	lmb = love.mouse.isDown(1)
	
	if lmb and not lmbOld then
		table.insert(actors, Box:new(love.mouse.getX(), love.mouse.getY(), 50, 50))
	end
	
	for _, actor in ipairs(actors) do -- create collision events for each collision
		if actor:isOfSet(collidable) then
			for shape, delta in pairs(HC.collisions(actor.collider)) do
				local e = CollisionEvent:new(actor, shape.parent, delta)
				handler:add(e)
			end
		end
	end
	
	for _, actor in ipairs(actors) do -- update each actor
		actor:update(dt)
	end
	
	for i, actor in ipairs(actors) do
		if actor:isKill() then
			table.remove(actors, i)
		end
	end
	
end

function love.keypressed(key)
	if key == 'rctrl' then
		debug.debug()
	end
	
	if key == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	for _, actor in ipairs(actors) do
		if actor:isOfSet(drawable) then
			actor:draw()
		end
	end
	
	--[[love.graphics.setColor(255, 0, 0)
	for _, actor in ipairs(actors) do
		actor.collider:draw("fill")
	end]]
end
