CollisionEvent = {}
setmetatable(CollisionEvent, {__index = Object}) -- Sets CollisionEvent to inherit from Object.  In case you're wondering, no, I don't know why this syntax looks the way it does.  It just works

function CollisionEvent:new(object1, object2, delta)
	local o = {}
	setmetatable(o, {__index = self})
	
	o.object1, o.object2 = object1, object2
	o.delta = delta
	
	o.tag = "Collision_Event"
	o.birthday = step
	o.lifespan = 1
	o.isKill = 0
	
	return o
end

function CollisionEvent:update()
	if self.lifespan >= step - self.birthday then -- if you're too old then die
		self.isKill = true
	end
end

function CollisionEvent:output()
	print(self.tag .. " step:" .. self.birthday .. " positions:(" .. self.object1.position.x .. "," .. self.object1.position.y .. ")(" .. self.object2.position.x .. "," .. self.object2.position.y .. ")")
end