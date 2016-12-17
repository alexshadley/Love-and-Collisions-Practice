Box = {}
setmetatable(Box, {__index = Object})


function Box:new(xIn, yIn, widthIn, heightIn)
	local o = {} -- creates an empty table to act as our object
	setmetatable(o, {__index = self}) -- defines Box as the metatable of Box.  Whenever we call a method of o and o can't find it, it'll check Box, which is how we give every Box object the same methods.  We can also chain metatables, allowing us to implement inheritance
	
	o.position = {x = xIn, y = yIn} -- define the position of our Box (from the center)
	o.dimensions = {x = widthIn, y = heightIn}
	o.velocity = {x = 100, y = 0} -- define the velocity of our Box
	
	o.tag = "Box" -- easy way to determine what type of object this is
	
	o.color = {r = 255, g = 255, b = 255}
	
	o.collider = HC.rectangle(o.position.x, o.position.y, o.dimensions.x, o.dimensions.y)
	o.collider.parent = o -- this line is a little funky.  The collider object needs a reference back to its parent object so that we can interact with it directly
	
	o.dead = false
	
	return o
end

function Box:update(dt)
	self:checkEvents()

	if not self.dead then
		self:move(dt)
		self.collider:moveTo(self.position.x, self.position.y)
	end
end

function Box:checkEvents()
	for _, event in ipairs(handler.events) do
		if event.tag == "Collision_Event" then
			
			if event.object1 == self then
				self:collide(event.object2, event.delta)
			elseif event.object2 == self then
				self:collide(event.object1, event.delta)
			end
		end
	end
end

function Box:move(dt)
	if self.position.y > love.graphics.getHeight() - (self.dimensions.y / 2) then -- bounce off bottom of screen
		self.velocity.y = math.abs(self.velocity.y) * -.95 -- absolute value to make sure the box is allways directed upwards
	end
	
	if self.position.x < self.dimensions.x / 2 or self.position.x > love.graphics.getWidth() - self.dimensions.x / 2 then -- bounce off left and right screen edges
		self.velocity.x = self.velocity.x * -1
	end
	
	self.velocity.y = self.velocity.y + (100 * dt) --increases the velocity at a rate of 100 pixels/second^2 because gravity
	
	self.position.x = self.position.x + (self.velocity.x * dt)
	self.position.y = self.position.y + (self.velocity.y * dt)
end

function Box:collide(other, delta)
	self:kill()
end

function Box:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b)
	love.graphics.rectangle("fill", self.position.x - self.dimensions.x / 2, self.position.y - self.dimensions.y / 2, self.dimensions.x, self.dimensions.y)
end

function Box:kill()
	self.dead = true
	HC.remove(self.collider)
end

function Box:isKill()
	return self.dead
end