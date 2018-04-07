local inputManager = class("inputManager")

function inputManager:initialize(parent)
	self.game = parent
	
	self.bind = {
		a = "left",
		d = "right",
		w = "up",
		s = "down",
		m = "mute",
		q = "debug",
		mouse1 = "attack"
	}
	
	self.map = {
		attack = self.attack,
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

function inputManager:mousepressed(x, y, button)
	if self.map[self.bind["mouse"..button]] ~= nil then
		self.map[self.bind["mouse"..button]](self, x, y)
	end
end

function inputManager:attack(x, y)
	x, y = self.game.camMan:worldPos(x, y)
	self.game.player.attack:attack(x, y)
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