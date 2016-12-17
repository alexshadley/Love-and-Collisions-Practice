EventHandler = {}
setmetatable(EventHandler, {__index = Object})

function EventHandler:new()
	local o = {}
	setmetatable(o, {__index = self})
	
	o.events = {} -- container for all of the game's events
	
	o.tag = "Event_Handler"
	
	return o
end

function EventHandler:add(event)
	local duplicate = false
	for _, e in ipairs(self.events) do
		if ((event.object1 == e.object1 and event.object2 == e.object2) or (event.object1 == e.object2 and event.object2 == e.object1)) and event.birthday == e.birthday then
			duplicate = true
		end
	end
	
	if not duplicate then
		table.insert(self.events, event)
		event:output()
	end
end

function EventHandler:update(dt)
	for i, event in ipairs(self.events) do -- loop through and remove dead events
		if event:isKill() then
			table.remove(self.events, i)
		end
	end
end