local component = require "comp/component"
local shadeable = class("shadeable", component)

function shadeable:initialize(args)
	component.initialize(self, args)
	self.type = "shadeable"

	self.inShade = false
end

function shadeable:update(dt)
	if self.inShade then
		self.parent.img.color = {r=0.5, g=0.5, b=0.5}
	else
		self.parent.img.color = {r=1, g=1, b=1}
	end

	self.inShade = false
end

function shadeable:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "shade" then
			self.inShade = true
		end
	end
end

return shadeable