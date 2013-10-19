function love.load ()
	require "setup"
	
	states = { ["menu"]=menu, ["game"]=game }
	current_state = "game"
	
	init = true
end

function love.draw ()
	if states[current_state] then
		states[current_state].draw( dt )
	end
end

function love.update ( dt )
	if init and states[current_state] then
		states[current_state].init()
		init = false
	end
	if states[current_state] then
		states[current_state].update( dt )
	end
end

function love.mousepressed ( x, y, button )
	if states[current_state] then
		states[current_state].mousepressed( x, y, button )
	end
end

function love.mousereleased ( x, y, button )
	if states[current_state] then
		states[current_state].mousereleased( x, y, button )
	end
end

function love.keypressed ( key )
	if states[current_state] then
		states[current_state].keypressed( key )
	end
end
