EventHandler = {}

function EventHandler:new()
	local o = {}
	setmetatable(o, {__index = self})
	
	o.events = {}
	
	return o
end

function EventHandler:add(event)
	table.insert(self.events, event)
	event:output()
end

function EventHandler:update()
	for _, event in ipairs(self.events) do -- loop through and remove dead events
		if event.isKill then
			table.remove(self.events, event)
		end
	end
end