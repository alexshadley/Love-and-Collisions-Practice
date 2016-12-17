Box = {}

function Box:new(xIn, yIn, widthIn, heightIn)
	local o = {} -- creates an empty table to act as our object
	setmetatable(o, {__index = self}) -- defines Box as the metatable of Box.  Whenever we call a method of o and o can't find it, it'll check Box, which is how we give every Box object the same methods.  We can also chain metatables, allowing us to implement inheritance
	
	o.position = {x = xIn, y = yIn} -- define the position of our Box (from the center)
	o.dimensions = {x = widthIn, y = heightIn}
	o.velocity = {x = 100, y = 0} -- define the velocity of our Box
	
	o.tag = "Box" -- easy way to determine what type of object this is
	
	o.collider = HC.rectangle(o.position.x, o.position.y, o.dimensions.x, o.dimensions.y)
	o.collider.parent = o -- this line is a little funky.  The collider object needs a reference back to its parent object so that we can interact with it directly
	
	return o
end

function Box:update(dt) 
	self:move(dt)
	self.collider:moveTo(self.position.x, self.position.y)
end

function Box:move(dt)
	if self.position.y > love.graphics.getHeight() - (self.dimensions.y / 2) then -- bounce off bottom of screen
		self.velocity.y = self.velocity.y * -.95
	end
	
	if self.position.x < self.dimensions.x / 2 or self.position.x > love.graphics.getWidth() - self.dimensions.x / 2 then -- bounce off left and right screen edges
		self.velocity.x = self.velocity.x * -1
	end
	
	self.velocity.y = self.velocity.y + (100 * dt) --increases the velocity at a rate of 100 pixels/second^2 because gravity
	
	self.position.x = self.position.x + (self.velocity.x * dt)
	self.position.y = self.position.y + (self.velocity.y * dt)
end

function Box:collide(other)

end

function Box:draw()
	love.graphics.rectangle("fill", self.position.x - self.dimensions.x / 2, self.position.y - self.dimensions.y / 2, self.dimensions.x, self.dimensions.y)
end