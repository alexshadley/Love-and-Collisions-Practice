Object = {}

function Object:isOfSet(set)
	for _, item in ipairs(set) do
		if self.tag == item then
			return true
		end
	end
	
	return false
end