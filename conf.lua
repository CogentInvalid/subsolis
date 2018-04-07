function love.conf(t)
	t.window.title = "VIDEO GAME"
	t.window.width = 800
	t.window.height = 600
	t.window.resizable = false
	t.window.vsync = false

	t.modules.joystick = false
	t.modules.physics = false
end