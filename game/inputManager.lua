local inputManager = class("inputManager")

function inputManager:initialize(parent)
	self.game = parent
	
	self.bind = {
		a = "left",
		d = "right",
		w = "up",
		s = "down",
		m = "mute",
		q = "debug"
	}
	
	self.map = {
		jump = self.jump,
		mute = self.mute,
		debug = self.debug
	}
	
end

function inputManager:update(dt)
end

function inputManager:keypressed(key)
	if self.map[self.bind[key]] ~= nil then
		self.map[self.bind[key]](self)
	end
end

function inputManager:debug()
end

function inputManager:mute()
	audio:mute()
end

--returns true if any of the keys for a particular bind are pressed.
function inputManager:keyDown(bind)
	for key, b in pairs(self.bind) do
		if bind == b then
			if keyDown(key) then return true end
		end
	end
	return false
end

return inputManager